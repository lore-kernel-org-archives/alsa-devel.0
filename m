From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: DMA producer/consumer
Date: Wed, 10 Mar 2004 17:05:42 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F2908A@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
	

A typical core pcm playback flow (simplified for representation) 


static void arch_pcm_start_dma(struct arch_pcm_runtime *s)
{
	...	
	
	ret = __arch_start_dma(s->dma_ch, pos, s->dma_size);
	...
	ssr->dma_pos = pos;
}


static void arch_pcm_dma_callback(void *data)
{
	...
	
	if (s->stream)
		snd_pcm_period_elapsed(s->stream);

	spin_lock(&s->lock);
	if (s->state & ST_RUNNING)
		arch_pcm_start_dma(s);
	spin_unlock(&s->lock);
	
	...
}

static int chip_pcm_trigger(snd_pcm_substream_t *substream, int cmd)
{
	...

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		arch_clear_dma(s->dma_ch);
		arch_pcm_start_dma(s->dma_ch);
		...		
		break;

	...	
}


Now in this flow chip_pcm_trigger calls the arch_pcm_start_dma, which then
starts a dma transfer.  Callback is called when the dma transfer ends, which
then notifies the ALSA middle layer about the end of one period and then
starts another dma transfer.  

The question I want to ask is about the continuity of data transferred to
the actual codec.  In the above flow, next dma transfer is started only when
the previous one ends.  So this mechanism will give us small jitters in the
audio playback.  

Hardware provides us the mechanism of queueing another dma transfer even
before the first one ends, so that the queued dma transfer starts as soon as
the first one ends (and this is done at the hardware level).  But the
question is that where should we queue another dma transfer.  Or do you guys
suggest that there is no need of doing a queued dma transfer.

Also another question is that how do we make sure that data we are dma'ing
is filled up by the ALSA middle layer (shall we use appl_ptr to check that).

warm regards
-kshitij


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
