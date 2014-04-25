From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal support for
 RT5642
Date: Fri, 25 Apr 2014 16:08:18 -0600
Message-ID: <535ADCD2.8050804@wwwdotorg.org>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 8206626007E
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 00:15:19 +0200 (CEST)
In-Reply-To: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, jarkko.nikula@linux.intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 08:24 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> We have been using rt5640.c codec driver with RT5642 codec chip before commit
> 022d21f004c1 ("ASoC: rt5640: add rt5639 support"). That commits starts using
> device ID reading in reset register for adding device specific controls and
> routes runtime.
> 
> Now since device ID appears to be different between RT5640 and RT5642 the 
> driver doesn't add those controls and routes that are valid also on RT5642.
> 
> Fix this by adding a device ID found by debugging and minimal code for 
> supporting RT5642.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Is this derived from Jarkko's patch? If so, shouldn't he be listed as
the author, not you? If it wasn't, then presumably his S-o-b line
shouldn't be in the patch description.

> Signed-off-by: Bard Liao <bardliao@realtek.com>

This patch causes problems for me. I see an enormous amount of spew
during kernel boot along the lines of:

> [    2.285515] rt5640 0-001c: ASoC: no source widget found for OUT MIXL
> [    2.291899] rt5640 0-001c: ASoC: Failed to add route OUT MIXL -> OUT MIXL Switch -> RECMIXL
> [    2.300306] rt5640 0-001c: ASoC: no source widget found for OUT MIXR
> [    2.306662] rt5640 0-001c: ASoC: Failed to add route OUT MIXR -> OUT MIXR Switch -> RECMIXR
> [    2.315662] rt5640 0-001c: ASoC: no sink widget found for Stereo DAC MIXL

(but repeated for about 28 widget/route pairs)

Perhaps it's related to:

> diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h

> -#define RT5639_RESET_ID				0x0008
> -#define RT5640_RESET_ID				0x000c

These values cover at least bits 3:2.

> +/* SW Reset & Device ID (0x00) */
> +#define RT5640_ID_MASK				(0x3 << 1)
> +#define RT5640_ID_5639				(0x0 << 1)
> +#define RT5640_ID_5640				(0x1 << 1)
> +#define RT5640_ID_5642				(0x3 << 1)

whereas these values cover bits 2:1. Should the shift be 2? Even with
that fixed, the old 5639 value was 2 << 2 but the new value here is 0 <<
2. Similarly, the old 5640 value was 3 <<2 whereas the new value is 1 <<
2. There's obviously quite some confusion here.

The schematic of my board says I have an RT5640, everything worked
before this commit, and register 0 (where these values are stored) reads
as 0xc which matches the RT5640 value before this commit but not after.

I can see why this patch causes the driver to support the wrong chip.
However, I can't imagine why that causes all the log spew at startup.
Perhaps the driver is just broken on RT5639 at present (although I don't
recall seeing any issues when booting on a board that actually had
one...) Is part of the driver keying off this now incorrect ID register
read, yet some other part of the driver registering widgets/routes based
on which entry matched in struct i2c_device_id rt5640_i2c_id, hence
they're falling out of sync due to this change? If so, that seems like
another bug that needs fixing.
