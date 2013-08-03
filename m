From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 4/4] ASoC: kirkwood: change kirkwood-i2s to
	mvebu-pcm-audio and DT doc
Date: Sat, 3 Aug 2013 14:48:55 +0100
Message-ID: <20130803134855.GZ23006@n2100.arm.linux.org.uk>
References: <20130731081858.53413597@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130731081858.53413597@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 08:18:58AM +0200, Jean-Francois Moine wrote:
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index 9844010..4f817a2 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -25,7 +25,7 @@
>  
>  #include "kirkwood.h"
>  
> -#define DRV_NAME	"kirkwood-i2s"
> +#define DRV_NAME	"mvebu-pcm-audio"

This breaks non-DT users of this driver.  The device in arch/arm/mach-kirkwood
is left as "kirkwood-i2s" but the platform device is now called something
different.

>  static struct of_device_id kirkwood_i2s_of_match[] = {
> -	{ .compatible = "marvell,kirkwood-i2s" },
> +	{ .compatible = "marvell,mvebu-pcm-audio" },

You've only just introduced "marvell,kirkwood-i2s" in the previous patch.
Why introduce something and then immediately change its name?  This makes
no sense what so ever.
