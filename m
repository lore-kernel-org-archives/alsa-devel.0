From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Mon, 28 Oct 2013 05:58:42 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 by alsa0.perex.cz (Postfix) with ESMTP id C356F26109C
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 06:58:46 +0100 (CET)
In-Reply-To: <526021B0.6050206@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "djbw@fb.com" <djbw@fb.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, Lars-Peter Clausen <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "oskar@scara.com" <oskar@scara.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, rob.herring@calxeda.co
List-Id: alsa-devel@alsa-project.org

Hi Dan, Vinod,


> > +static int fsl_sai_probe(struct platform_device *pdev) {
> [...]
> > +
> > +	sai->dma_params_rx.addr = res->start + SAI_RDR;
> > +	sai->dma_params_rx.maxburst = 6;
> > +	index = of_property_match_string(np, "dma-names", "rx");
> > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > +				&dma_args);
> > +	if (ret)
> > +		return ret;
> > +	sai->dma_params_rx.slave_id = dma_args.args[1];
> > +
> > +	sai->dma_params_tx.addr = res->start + SAI_TDR;
> > +	sai->dma_params_tx.maxburst = 6;
> > +	index = of_property_match_string(np, "dma-names", "tx");
> > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > +				&dma_args);
> > +	if (ret)
> > +		return ret;
> > +	sai->dma_params_tx.slave_id = dma_args.args[1];
> 
> The driver should not have to manually parse the dma devicetree
> properties, this is something that should be handled by the dma engine
> driver.
> 

What do you think about the DMA slave_id ?
I have been noticed by one colleague that this should be parsed here, which
is from your opinions ?


> > +
> > +	ret = snd_soc_register_component(&pdev->dev, &fsl_component,
> > +			&fsl_sai_dai, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = fsl_pcm_dma_init(pdev);
> > +	if (ret)
> > +		goto out;
