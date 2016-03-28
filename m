From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Mon, 28 Mar 2016 15:35:46 +0000
Message-ID: <1459179345.4785.127.camel@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
	 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <D533C2D92E58CE4BB310C77670328C05-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org" <yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak@codea>
List-Id: alsa-devel@alsa-project.org

Hi Jose,

On Mon, 2016-03-28 at 15:36 +-0100, Jose Abreu wrote:
+AD4- HDMI audio support was added to the AXS board using an
+AD4- I2S cpu driver and a custom platform driver.
+AD4- 
+AD4- The platform driver supports two channels +AEA- 16 bits with
+AD4- rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
+AD4- glue the cpu, platform and codec driver (adv7511).
+AD4- 
+AD4- Signed-off-by: Jose Abreu +ADw-joabreu+AEA-synopsys.com+AD4-
+AD4- ---
+AD4- 
+AD4- No changes v1 -+AD4- v2.
+AD4- 
+AD4- +AKA-sound/soc/dwc/Kconfig+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-1 +-
+AD4- +AKA-sound/soc/dwc/designware+AF8-i2s.c +AHw- 385 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
+AD4- +AKA-2 files changed, 373 insertions(+-), 13 deletions(-)
+AD4- 
+AD4- diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
+AD4- index d50e085..bc3fae7 100644
+AD4- --- a/sound/soc/dwc/Kconfig
+AD4- +-+-+- b/sound/soc/dwc/Kconfig
+AD4- +AEAAQA- -2,6 +-2,7 +AEAAQA- config SND+AF8-DESIGNWARE+AF8-I2S
+AD4- +AKA-	tristate +ACI-Synopsys I2S Device Driver+ACI-
+AD4- +AKA-	depends on CLKDEV+AF8-LOOKUP
+AD4- +AKA-	select SND+AF8-SOC+AF8-GENERIC+AF8-DMAENGINE+AF8-PCM
+AD4- +-	select SND+AF8-SIMPLE+AF8-CARD
+AD4- +AKA-	help
+AD4- +AKA-	+AKA-Say Y or M if you want to add support for I2S driver for
+AD4- +AKA-	+AKA-Synopsys desigwnware I2S device. The device supports upto
+AD4- diff --git a/sound/soc/dwc/designware+AF8-i2s.c b/sound/soc/dwc/designware+AF8-i2s.c
+AD4- index bff258d..0f2f588 100644
+AD4- --- a/sound/soc/dwc/designware+AF8-i2s.c
+AD4- +-+-+- b/sound/soc/dwc/designware+AF8-i2s.c
+AD4- +AEAAQA- -84,11 +-84,37 +AEAAQA-
+AD4- +AKAAIw-define MAX+AF8-CHANNEL+AF8-NUM		8
+AD4- +AKAAIw-define MIN+AF8-CHANNEL+AF8-NUM		2
+AD4- +AKA-
+AD4- +-/+ACo- FPGA Version Info +ACo-/
+AD4- +-+ACM-define FPGA+AF8-VER+AF8-INFO	0xE0011230
+AD4- +-+ACM-define FPGA+AF8-VER+AF8-27M	0x000FBED9
+AD4- +-
+AD4- +-/+ACo- PLL registers addresses +ACo-/
+AD4- +-+ACM-define PLL+AF8-IDIV+AF8-ADDR	0xE00100A0
+AD4- +-+ACM-define PLL+AF8-FBDIV+AF8-ADDR	0xE00100A4
+AD4- +-+ACM-define PLL+AF8-ODIV0+AF8-ADDR	0xE00100A8
+AD4- +-+ACM-define PLL+AF8-ODIV1+AF8-ADDR	0xE00100AC

Well I think all is not acceptable.
See all these+AKA-FPGA+AF8-VER+AF8-xxx as well as+AKA-PLL+AF8-xxx
are strictly ARC SDP specific things and have nothing to do with generic driver.

That's so pity we don't have a driver for all clocks/PLLs on ARC SDP yet.
So as of now I may only propose to use hard-coded fixed clocks as I did with
ARC PGU, see +ACI-pguclk+ACI- here:
http://lists.infradead.org/pipermail/linux-snps-arc/2016-March/000790.html

Again I'll try to implement missing clock driver sometime soon because
more and more stuff requires it but for now let's use a work-around.

+AD4- +-struct dw+AF8-i2s+AF8-pll +AHs-
+AD4- +-	unsigned int rate+ADs-
+AD4- +-	unsigned int data+AF8-width+ADs-
+AD4- +-	unsigned int idiv+ADs-
+AD4- +-	unsigned int fbdiv+ADs-
+AD4- +-	unsigned int odiv0+ADs-
+AD4- +-	unsigned int odiv1+ADs-
+AD4- +-+AH0AOw-
+AD4- +-
+AD4- +-static const struct dw+AF8-i2s+AF8-pll dw+AF8-i2s+AF8-pll+AF8-cfg+AF8-27m+AFsAXQ- +AD0- +AHs-
+AD4- +-	/+ACo- 27Mhz +ACo-/
+AD4- +-	+AHs- 32000, 16, 0x104, 0x451, 0x10E38, 0x2000 +AH0-,
+AD4- +-	+AHs- 44100, 16, 0x104, 0x596, 0x10D35, 0x2000 +AH0-,
+AD4- +-	+AHs- 48000, 16, 0x208, 0xA28, 0x10B2C, 0x2000 +AH0-,
+AD4- +-	+AHs- 0, 0, 0, 0, 0, 0 +AH0-,
+AD4- +AKAAfQA7-
+AD4- +AKA-
+AD4- +-static const struct dw+AF8-i2s+AF8-pll dw+AF8-i2s+AF8-pll+AF8-cfg+AF8-28m+AFsAXQ- +AD0- +AHs-
+AD4- +-	/+ACo- 28.224Mhz +ACo-/
+AD4- +-	+AHs- 32000, 16, 0x82, 0x105, 0x107DF, 0x2000 +AH0-,
+AD4- +-	+AHs- 44100, 16, 0x28A, 0x1, 0x10001, 0x2000 +AH0-,
+AD4- +-	+AHs- 48000, 16, 0xA28, 0x187, 0x10042, 0x2000 +AH0-,
+AD4- +-	+AHs- 0, 0, 0, 0, 0, 0 +AH0-,
+AD4- +-+AH0AOw-

These 2 hunks as well should go in ARC SDP clocks.

+AD4- +-static int i2s+AF8-pll+AF8-cfg(struct i2s+AF8-clk+AF8-config+AF8-data +ACo-config)
+AD4- +-+AHs-
+AD4- +-	const struct dw+AF8-i2s+AF8-pll +ACo-pll+AF8-cfg+ADs-
+AD4- +-	u32 rate +AD0- config-+AD4-sample+AF8-rate+ADs-
+AD4- +-	u32 data+AF8-width +AD0- config-+AD4-data+AF8-width+ADs-
+AD4- +-	int i+ADs-
+AD4- +-
+AD4- +-	if (readl((void +ACo-)FPGA+AF8-VER+AF8-INFO) +ADwAPQ- FPGA+AF8-VER+AF8-27M)
+AD4- +-		pll+AF8-cfg +AD0- dw+AF8-i2s+AF8-pll+AF8-cfg+AF8-27m+ADs-
+AD4- +-	else
+AD4- +-		pll+AF8-cfg +AD0- dw+AF8-i2s+AF8-pll+AF8-cfg+AF8-28m+ADs-
+AD4- +-
+AD4- +-	for (i +AD0- 0+ADs- pll+AF8-cfg+AFs-i+AF0-.rate +ACEAPQ- 0+ADs- i+-+-) +AHs-
+AD4- +-		if ((pll+AF8-cfg+AFs-i+AF0-.rate +AD0APQ- rate) +ACYAJg-
+AD4- +-				(pll+AF8-cfg+AFs-i+AF0-.data+AF8-width +AD0APQ- data+AF8-width)) +AHs-
+AD4- +-			writel(pll+AF8-cfg+AFs-i+AF0-.idiv, (void +ACo-)PLL+AF8-IDIV+AF8-ADDR)+ADs-
+AD4- +-			writel(pll+AF8-cfg+AFs-i+AF0-.fbdiv, (void +ACo-)PLL+AF8-FBDIV+AF8-ADDR)+ADs-
+AD4- +-			writel(pll+AF8-cfg+AFs-i+AF0-.odiv0, (void +ACo-)PLL+AF8-ODIV0+AF8-ADDR)+ADs-
+AD4- +-			writel(pll+AF8-cfg+AFs-i+AF0-.odiv1, (void +ACo-)PLL+AF8-ODIV1+AF8-ADDR)+ADs-
+AD4- +-			return 0+ADs-
+AD4- +-		+AH0-
+AD4- +-	+AH0-
+AD4- +-
+AD4- +-	return -EINVAL+ADs-
+AD4- +-+AH0-

Ditto.

-Alexey--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
