From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a function I can call from my ISR to tell
 ALSA to abort playback?
Date: Thu, 15 Nov 2007 14:28:14 -0600
Message-ID: <473CABDE.7000205@freescale.com>
References: <473B5D83.2020408@freescale.com>	<Pine.LNX.4.61.0711150932310.19062@tm8103.perex-int.cz>	<473C5F26.2050807@freescale.com>
	<s5hejerd96a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 744BA246E7
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 21:28:19 +0100 (CET)
In-Reply-To: <s5hejerd96a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 15 Nov 2007 09:00:54 -0600,
> Timur Tabi wrote:
>> Jaroslav Kysela wrote:
>>
>>> Yes, call snd_pcm_stop() function. The call must be protected with 
>>> snd_pcm_stream_lock... See to i2c/other/ak4117.c for an example.
>> That code calls snd_pcm_stop() from a timer, not an ISR.  Do I need the call to 
>> wake_up() as well?
> 
> snd_pcm_stop() can be called from ISR, too (e.g.
> snd_pcm_period_elapsed() may call snd_pcm_stop() when XRUN occurs).
> You only need to protect it via snd_pcm_stream_lock*().

It doesn't seem to do much.  Here's the function I wrote:

static void fsl_dma_abort_stream(struct snd_pcm_substream *substream)
{
	unsigned long flags;

	snd_pcm_stream_lock_irqsave(substream, flags);
	if (snd_pcm_running(substream)) {
		snd_pcm_stop(substream, SNDRV_PCM_STATE_DRAINING);
		wake_up(&substream->runtime->sleep);
	}
	snd_pcm_stream_unlock_irqrestore(substream, flags);
}

When I play a file, my DMA controller is incorrectly programmed (test case) and 
this function gets triggered.  The application (aplay) does not terminate.

I tried it with the wake_up() call, but it didn't make a difference.

-- 
Timur Tabi
Linux kernel developer at Freescale
