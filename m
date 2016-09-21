From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: snd-usb-line6 depends on CONFIG_SND_HWDEP
Date: Wed, 21 Sep 2016 10:56:05 +0900
Message-ID: <046fe4be-f3e8-0088-8b1d-ed94bb9ef914@sakamocchi.jp>
References: <86590.1474409693@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86590.1474409693@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sep 21 2016 07:14, Valdis Kletnieks wrote:
> ALSA - snd-usb-line6 depends on CONFIG_SND_HWDEP
>
> ERROR: "snd_hwdep_new" [sound/usb/line6/snd-usb-line6.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

As a nitpicking, I think it better to change the subject line with a 
prefix of 'ALSA: line6:' or 'ALSA: usb-line6:', following to our fashion.

> diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
> index 8ffcf48097d9..39b400392d71 100644
> --- a/sound/usb/line6/Kconfig
> +++ b/sound/usb/line6/Kconfig
> @@ -2,6 +2,7 @@ config SND_USB_LINE6
>  	tristate
>  	select SND_RAWMIDI
>  	select SND_PCM
> +	select SND_HWDEP
>
>  config SND_USB_POD
>  	tristate "Line 6 POD USB support"


Thanks

Takashi Sakamoto
