From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Fix capture mixers of ALC662 models
Date: Wed, 19 Dec 2007 14:45:32 -0200
Message-ID: <200712191445.33124.herton@mandriva.com.br>
References: <200712182240.31984.herton@mandriva.com.br>
	<s5h3atyx27o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BA33243D5
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 17:45:41 +0100 (CET)
In-Reply-To: <s5h3atyx27o.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com.tw>
List-Id: alsa-devel@alsa-project.org

Em Wednesday 19 December 2007 11:07:23 Takashi Iwai escreveu:
> At Tue, 18 Dec 2007 22:40:31 -0200,
>
> Herton Ronaldo Krzesinski wrote:
> > The below patches fixes capture mixers of ALC662 models. The first one
> > applies to current hg tree, the second one to Linus tree (2.6.24-rcX).
> >
> > The commit that added support for ASUS P701 eeepc also changed the
> > mixers of other ALC662 models, duplicating entries for the Capture
> > items, making them to not work anymore. This fixes it by removing
> > duplicated entries using where possible the common alc662_capture_mixer.
> > Also alc662_capture_mixer should use alc662* functions and not alc882
> > (I checked /proc/asound/card0/codec* on an eepc model and it's ok).
> >
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>
>
> Thanks for the patch.
> It's mostly OK, but the capture-related elements should be removed
> from alc662_base_mixer, too.
>
> Could you check the patch (against HG) below works even with
> model=6stack-dig?

Yes, works fine here, thanks.

>
>
> Takashi
>
> diff -r 6c70857ab613 pci/hda/patch_realtek.c
> --- a/pci/hda/patch_realtek.c	Wed Dec 19 15:37:49 2007 +0100
> +++ b/pci/hda/patch_realtek.c	Wed Dec 19 15:55:48 2007 +0100
> @@ -12335,18 +12335,6 @@ static struct snd_kcontrol_new alc662_ba
>  	HDA_CODEC_MUTE("Mic Playback Switch", 0xb, 0x0, HDA_INPUT),
>  	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0xb, 0x01, HDA_INPUT),
>  	HDA_CODEC_MUTE("Front Mic Playback Switch", 0xb, 0x01, HDA_INPUT),
> -
> -	/* Capture mixer control */
> -	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
> -	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		.name = "Capture Source",
> -		.count = 1,
> -		.info = alc_mux_enum_info,
> -		.get = alc_mux_enum_get,
> -		.put = alc_mux_enum_put,
> -	},
>  	{ } /* end */
>  };
>
> @@ -12364,17 +12352,6 @@ static struct snd_kcontrol_new alc662_3S
>  	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
>  	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
>  	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
> -	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
> -	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		/* .name = "Capture Source", */
> -		.name = "Input Source",
> -		.count = 1,
> -		.info = alc662_mux_enum_info,
> -		.get = alc662_mux_enum_get,
> -		.put = alc662_mux_enum_put,
> -	},
>  	{ } /* end */
>  };
>
> @@ -12398,17 +12375,6 @@ static struct snd_kcontrol_new alc662_3S
>  	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
>  	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
>  	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
> -	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
> -	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		/* .name = "Capture Source", */
> -		.name = "Input Source",
> -		.count = 1,
> -		.info = alc662_mux_enum_info,
> -		.get = alc662_mux_enum_get,
> -		.put = alc662_mux_enum_put,
> -	},
>  	{ } /* end */
>  };
>
> @@ -12422,17 +12388,6 @@ static struct snd_kcontrol_new alc662_le
>  	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
>  	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
>  	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
> -	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
> -	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
> -	{
> -		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> -		/* .name = "Capture Source", */
> -		.name = "Input Source",
> -		.count = 1,
> -		.info = alc662_mux_enum_info,
> -		.get = alc662_mux_enum_get,
> -		.put = alc662_mux_enum_put,
> -	},
>  	{ } /* end */
>  };
>
> @@ -12598,9 +12553,9 @@ static struct snd_kcontrol_new alc662_ca
>  		/* .name = "Capture Source", */
>  		.name = "Input Source",
>  		.count = 1,
> -		.info = alc882_mux_enum_info,
> -		.get = alc882_mux_enum_get,
> -		.put = alc882_mux_enum_put,
> +		.info = alc662_mux_enum_info,
> +		.get = alc662_mux_enum_get,
> +		.put = alc662_mux_enum_put,
>  	},
>  	{ } /* end */
>  };

--
[]'s
Herton
