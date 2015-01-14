From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] unload Audio drivers while playback stream is active
 case kernel crash
Date: Wed, 14 Jan 2015 11:43:54 -0200
Message-ID: <CAOMZO5AQEyb9in0hRn+7zcpE5r8zwVUFjCqAqNOmLMCGYka3Pg@mail.gmail.com>
References: <857E9EDCA6C0904DB3357321AA9123EB0108B66919@NA-MBX-01.mgc.mentorg.com>
	<s5h1tmyiof7.wl-tiwai@suse.de>
	<20150113215412.GS4160@sirena.org.uk>
	<s5hr3ux24em.wl-tiwai@suse.de>
	<54B625A8.8090406@metafoo.de>
	<s5hoaq121gh.wl-tiwai@suse.de>
	<54B63E4F.2010506@metafoo.de>
	<s5hwq4phbzr.wl-tiwai@suse.de>
	<20150114120228.GT4160@sirena.org.uk>
	<54B6679F.1030706@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54B6679F.1030706@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, "Wang, Jiada (ESD)" <Jiada_Wang@mentor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 14, 2015 at 10:57 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> My personal opinion on this is that disallowing module removal while a
> driver registered by the module when is in use, while there is no technical
> reason to do so, is a anti-feature. Whether in ALSA or elsewhere.
>
> But looking at the source it seems that this is a core feature of ALSA and
> at least for the card module itself it will do the ref-counting when a
> stream is started/stopped. And we even support setting the owner of a card
> in ASoC. It's just that pretty much no ASoC card driver bothers to set the
> owner field in the snd_soc_card struct. So this particular problem can be
> fixed by updating the imx-wm8962 driver to set the owner field.

Thanks, Lars_Peter. This fixes the issue:

root@freescale /$ modprobe -r snd_soc_imx_wm8962
modprobe: can't unload module snd_soc_imx_wm8962: Resource temporarily
unavailable

Will send a patch with your suggestion soon.
