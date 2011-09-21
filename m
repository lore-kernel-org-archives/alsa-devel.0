From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] ASoC: Flush Samsung DMA on free
Date: Wed, 21 Sep 2011 20:51:55 +0900
Message-ID: <004401cc7854$dcb0ebf0$9612c3d0$%kim@samsung.com>
References: <1316557614-32044-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<005e01cc7853$7a3d5400$6eb7fc00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id C9F002448A
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 13:52:02 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LRV000CHFM2WYI0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 21 Sep 2011 20:51:56 +0900 (KST)
Received: from kgenekim (12-23-120-114.csky.net [12.23.120.114])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LRV001YLFMJKK@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 21 Sep 2011 20:51:56 +0900 (KST)
In-reply-to: <005e01cc7853$7a3d5400$6eb7fc00$%kim@samsung.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Boojin Kim' <boojin.kim@samsung.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Boojin Kim wrote:
> 
> 
> Mark Brown wrote:
> >
> > Ever since it was written the Samsung DMA driver has had a TODO in the
> > hw_free() function wondering if we need to flush the DMA buffers. Up
> > until
> > now the answer has been no but with the recent improvements Boojin has
> > done to the DMA infrastructure for the Samsung port the answer has
> > changed
> > to yes for at least S3C6410 systems.
> >
> > If we don't then when we next prepare() the channel the API will get
> > confused trying to run callbacks on the transfers hanging around from
> > the
> > previous time the stream was open and oops.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> 
> Your patch give good effect to all Samsung SoCs.
> Thanks a lot.
> 
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> 
> > ---
> >
> > Kukjin, this should probably get added to your branch assuming it's OK
> > for other CPUs.
> >
Looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> >  sound/soc/samsung/dma.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> > index 851346f..2d622b6 100644
> > --- a/sound/soc/samsung/dma.c
> > +++ b/sound/soc/samsung/dma.c
> > @@ -198,10 +198,10 @@ static int dma_hw_free(struct snd_pcm_substream
> > *substream)
> >
> >  	pr_debug("Entered %s\n", __func__);
> >
> > -	/* TODO - do we need to ensure DMA flushed */
> >  	snd_pcm_set_runtime_buffer(substream, NULL);
> >
> >  	if (prtd->params) {
> > +		prtd->params->ops->flush(prtd->params->ch);
> >  		prtd->params->ops->release(prtd->params->ch,
> >  					prtd->params->client);
> >  		prtd->params = NULL;
> > --
> > 1.7.6.3
