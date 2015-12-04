From: Maeda <maeda1@free.fr>
Subject: Re: [bug] Volume at maximum when track with different
 frequency is played with my RME sound card
Date: Fri, 4 Dec 2015 13:12:41 +0100
Message-ID: <56618339.4000600@free.fr>
References: <562A609E.6070205@free.fr> <5641E608.6060006@free.fr>
 <s5hfv007hpg.wl-tiwai@suse.de> <5650ACEE.5050402@free.fr>
 <s5hwptbxhjf.wl-tiwai@suse.de> <565EC3CF.1090301@free.fr>
 <s5hr3j5axqp.wl-tiwai@suse.de> <565F5804.7050501@free.fr>
 <s5hio4fn674.wl-tiwai@suse.de> <56616E72.20407@free.fr>
 <s5h4mfy1mwm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030703020402010803050009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A0F52614AC
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 13:12:13 +0100 (CET)
In-Reply-To: <s5h4mfy1mwm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030703020402010803050009
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

I've problem with compiling rme96.c (see attachment).
Maybe I forgot something, i double checked, but my rme96.c seems to be go=
od.

Any clue ?

Le 04/12/2015 12:19, Takashi Iwai a =E9crit :
> On Fri, 04 Dec 2015 11:44:02 +0100,
> Maeda wrote:
>> Hi !
>>
>> Well done ! It plays without max loud volume, and no errors on output.
>> I tried with the following test :
>>
>>      `aplay -fcd -d3 /dev/zero ;aplay -r96000 -c2 -d3 /dev/zero
>>      ;speaker-test  -c2 -twav`
>>
>> And it's OK. Then I tried with mplayer and some flac files (44.1 / 48
>> and 96 KHz sample) : no problem.
>>
>> I think you found the solution. If there are some future problem this
>> patch generates, I'll only see when using "it" each day. Then, for now=
,
>> you can commit it ;)
> Good to hear.  Could you try the revised patch below instead?
> It does restore DAC volume at the end, after the spinlock, so that we
> can avoid the ugly delay.
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
> index 714df906249e..e4229d01cf6a 100644
> --- a/sound/pci/rme96.c
> +++ b/sound/pci/rme96.c
> @@ -741,10 +741,11 @@ snd_rme96_playback_setrate(struct rme96 *rme96,
>   	{
>   		/* change to/from double-speed: reset the DAC (if available) */
>   		snd_rme96_reset_dac(rme96);
> +		return 1; /* need to restore volume */
>   	} else {
>   		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
> +		return 0;
>   	}
> -	return 0;
>   }
>  =20
>   static int
> @@ -980,6 +981,7 @@ snd_rme96_playback_hw_params(struct snd_pcm_substre=
am *substream,
>   	struct rme96 *rme96 =3D snd_pcm_substream_chip(substream);
>   	struct snd_pcm_runtime *runtime =3D substream->runtime;
>   	int err, rate, dummy;
> +	bool apply_dac_volume =3D false;
>  =20
>   	runtime->dma_area =3D (void __force *)(rme96->iobase +
>   					     RME96_IO_PLAY_BUFFER);
> @@ -993,24 +995,24 @@ snd_rme96_playback_hw_params(struct snd_pcm_subst=
ream *substream,
>   	{
>                   /* slave clock */
>                   if ((int)params_rate(params) !=3D rate) {
> -			spin_unlock_irq(&rme96->lock);
> -			return -EIO;
> -                }
> -	} else if ((err =3D snd_rme96_playback_setrate(rme96, params_rate(par=
ams))) < 0) {
> -		spin_unlock_irq(&rme96->lock);
> -		return err;
> -	}
> -	if ((err =3D snd_rme96_playback_setformat(rme96, params_format(params=
))) < 0) {
> -		spin_unlock_irq(&rme96->lock);
> -		return err;
> +			err =3D -EIO;
> +			goto error;
> +		}
> +	} else {
> +		err =3D snd_rme96_playback_setrate(rme96, params_rate(params));
> +		if (err < 0)
> +			goto error;
> +		apply_dac_volume =3D err > 0; /* need to restore volume later? */
>   	}
> +	if ((err =3D snd_rme96_playback_setformat(rme96, params_format(params=
))) < 0)
> +		goto error;
>   	snd_rme96_setframelog(rme96, params_channels(params), 1);
>   	if (rme96->capture_periodsize !=3D 0) {
>   		if (params_period_size(params) << rme96->playback_frlog !=3D
>   		    rme96->capture_periodsize)
>   		{
> -			spin_unlock_irq(&rme96->lock);
> -			return -EBUSY;
> +			err =3D -EBUSY;
> +			goto error;
>   		}
>   	}
>   	rme96->playback_periodsize =3D
> @@ -1022,8 +1024,15 @@ snd_rme96_playback_hw_params(struct snd_pcm_subs=
tream *substream,
>   		writel(rme96->wcreg |=3D rme96->wcreg_spdif_stream, rme96->iobase +=
 RME96_IO_CONTROL_REGISTER);
>   	}
>   	spin_unlock_irq(&rme96->lock);
> +	err =3D 0;
>   	=09
> -	return 0;
> + error:
> +	if (apply_dac_volume) {
> +		usleep_range(3000, 10000);
> +		snd_rme96_apply_dac_volume(rme96);
> +	}
> +
> +	return err;
>   }
>  =20
>   static int


--------------030703020402010803050009
Content-Type: text/plain; charset=UTF-8;
 name="rme96.c.errors"
Content-Disposition: attachment;
 filename="rme96.c.errors"
Content-Transfer-Encoding: quoted-printable

  CC [M]  sound/pci/rme96.o
sound/pci/rme96.c: Dans la fonction =E2=80=98snd_rme96_playback_hw_params=
=E2=80=99:
sound/pci/rme96.c:1008:3: erreur: label =E2=80=98error=E2=80=99 used but =
not defined
   goto error;
   ^
sound/pci/rme96.c:1009:2: attention : =C2=AB return =C2=BB manquant dans =
une fonction devant retourner une valeur [-Wreturn-type]
  }
  ^
sound/pci/rme96.c: Hors de toute fonction :
sound/pci/rme96.c:1010:46: erreur: expected =E2=80=98)=E2=80=99 before =E2=
=80=98(=E2=80=99 token
  snd_rme96_setframelog(rme96, params_channels(params), 1);
                                              ^
sound/pci/rme96.c:1011:2: erreur: expected identifier or =E2=80=98(=E2=80=
=99 before =E2=80=98if=E2=80=99
  if (rme96->capture_periodsize !=3D 0) {
  ^
sound/pci/rme96.c:1019:7: erreur: expected =E2=80=98=3D=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__attr=
ibute__=E2=80=99 before =E2=80=98->=E2=80=99 token
  rme96->playback_periodsize =3D
       ^
sound/pci/rme96.c:1021:46: erreur: expected =E2=80=98)=E2=80=99 before =E2=
=80=98->=E2=80=99 token
  snd_rme96_set_period_properties(rme96, rme96->playback_periodsize);
                                              ^
sound/pci/rme96.c:1023:2: erreur: expected identifier or =E2=80=98(=E2=80=
=99 before =E2=80=98if=E2=80=99
  if ((rme96->wcreg & RME96_WCR_ADAT) =3D=3D 0) {
  ^
sound/pci/rme96.c:1027:18: erreur: expected declaration specifiers or =E2=
=80=98...=E2=80=99 before =E2=80=98&=E2=80=99 token
  spin_unlock_irq(&rme96->lock);
                  ^
sound/pci/rme96.c:1028:2: attention : la d=C3=A9finition de donn=C3=A9es =
n'a pas de type ni de classe de stockage
  err =3D 0; =20
  ^
sound/pci/rme96.c:1028:2: erreur: type defaults to =E2=80=98int=E2=80=99 =
in declaration of =E2=80=98err=E2=80=99 [-Werror=3Dimplicit-int]
sound/pci/rme96.c:1029:7: erreur: expected =E2=80=98=3D=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__attr=
ibute__=E2=80=99 before =E2=80=98:=E2=80=99 token
  error:
       ^
sound/pci/rme96.c:1035:2: erreur: expected identifier or =E2=80=98(=E2=80=
=99 before =E2=80=98return=E2=80=99
  return err;
  ^
sound/pci/rme96.c:1036:1: erreur: expected identifier or =E2=80=98(=E2=80=
=99 before =E2=80=98}=E2=80=99 token
 }

--------------030703020402010803050009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030703020402010803050009--
