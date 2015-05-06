From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 00/14] ASoC: qcom: add support to apq8016 audio
Date: Wed, 06 May 2015 07:54:16 +0100
Message-ID: <5549BA98.9080501@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235704.GA27804@kwestfie-linux.qualcomm.com> <20150506054758.GD5639@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150506054758.GD5639-VfhoOQ2zEbNBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Kenneth,

On 06/05/15 06:47, Kenneth Westfield wrote:
>> >
>> >I will test the patches and let you know by Wednesday.  Also, I posted
>> >some comments, but Patrick should be posting his comments separately
>> >later next week.
> Srinivas,
>
> After applying the patches, audio playback is no longer functional on
> the storm board.  Give me some time to debug this and I will get back
> to you.
I found atleast one issue with rdma audif bits in ipq806x lpass

could you try change, this will be fixed properly in next version.

-----------------------><---------------------------------------------
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 11a7053..2b00355 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -69,6 +69,7 @@ struct lpass_variant ipq806x_data = {
         .rdma_reg_base          = 0x6000,
         .rdma_reg_stride        = 0x1000,
         .rdma_channels          = 4,
+       .rdmactl_audif_start    = 4,
         .dai_driver             = &lpass_cpu_dai_driver,
         .num_dai                = 1,

-----------------------><---------------------------------------------


--srini
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
