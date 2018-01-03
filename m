From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add
 db820c machine driver
Date: Wed, 3 Jan 2018 11:41:51 -0800
Message-ID: <20180103194151.GA21040@codeaurora.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
 <4db358ab-3171-bb08-ca26-ec9bf282e8d4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id E279F2676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 20:41:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4db358ab-3171-bb08-ca26-ec9bf282e8d4@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/03, Srinivas Kandagatla wrote:
> Thanks for your review comments,
> 
> On 03/01/18 17:20, Stephen Boyd wrote:
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static int msm_snd_apq8096_probe(struct platform_device *pdev)
> >>+{
> >>+	int ret;
> >>+	struct snd_soc_card *card;
> >>+
> >>+	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
> >>+	if (!card)
> >>+		return -ENOMEM;
> >>+
> >>+	card->dev = &pdev->dev;
> >>+
> >>+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
> >
> >Why do we need to do this? Can you add some sort of comment in the code
> >about why?
> 
> Even though dsp supports 64 bit addresses, but the sid sits at
> offset of 32, which brings this restriction of supporting only 32
> bit iova.
> 

Doesn't the dsp have an iommu in place to make the address
translation from 64 to 32 bits transparent? I thought this was
what dma-ranges and iommu binding was for, but I'm not well
versed on all the details here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
