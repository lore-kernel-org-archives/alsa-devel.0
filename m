From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 00/13] ASoC: qcom: add support to apq8016 audio
Date: Sun, 17 May 2015 09:15:11 -0700
Message-ID: <20150517161510.GC10901@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431779462-1732-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 16, 2015 at 05:31:02AM -0700, Srinivas Kandagatla wrote:
> Thankyou for reviewing the v1 patches, here is the v2 patchset after
> incorporating review comments and testing on Storm Board.
> This patchset adds apq8016 audio support into lpass driver. Existing
> Lpass driver can not be used as-it-is for apq8016 as it contains code
> specific to ipq806x. Also the driver only supports single i2s port,
> single dma channel and single bitclk control.
> 
> APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be
> routed
> to internal wcd codec or external codecs. This routing is controlled by 2
> mux
> registers.
> 
> This patch series firstly re-organizes the lpass driver such that the SOC
> specific bits are moved away from the driver. And secondly the SOC
> specifics
> are now passed as lpass variant data which would include various register
> offsets, dma channel allocations and SOC specific clock handling.
> 
> Finally the last few patchs add apq8016 lpass and machine driver.
> 
> All these patches are tested for HDMI audio via adv7533 bridge and Analog
> audio
> on APQ8016-SBC, msm8916-mtp boards and Kenneth tested this patchset on
> ipq806x Storm board too.

Other than the two comments on patches 5 and 6, everything else looks
fine to me.

Acked-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
