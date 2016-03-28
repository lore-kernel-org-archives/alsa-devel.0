From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/4] ARC: axs10x: Update defconfigs so that audio is
 enabled
Date: Mon, 28 Mar 2016 11:48:35 +0000
Message-ID: <1459165715.4785.71.camel@synopsys.com>
References: <cover.1458839710.git.joabreu@synopsys.com>
	 <88015401488eed4f253f49d5831be13e0007339f.1458839710.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <88015401488eed4f253f49d5831be13e0007339f.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <462C22C523A78B40B8CDEC882C18F4CC-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mjonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <mjonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "lgirdwoord-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwoord-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Jose,

On Mon, 2016-03-28 at 10:41 +-0100, Jose Abreu wrote:
+AD4- The defconfigs for the AXS boards were updated so that
+AD4- ALSA SoC is enabled and also the audio for the ADV7511
+AD4- HDMI transmitter.
+AD4- 
+AD4- Signed-off-by: Jose Abreu +ADw-joabreu+AEA-synopsys.com+AD4-
+AD4- ---
+AD4- +AKA-arch/arc/configs/axs101+AF8-defconfig+AKAAoACgAKAAoAB8- 3 +-+-+-
+AD4- +AKA-arch/arc/configs/axs103+AF8-defconfig+AKAAoACgAKAAoAB8- 5 +-+-+-+-+-
+AD4- +AKA-arch/arc/configs/axs103+AF8-smp+AF8-defconfig +AHw- 5 +-+-+-+-+-
+AD4- +AKA-3 files changed, 13 insertions(+-)

As Vineet suggested here+AKA-http://lists.infradead.org/pipermail/linux-snps-arc/2016-February/000595.html
let's not pollute axs10x+AF8-defconfigs with new stuff but instead add all new
options to new configs that will cover everything available on ARC SDP boards.

Since those defconfigs for full SDP doesn't exist as of today please drop that change
as well as +ACIAWw-PATCH 4/4+AF0- ARC: axs10x: Update defconfigs so that I2S is enabled+ACI- from that
series.

I'll try to come up with mentioed new configs ASAP and then if your series is
already in upstream I'll add bits for audio through HDMI otherwise you'll add it
in some follow-up series.

-Alexey--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
