From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Something broke in snd_soc_pcm_stream
Date: Tue, 7 Jun 2011 22:44:43 +0100
Message-ID: <20110607214442.GB7712@opensource.wolfsonmicro.com>
References: <4DEE98C8.2010706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7F46245B6
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 23:44:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DEE98C8.2010706@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2011 at 04:31:52PM -0500, Timur Tabi wrote:

> I can change my code to do this:

> if (pcm->streams[1].substream) {

instead of checking for channels_min.

> 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
> 		fsl_dma_hardware.buffer_bytes_max,
> 		&pcm->streams[1].substream->dma_buffer);
> 	if (ret) {
> 		dev_err(card->dev, "can't alloc capture dma buffer\n");
> 		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
> 		return ret;
> 	}
> }

> But before I do that, I'd like to know if this is a bug in ASoC, or just a new
> behavior that I need to handle.

I don't think this is a bug in the core, relying on the having things
partially initialised in a particular order seems overly fragile -
better to check for the thing you're actually looking for.  There wasn't
a deliberate change I can think of here, though.
