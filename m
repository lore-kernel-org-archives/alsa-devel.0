From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 1/9] ARM: DaVinci: ASoC: Adds ASoC
	driver	support for TI DM646X EVM platform
Date: Wed, 18 Mar 2009 17:07:32 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B095@dbde02.ent.ti.com>
References: <1237204945-30039-1-git-send-email-naresh@ti.com>,
	<20090316145659.GC16539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 74D8A243E4
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 12:38:15 +0100 (CET)
In-Reply-To: <20090316145659.GC16539@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I will re-work on this and re-submit the patch.

Regards
Naresh
________________________________________
From: Mark Brown [broonie@sirena.org.uk]
Sent: Monday, March 16, 2009 8:27 PM
To: Medisetty, Naresh
Cc: davinci-linux-open-source@linux.davincidsp.com; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 1/9] ARM: DaVinci: ASoC: Adds ASoC driver      support for TI DM646X EVM platform

On Mon, Mar 16, 2009 at 08:02:25AM -0400, Naresh Medisetty wrote:
> Adds ASoC driver support for TI DM646X EVM platform

Your changelog needs to be a bit more verbose here...

> +#include "../codecs/codec_stubs.h"

Interesting...

> +static struct resource dm6467_evm_snd_resources[] = {
> +     {
> +             .start = DAVINCI_DM646X_MCASP0_REG_BASE,
> +             .end = DAVINCI_DM646X_MCASP0_REG_BASE + (SZ_1K << 1) - 1,
> +             .flags = IORESOURCE_MEM,
> +     },

Take a look at how the s3c24xx_uda134x driver handles getting platform
data for the device.

> +static struct evm_snd_platform_data dm6467_evm_snd_data[] = {
> +     {
> +             .clk_name       = "McASPCLK0",
> +             .tx_dma_ch      = DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
> +             .rx_dma_ch      = DAVINCI_DM646X_DMA_MCASP0_AREVT0,
> +             .tx_dma_offset  = 0x400,
> +             .rx_dma_offset  = 0x400,
> +             .op_mode        = DAVINCI_MCASP_IIS_MODE,
> +             .num_serializer = 4,
> +             .tdm_slots      = 2,
> +             .serial_dir     = dm6467_iis_serializer_direction,
> +             .eventq_no      = EVENTQ_0,
> +             .codec_fmt      = SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF,
> +     },

Lots of this stuff looks like it ought to be part of the driver for the
DAI rather than part of the machine driver.

>
> -     if (machine_is_davinci_evm()) {
> +     if (cpu_is_davinci_dm644x()) {
>               davinci_cfg_reg(DM644X_MCBSP);

This really should be checking for the machine - presumably it needs to
check for both the EVM and the particular CPU variant that's fitted on
it.
