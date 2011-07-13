From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
Date: Wed, 13 Jul 2011 06:29:48 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CD7EC@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
	<20110712232719.GB17710@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A705103952
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 08:29:54 +0200 (CEST)
In-Reply-To: <20110712232719.GB17710@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, July 13, 2011 7:27 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org;
> lrg@ti.com; s.hauer@pengutronix.de; u.kleine-koenig@pengutronix.de
> Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
> 
> On Tue, Jul 12, 2011 at 11:04:36PM +0800, Dong Aisheng wrote:
> 
> > +	if (dai->driver->capture.channels_min) {
> > +		ret = mxs_pcm_preallocate_dma_buffer(pcm,
> > +			SNDRV_PCM_STREAM_CAPTURE);
> > +		if (ret)
> > +			goto out;
> > +	}
> 
> For robustness replace the channels_min check with a check for the
> relevant substream being present (see pxa2xx-pcm.c for a recent example).
Is this change ok?
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 3e3a8c8..a385ba9 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -288,14 +288,14 @@ static int mxs_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
                card->dev->dma_mask = &mxs_pcm_dmamask;
        if (!card->dev->coherent_dma_mask)
                card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-       if (dai->driver->playback.channels_min) {
+       if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
                ret = mxs_pcm_preallocate_dma_buffer(pcm,
                        SNDRV_PCM_STREAM_PLAYBACK);
                if (ret)
                        goto out;
        }

-       if (dai->driver->capture.channels_min) {
+       if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
                ret = mxs_pcm_preallocate_dma_buffer(pcm,
                        SNDRV_PCM_STREAM_CAPTURE);
                if (ret)

Regards
Dong Aisheng
