From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
 platform drivers
Date: Fri, 25 Jul 2014 14:09:23 +0800
Message-ID: <20140725060920.GA29433@MrMyself>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com> <20140725055447.GC29136@MrMyself>
 <53D1F686.30600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53D1F686.30600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, timur@tabi.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, shawn.guo@linaro.org, b02247@freescale.com, b42378@freescale.com, tklauser@distanz.ch
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 25, 2014 at 11:47:42AM +0530, Varka Bhadram wrote:
> Hi Nicolin,
> 
> On 07/25/2014 11:24 AM, Nicolin Chen wrote:
> >Hi Varka,
> >
> >    Regarding a point you suggested.
> >
> >On Fri, Jul 25, 2014 at 09:54:43AM +0530, Varka Bhadram wrote:
> >>On 07/25/2014 09:33 AM, Nicolin Chen wrote:
> >>(...)
> >>
> >>>+
> >>>+static const struct platform_device_id fsl_asrc_devtype[] = {
> >>>+	{
> >>>+		.name = "imx35-asrc",
> >>>+		.driver_data = IMX35_ASRC,
> >>>+	}, {
> >>>+		.name = "imx53-asrc",
> >>>+		.driver_data = IMX53_ASRC,
> >>>+	}, {
> >>>+		/* sentinel */
> >>>+	}
> >>>+};
> >>>+MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
> >>>+
> >>>+static const struct of_device_id fsl_asrc_ids[] = {
> >>>+	{
> >>>+		.compatible = "fsl,imx35-asrc",
> >>>+		.data = &fsl_asrc_devtype[IMX35_ASRC],
> >>>+	}, {
> >>>+		.compatible = "fsl,imx53-asrc",
> >>>+		.data = &fsl_asrc_devtype[IMX53_ASRC],
> >>>+	}, {
> >>>+		/* sentinel */
> >>>+	}
> >>>+};
> >>>+MODULE_DEVICE_TABLE(of, fsl_asrc_ids);
> >>>+
> >>move these ids after probe/remove... every driver follows same thing...
> >Hmm.. fsl_asrc_ids is called in probe(), so it's probably not a good choice
> >to put them after probe/remove. And actually not every driver does so.
> >For example drivers/i2c/busses/i2c-s3c2410.c
> >
> >I think it should be okay to put here if it contains data.
> 
> You are using these ids in the probe .Tt should be above the probe() so
> we can see of_match_device() directly...
> and also one more thing that the interrupt handler also would be immediately
> above the probe()
> 
> ex:
> static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
> {
> ...
> }
> 
> device ids..
> 
> your_probe()
> {
> ...
> }
> 
> your_remove()
> {
> ...
> }
> 
> Now every driver that is coming following this style...

I see....

Will follow this style.

Thank you!
Nicolin

---
> 
> If your not using device ids in probe then it would be like
> 
> static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
> {
> ...
> }
> 
> your_probe()
> {
> ...
> }
> 
> your_remove()
> {
> ...
> }
> 
> device ids..
> 
> Thanks...
> 
> -- 
> Regards,
> Varka Bhadram.
> 
