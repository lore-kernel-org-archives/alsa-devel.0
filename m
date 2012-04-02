From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile
 error	since dma api is changed
Date: Mon, 02 Apr 2012 09:20:04 +0530
Message-ID: <1333338604.1610.0.camel@vkoul-udesk3>
References: <1333197468-3263-1-git-send-email-b29396@freescale.com>
	<4F76EB8D.2060200@metafoo.de>
	<7FE21149F4667147B645348EC6057885153794@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D182D24602
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 05:47:27 +0200 (CEST)
In-Reply-To: <7FE21149F4667147B645348EC6057885153794@039-SN2MPN1-011.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2012-03-31 at 12:39 +0000, Dong Aisheng-B29396 wrote:
> > > sound/soc/soc-dmaengine-pcm.c: In function
> > 'dmaengine_pcm_prepare_and_submit':
> > > sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to
> function
> > 'chan->device->device_prep_dma_cyclic'
> > > make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
> > > make[1]: *** [sound/soc] Error 2
> > > make: *** [sound] Error 2
> > >
> > 
> > Hi,
> > 
> > There is already a fix for this in Mark's for-3.4 branch.
> Okay, thanks for reminder.
> I missed to check Mark's tree.
> 
This fix is there in rc1

-- 
~Vinod
