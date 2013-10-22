From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Tue, 22 Oct 2013 02:20:29 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82866F8C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id CD94D2651BD
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 04:20:35 +0200 (CEST)
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "oskar@scara.com" <oskar@scara.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, broonie
List-Id: alsa-devel@alsa-project.org


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

Yes, the dma engine interface has already parsed the slave_id while
the dma customer requesting one dma channel.

Though this also could be a way to pass the slave_id to dma driver, but the 
dma driver uses the way while requesting dma channels.

So I'll drop this code later.
