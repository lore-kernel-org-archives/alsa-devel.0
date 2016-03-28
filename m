From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/4] ASoC: dwc: Add I2S HDMI audio support using custom
 platform driver
Date: Mon, 28 Mar 2016 11:55:45 +0000
Message-ID: <1459166144.4785.77.camel@synopsys.com>
References: <cover.1458839710.git.joabreu@synopsys.com>
	 <7aaad0b57652fc724be7b447790c194645321173.1458839710.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7aaad0b57652fc724be7b447790c194645321173.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <ECB7E75C2B095246BF11DCB9F212BC46-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mjonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <mjonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "lgirdwoord-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwoord-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Jose,

On Mon, 2016-03-28 at 10:41 +-0100, Jose Abreu wrote:
+AD4- HDMI audio support was added to the AXS board using an
+AD4- I2S cpu driver and a custom platform driver.
+AD4- 
+AD4- The platform driver supports two channels +AEA- 16 bits with
+AD4- rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
+AD4- glue the cpu, platform and codec driver (adv7511).
+AD4- 
+AD4- Signed-off-by: Jose Abreu +ADw-joabreu+AEA-synopsys.com+AD4-
+AD4- ---
+AD4- +AKA-arch/arc/boot/dts/axs10x+AF8-mb.dtsi +AHwAoACg-20 +--

You should not mix DT bindings for a particular board with generic driver
fixes or improvements.

I think it makes sense to split this patch in 2:
+AKA-1) Driver improvements
+AKA-2) .dts update for boards that use this driver

+AD4- +AKA-sound/soc/dwc/Kconfig+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-1 +-
+AD4- +AKA-sound/soc/dwc/designware+AF8-i2s.c+AKAAoACgAHw- 384 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
+AD4- +AKA-3 files changed, 388 insertions(+-), 17 deletions(-)

-Alexey--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
