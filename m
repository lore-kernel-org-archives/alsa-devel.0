From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH 00/14] ASoC: qcom: add support to apq8016 audio
Date: Tue, 5 May 2015 22:47:58 -0700
Message-ID: <20150506054758.GD5639@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150502235704.GA27804@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150502235704.GA27804-VfhoOQ2zEbNBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 02, 2015 at 04:57:04PM -0700, Kenneth Westfield wrote:
> On Thu, Apr 30, 2015 at 06:15:48PM +0100, Srinivas Kandagatla wrote:
> > Hi All,
> > 
> > This patchset adds apq8016 audio support into lpass driver. Existing
> Lpass
> > driver can not be used as-it-is for apq8016 as it contains code specific
> to
> > ipq806x. Also the driver only supports single i2s port, single dma
> channel and
> > single bitclk control.
> > 
> > APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can
> be routed
> > to internal wcd codec or external codecs. This routing is controlled by
> 2 mux
> > registers.
> > 
> > This patch series firstly re-organizes the lpass driver such that the
> SOC
> > specific bits are moved away from the driver. And secondly the SOC
> specifics
> > are now passed as lpass variant data which would include various
> register
> > offsets, dma channel allocations and SOC specific clock handling.
> > 
> > Finally the patchset add apq8016 lpass and machine driver.
> > 
> > This patchset also has two trivial cleanup patches which are to do with
> > redundant checks and removing unnecessary header files.
> > 
> > All these patches are tested for HDMI audio via adv7533 bridge and
> Analog audio
> > on APQ8016-SBC and msm8916-mtp boards. I dont have access to ipq806x
> boards to
> > test these patches.
> > 
> > This is very first version of the patches which was developed with very
> > mimimal/no access to IP documentation. I would like to get your opinon
> on the
> > over all approch.
> > 
> > 
> > Kenneth/Patrick,
> > 	Could you please try these patches on storm board?
> 
> I will test the patches and let you know by Wednesday.  Also, I posted
> some comments, but Patrick should be posting his comments separately
> later next week.

Srinivas,

After applying the patches, audio playback is no longer functional on
the storm board.  Give me some time to debug this and I will get back
to you.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
