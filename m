From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile
 error	since dma api is changed
Date: Sat, 31 Mar 2012 12:39:07 +0000
Message-ID: <7FE21149F4667147B645348EC6057885153794@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1333197468-3263-1-git-send-email-b29396@freescale.com>
	<4F76EB8D.2060200@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 93E0B244ED
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Mar 2012 14:39:14 +0200 (CEST)
In-Reply-To: <4F76EB8D.2060200@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Saturday, March 31, 2012 7:34 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; broonie@opensource.wolfsonmicro.com;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix
> compile error since dma api is changed
> Importance: High
> 
> On 03/31/2012 02:37 PM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > The following compiling error is caused by the API
> > device_prep_dma_cyclic is changed. Using dmaengine_prep_dma_cyclic to
> fix it.
> >
> > sound/soc/soc-dmaengine-pcm.c: In function
> 'dmaengine_pcm_prepare_and_submit':
> > sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to function
> 'chan->device->device_prep_dma_cyclic'
> > make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
> > make[1]: *** [sound/soc] Error 2
> > make: *** [sound] Error 2
> >
> 
> Hi,
> 
> There is already a fix for this in Mark's for-3.4 branch.
Okay, thanks for reminder.
I missed to check Mark's tree.

Regards
Dong Aisheng
