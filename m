From: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>
Subject: Re: Still unhappy with removal of DXS controls
Date: Tue, 06 Jul 2010 22:43:23 +0200
Message-ID: <4C33956B.1060600@gmx.de>
References: <4C3234C1.2060901@gmx.de> <4C330752.3090201@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 494D3246AB
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 22:43:27 +0200 (CEST)
In-Reply-To: <4C330752.3090201@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06.07.2010 12:37, Clemens Ladisch wrote:
> Soeren D. Schulze wrote:
>> Please, even if the solution with the DXS controls in alsamixer didn't
>> comply with the ALSA policies, *it did work*!  The current one *does
>> not*.  Maybe make the maximum (or default?) DXS volume available as a
>> mixer control or as a module option or something -- whatever you
>> consider the best solution.
> =

> Please try this patch:
> =

> --- a/sound/pci/via82xx.c
> +++ b/sound/pci/via82xx.c
> @@ -85,6 +85,7 @@ static int joystick;
>  static int ac97_clock =3D 48000;
>  static char *ac97_quirk;
>  static int dxs_support;
> +static int dxs_init_volume =3D 31;
>  static int nodelay;
>  =

>  module_param(index, int, 0444);
> @@ -103,6 +104,8 @@ module_param(ac97_quirk, charp, 0444);
>  MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
>  module_param(dxs_support, int, 0444);
>  MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 =3D auto, 1 =
=3D enable, 2 =3D disable, 3 =3D 48k only, 4 =3D no VRA, 5 =3D enable any s=
ample rate)");
> +module_param(dxs_init_volume, int, 0644);
> +MODULE_PARM_DESC(dxs_init_volume, "initial DXS volume (0-31)");
>  module_param(nodelay, int, 0444);
>  MODULE_PARM_DESC(nodelay, "Disable 500ms init delay");
>  =

> @@ -1245,8 +1248,10 @@ static int snd_via8233_playback_open(struct snd_pc=
m_substream *substream)
>  		return err;
>  	stream =3D viadev->reg_offset / 0x10;
>  	if (chip->dxs_controls[stream]) {
> -		chip->playback_volume[stream][0] =3D 0;
> +		chip->playback_volume[stream][0] =3D
> +				VIA_DXS_MAX_VOLUME - (dxs_init_volume & 31);
> -		chip->playback_volume[stream][1] =3D 0;
> +		chip->playback_volume[stream][1] =3D
> +				VIA_DXS_MAX_VOLUME - (dxs_init_volume & 31);
>  		chip->dxs_controls[stream]->vd[0].access &=3D
>  			~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
>  		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE |

Thanks a lot, it works just fine.

A short test (using only the ears) shows that 24 might be a good value,
perhaps even a bit lower.

Is there a chance to get this upstream so I can update the wiki?


S=F6ren
