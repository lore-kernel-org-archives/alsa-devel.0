From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [alsa-devel] [RFC PATCH 03/14] ASoC: qcom: move ipq806x specific
 bits out of lpass driver.
Date: Tue, 5 May 2015 22:35:44 -0700
Message-ID: <20150506053543.GA5639@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414213-10997-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150502235738.GB27804@kwestfie-linux.qualcomm.com>
 <55486E5E.4010601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55486E5E.4010601-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2015 at 12:16:46AM -0700, Srinivas Kandagatla wrote:
> On 03/05/15 00:57, Kenneth Westfield wrote:
> >On Thu, Apr 30, 2015 at 06:16:53PM +0100, Srinivas Kandagatla wrote:
> >>This patch tries to make the lpass driver more generic by moving the
> >>ipq806x specific bits out of the cpu and platform driver, also allows
> the
> >>SOC specific drivers to add the correct register offsets.
> >>
> >>This patch also renames the register definition header file into more
> >>generic header file.
> >
> >>diff --git a/sound/soc/qcom/lpass-ipq806x.c
> b/sound/soc/qcom/lpass-ipq806x.c
> >>new file mode 100644
> >>index 0000000..8e9a427
> >>--- /dev/null
> >>+++ b/sound/soc/qcom/lpass-ipq806x.c
> >
> >>+static const struct of_device_id ipq806x_lpass_cpu_device_id[] = {
> >>+	{ .compatible = "qcom,lpass-cpu", .data = &ipq806x_data },
> >>+	{}
> >>+};
> >>+MODULE_DEVICE_TABLE(of, ipq806x_lpass_cpu_device_id);
> >
> >Surround with #ifdef CONFIG_OF?
> 
> I was more of thinking adding "depends OF" in Kconfig.

Works for me.

> Is there any possibility that the driver would support non-DT?

Not that I am aware of.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
