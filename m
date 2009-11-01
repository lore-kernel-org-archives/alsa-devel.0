From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] cs4236: detect cs4236+ chip in one pass
Date: Sun, 1 Nov 2009 13:47:37 +0200
Message-ID: <20091101114737.GJ22046@sci.fi>
References: <20091101124738.0eb33f92.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.welho.com (smtp5.welho.com [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 71C3324348
	for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2009 12:47:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091101124738.0eb33f92.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, wim@djo.tudelft.nl, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 01, 2009 at 12:47:38PM +0100, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> =

> The cs4236 was two step detection with call to the snd_wss_free()
> between two steps. The snd_wss_free() did not free a sound device
> created in the snd_wss_create(). This caused an OOPS during module
> removal as the same sound device was released twice. The same OOPS
> happened if the cs4236 module loading failed.
> =

> Fix this by adapting the snd_cs4236_create() to correctly work with
> chips less capable then cs4236. The snd_cs4236_create() behaves the
> same as the snd_wss_create() if the chip is less capable than the cs4236.
> =

> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
<snip>
> @@ -281,83 +285,88 @@ int snd_cs4236_create(struct snd_card *card,
>  	*rchip =3D NULL;
>  	if (hardware =3D=3D WSS_HW_DETECT)
>  		hardware =3D WSS_HW_DETECT3;
> -	if (cport < 0x100) {
> -		snd_printk(KERN_ERR "please, specify control port "
> -			   "for CS4236+ chips\n");
> -		return -ENODEV;
> -	}
> +
>  	err =3D snd_wss_create(card, port, cport,
>  			     irq, dma1, dma2, hardware, hwshare, &chip);
>  	if (err < 0)
>  		return err;
>  =

> -	if (!(chip->hardware & WSS_HW_CS4236B_MASK)) {
> -		snd_printk(KERN_ERR "CS4236+: MODE3 and extended registers "
> -			   "not available, hardware=3D0x%x\n", chip->hardware);
> -		snd_device_free(card, chip);
> -		return -ENODEV;
> -	}
> +	if (chip->hardware & WSS_HW_CS4236B_MASK) {
>  #if 0
> -	{
> -		int idx;
> -		for (idx =3D 0; idx < 8; idx++)
> -			snd_printk(KERN_DEBUG "CD%i =3D 0x%x\n",
> -				   idx, inb(chip->cport + idx));
> -		for (idx =3D 0; idx < 9; idx++)
> -			snd_printk(KERN_DEBUG "C%i =3D 0x%x\n",
> -				   idx, snd_cs4236_ctrl_in(chip, idx));
> -	}
> +		{
> +			int idx;
> +			for (idx =3D 0; idx < 8; idx++)
> +				snd_printk(KERN_DEBUG "CD%i =3D 0x%x\n",
> +					   idx, inb(chip->cport + idx));
> +			for (idx =3D 0; idx < 9; idx++)
> +				snd_printk(KERN_DEBUG "C%i =3D 0x%x\n",
> +					   idx, snd_cs4236_ctrl_in(chip, idx));
> +		}
>  #endif
> -	ver1 =3D snd_cs4236_ctrl_in(chip, 1);
> -	ver2 =3D snd_cs4236_ext_in(chip, CS4236_VERSION);
> -	snd_printdd("CS4236: [0x%lx] C1 (version) =3D 0x%x, ext =3D 0x%x\n", cp=
ort, ver1, ver2);
> -	if (ver1 !=3D ver2) {
> -		snd_printk(KERN_ERR "CS4236+ chip detected, but "
> -			   "control port 0x%lx is not valid\n", cport);
> -		snd_device_free(card, chip);
> -		return -ENODEV;
> -	}
> -	snd_cs4236_ctrl_out(chip, 0, 0x00);
> -	snd_cs4236_ctrl_out(chip, 2, 0xff);
> -	snd_cs4236_ctrl_out(chip, 3, 0x00);
> -	snd_cs4236_ctrl_out(chip, 4, 0x80);
> -	snd_cs4236_ctrl_out(chip, 5, ((IEC958_AES1_CON_PCM_CODER & 3) << 6) | I=
EC958_AES0_CON_EMPHASIS_NONE);
> -	snd_cs4236_ctrl_out(chip, 6, IEC958_AES1_CON_PCM_CODER >> 2);
> -	snd_cs4236_ctrl_out(chip, 7, 0x00);
> -	/* 0x8c for C8 is valid for Turtle Beach Malibu - the IEC-958 output */
> -	/* is working with this setup, other hardware should have */
> -	/* different signal paths and this value should be selectable */
> -	/* in the future */
> -	snd_cs4236_ctrl_out(chip, 8, 0x8c);
> -	chip->rate_constraint =3D snd_cs4236_xrate;
> -	chip->set_playback_format =3D snd_cs4236_playback_format;
> -	chip->set_capture_format =3D snd_cs4236_capture_format;
> +		if (cport < 0x100 || cport =3D=3D SNDRV_AUTO_PORT) {
> +			snd_printk(KERN_ERR "please, specify control port "
> +				   "for CS4236+ chips\n");

Missing a call to snd_device_free() here.

> +			return -ENODEV;
> +		}

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
