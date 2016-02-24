From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/4 RESEND] ARC: axs10x: Update defconfigs so that audio
 is enabled
Date: Wed, 24 Feb 2016 14:12:00 +0000
Message-ID: <1456323120.3392.31.camel@synopsys.com>
References: <cover.1456234503.git.joabreu@synopsys.com>
	 <174bd675951f46071d0db8ea1f67abb083053332.1456234503.git.joabreu@synopsys.com>
	 <C2D7FE5348E1B147BCA15975FBA23075F4E8BD53@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8BD53-cALIpNOex2c3t6iM5Z/N3fufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Content-Language: en-US
Content-ID: <18363468EE3BC94E9F05F105EB9E577D-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Vineet,

On Wed, 2016-02-24 at 04:36 +-0000, Vineet Gupta wrote:
+AD4- On Tuesday 23 February 2016 07:22 PM, Jose Abreu wrote:
+AD4- +AD4- The defconfigs for the AXS boards were updated so that
+AD4- +AD4- ALSA SoC is enabled and also the audio for the ADV7511
+AD4- +AD4- HDMI transmitter.
+AD4- +AD4- 
+AD4- +AD4- Signed-off-by: Jose Abreu +ADw-joabreu+AEA-synopsys.com+AD4-
+AD4- +AD4- ---
+AD4- +AD4- +AKA-arch/arc/configs/axs101+AF8-defconfig+AKAAoACgAKAAoAB8- 3 +-+-+-
+AD4- +AD4- +AKA-arch/arc/configs/axs103+AF8-defconfig+AKAAoACgAKAAoAB8- 5 +-+-+-+-+-
+AD4- +AD4- +AKA-arch/arc/configs/axs103+AF8-smp+AF8-defconfig +AHw- 5 +-+-+-+-+-
+AD4- 
+AD4- +AEA-Alexey, has this been tested on AXS103. Do we have the right PLL / clocks to get
+AD4- the audio rates - given the lower master clk.

I think I tried first version of these patches on axs103 as well.
But may assume Jose have no access to axs103 and so this particular
implementation may lack tests on axs103 platform. Still this is easy to
fix - I'll try it myself now.

+AD4- Further per out off-list discussion - let us have a seperate config for ARC HS SDP
+AD4- which supports the shipping single hardware configuration and add these fancy
+AD4- things there as well as bumping the clk rate to 100 MHz . Current axs103+ACo- configs
+AD4- are more of developer configs and I don't want to bloat their code with things we
+AD4- don't build / download 10 times a day +ACE-

Agree but first we need to introduce those additional configs.
Let me draft those.

In the meantime it would be helpful if you take a look at existing axs10x+AF8-defconfigs
and check which option you do want to keep and what are those extra once that should
go to new configs with all bells and whistles.


-Alexey--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
