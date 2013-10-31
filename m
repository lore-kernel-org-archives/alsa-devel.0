From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/4] dma: imx-sdma: Add sdma firmware version 2 support
Date: Thu, 31 Oct 2013 08:29:07 +0100
Message-ID: <20131031072907.GG24559@pengutronix.de>
References: <cover.1383197521.git.b42378@freescale.com>
 <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>
Cc: timur@tabi.org, shawn.guo@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 31, 2013 at 02:32:03PM +0800, Nicolin Chen wrote:
> On i.MX5/6 series, SDMA is using new version firmware to support SSI
> dual FIFO feature and HDMI Audio (i.MX6Q/DL only). Thus add it.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
> diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
> index 3a39428..14ca582 100644
> --- a/include/linux/platform_data/dma-imx-sdma.h
> +++ b/include/linux/platform_data/dma-imx-sdma.h
> @@ -43,6 +43,9 @@ struct sdma_script_start_addrs {
>  	s32 dptc_dvfs_addr;
>  	s32 utra_addr;
>  	s32 ram_code_start_addr;

You could add a comment here, like: /* End of v1 array */

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> +	s32 mcu_2_ssish_addr;
> +	s32 ssish_2_mcu_addr;
> +	s32 hdmi_dma_addr;
>  };
>  
>  /**
> -- 
> 1.8.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
