From: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Subject: Re: DMA buffer gets played only once
Date: Thu, 06 Sep 2007 10:06:22 +0530
Message-ID: <46DF83C6.1090002@hrz.tu-chemnitz.de>
References: <46DE4AB1.20206@hrz.tu-chemnitz.de>	<1188983079.7844.1208974467@webmail.messagingengine.com>	<46DE7422.5020900@hrz.tu-chemnitz.de>
	<s5hbqch8e5o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from john.hrz.tu-chemnitz.de (john.hrz.tu-chemnitz.de
	[134.109.132.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A320103870
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 06:34:42 +0200 (CEST)
In-Reply-To: <s5hbqch8e5o.wl%tiwai@suse.de>
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

Hi,

Takashi Iwai wrote:
>> At least this is the behaviour I experienced.
> 
> It's your mis-interpretation of START/STOP concenpt in the ALSA
> framework.  The trigger START and STOP mean the start/stop of the
> whole streaming operation.  It's basically called from the outside,
> i.e. the application starts/stops the stream.  If you need to keep
> some DMA start/stop operations internally, do it in the driver
> lowlevel side internally.

thanks for reply but as already stated this is the behaviour I 
_experienced_. I don't know why also continuously calls trigger START, 
play one period, trigger STOP. Here is some pseudo code:

---snip---
pcm_trigger()
{
	case SNDRV_PCM_TRIGGER_START:
                 /* start the DMA Transfer */
                 ret = startTransfer(dma_devaddr, params->ch_num, 
num_blocks, vi1888_pcm_dma_userCallback, substream);
                 break;
...
}




vi1888_pcm_dma_userCallback() // gets called upon completion of DMA 
transfer
{
         prtd->period_ptr += prtd->period_size;
         if (prtd->period_ptr >= prtd->dma_buffer_end) {
                 prtd->period_ptr = prtd->dma_buffer;
         }

	/* reconfigure channel according to new period pointer */

         /* start the next DMA Transfer */
         ret = startTransfer(dma_devaddr, params->ch_num, num_blocks, 
vi1888_pcm_dma_userCallback, substream();

         /* notify Alsa for the elapsed periods */
         snd_pcm_period_elapsed(substream);
}

---snap---

After each call to snd_pcm_period_elapsed() Alsa calls 
pcm_trigger(TRIGGER_STOP).

Please tell me what I am doing wrong in these callbacks?


Thanks in advance,
Markus
