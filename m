From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 5/5 v4] ASoC: dwc: Update DOCUMENTATION for
	I2S Driver
Date: Fri, 8 Apr 2016 11:06:55 +0100
Message-ID: <570782BF.10402@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
 <ce97e6bb7ddb71e532c4066334ceead4d4d3e692.1460047238.git.joabreu@synopsys.com>
 <20160407175326.GX1924@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 by alsa0.perex.cz (Postfix) with ESMTP id AB14A260824
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 12:07:10 +0200 (CEST)
In-Reply-To: <20160407175326.GX1924@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, CARLOS.PALMINHA@synopsys.com, tiwai@suse.com, linux-snps-arc@lists.infradead.org, architt@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,


On 07-04-2016 18:53, Mark Brown wrote:
> On Thu, Apr 07, 2016 at 05:53:59PM +0100, Jose Abreu wrote:
>
>> + Optional properties:
>> + - snps,use-dmaengine: If set the driver will use ALSA DMA engine. If set
>> +   it is required to use the properties 'dmas' and 'dma-names'.
> This is not a good interface, it's describing Linux internal APIs.  If
> the device needs to operate in PIO mode it should just do that.

I added this interface because there is no direct way to check if DMA is
available on the I2S controller so it is not possible to automatically change
between DMA and PIO mode. As the I2S controller can be built with or without DMA
support it is necessary to somehow check if DMA is enabled or not and according
to that use either ALSA DMA engine or the custom platform driver sent in these
patches. I did not want to remove drivers functionality so I added this property
to the DT. This way a user can select between DMA and PIO mode.

Is there a better option to do this without removing the possibility of using
ALSA DMA engine in the driver?

Best regards,
Jose Miguel Abreu
