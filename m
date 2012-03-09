From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with
 imx pcm and machine drivers
Date: Fri, 9 Mar 2012 04:02:40 +0000
Message-ID: <4F5980DE.9050002@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
	<4F591A69.9060401@freescale.com>
	<20120309031909.GJ2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 9847A103ADF
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 05:02:54 +0100 (CET)
In-Reply-To: <20120309031909.GJ2499@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <4B723B892A0D354F9B483A0BC55F74B1@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:

> Ok, got you.  We used to set fifo_depth on imx-ssi not the value given
> by hardware manual, but the one already tuned.

What do you mean by "already tuned".  Tuned by whom?

>>> +		 */
>>> +		ssi_private->dma_params_tx.burstsize =
>>> +			ssi_private->fifo_depth - 2;
>>> +		ssi_private->dma_params_rx.burstsize =
>>> +			ssi_private->fifo_depth - 2;
>>> +		ssi_private->dma_params_tx.dma_addr =
>>> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
>>> +		ssi_private->dma_params_rx.dma_addr =
>>> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
>>
>> So I'm a little confused by this new binding.  I went through a lot of
>> work to remove DMA-specific data from the SSI driver, and here you are
>> adding a bunch of it back.  What you're doing here -- I'm doing it in the
>> DMA driver where it belongs.
>
> I'm not sure these all belong to DMA driver.  These are all
> configurations/parameters of SSI, which are related to DMA though.
> I see fsl_dma are handling these, but I do not fully agree with that,
> because we end up with fsl_dma driver accessing SSI node and
> "struct ccsr_ssi" which should be SSI private data.

Well, the SSI needs to tell the DMA driver how to program itself.  On 
PowerPC, the DMA's burst size is based on the SSI's FIFO depth.  You're 
effectively doing what I already do, except you do more work in the SSI 
driver.

I understand that we need to support old and new bindings, but I already 
created an infrastructure that supports passing SSI information to the DMA 
driver.  It seems that the above code is different only for the sake of 
being different, not because it's better.

This is not really an i.MX vs. PowerPC issue, which is why I'm not sure 
this change belong in this patchset.

> Secondly, this is the way that how imx-ssi and imx-pcm-dma works and
> interacts.  If we want to move these stuff into imx-pcm-dma, we need
> a good story to convince imx-ssi users that why it's better than what
> they currently do.

I don't understand that.  You're already rewriting these drivers.  Who 
else needs to be convinced?

-- 
Timur Tabi
Linux kernel developer at Freescale
