From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: alc5632: rename volume/switch
 contols for master and speaker volumes.
Date: Mon, 14 Nov 2011 21:39:16 +0000
Message-ID: <20111114213915.GH6528@opensource.wolfsonmicro.com>
References: <1321213993-27920-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B12DE243E0
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:39:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321213993-27920-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 13, 2011 at 09:53:13PM +0200, Leon Romanovsky wrote:

> -	SOC_DOUBLE_TLV("Line Playback Volume",
> +	SOC_DOUBLE_TLV("Speaker Playback Volume",
>  			ALC5632_SPK_OUT_VOL, 8, 0, 31, 1, hp_tlv),

This looks really suspicious, why are we renaming the line output as a
speaker output?  This might be appropriate on your board but if the
drivers aren't part of the CODEC it might not be appropriate on another
board.

>  			ALC5632_LINE_IN_VOL, 8, 0, 31, 1, vol_tlv),
> -	SOC_DOUBLE_TLV("Stereo DAC Playback Volume",
> +	SOC_DOUBLE_TLV("Master Playback Volume",
>  			ALC5632_STEREO_DAC_IN_VOL, 8, 0, 63, 1, vdac_tlv),
> -	SOC_DOUBLE("Stereo DAC Playback Switch",
> +	SOC_DOUBLE("Master Playback Switch",

This looks fine.
