From: mein_name@ist-einmalig.de
Subject: playback delay and problems with simultaneous
	playback/capture
Date: Wed, 06 Jan 2010 15:51:31 +0100
Message-ID: <20100106145131.24670@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1985110381A
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 15:51:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am currently testing my driver but I've got some problems with the "pcm machine"...as it is my first ALSA driver I am open for every hint. The code currently is not conform to linux kernel coding style, I will do all such cosmetically stuff after functionality is given.

1.
Playing a file works fine, but when the ALSA middle layer triggers stop command, the DSP still has data to play, so sending a stop signal to the DSP at this moment would result in breaking the playback. The strange thing here is, that it seems there are 6 frames missing, but the buffer of the DSP is only about 3 frames long. I am not sure if the problem here is, that I am not correctly "calculating" the pcm_pointer:

static snd_pcm_uframes_t
  snd_card_mychip_pcm_pointer(struct snd_pcm_substream *substream)
{
  struct snd_pcm_runtime *runtime = substream->runtime;
  struct snd_mychip_pcm *dpcm = runtime->private_data;


  /* get the current hardware pointer */
  // TODO: calc correct return value

  print_log(DEBUGC "pcm pointer: ret b=%lu\n",
     bytes_to_frames(runtime, dpcm->pcm_buf_pos));

  return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
}


2.
when playing and capturing data simultaneously, I get troubles in both. Playback or Capture alone is working, but if both come togheter, troubles occur. The data-transfer from ALSA to DSP and DSP to ALSA I am doing in the timer function, I am not sure if this could be the problem...but to send data to the DSP I have to check a flag if the DSP is able to receive data, if so, I can send data, otherwise I have to wait until DSP is ready to receive data. That is done with dsp_sendstream. When capturing, the DSP is sending an interrupt every captured period that is available, so I store that in a buffer from where it got read frequently via the timer function (done by readbuf)...everytime when going through this function I think that this way may work, as it does normally, but I am absolutely n
 ot sure if this is a "right" way. I know that there are so called "copy" and "silence" callbacks, but using the copy callback for playback I lost frames, so I did it like it is now...

static void snd_card_mychip_pcm_timer_function(unsigned long data)
{
    struct snd_mychip_pcm *dpcm = (struct snd_mychip_pcm *)data;
    unsigned long flags;
    int count, pos, status;

    // disable interrupts
    spin_lock_irqsave(&dpcm->lock, flags);

    // restart the timer to be called again after one jiffie = 1 ms
    dpcm->timer.expires = 1 + jiffies;
    add_timer(&dpcm->timer);

    if (dpcm->substream->stream == 0) { // playback stream
        // increase counters by bytes per jiffie
        if (dpcm->sendingnotpossible == 0) {     
          dpcm->pcm_irq_pos += dpcm->pcm_jiffie;  //0..MAX_PERIOD_SIZE step=jiffie
          dpcm->pcm_buf_pos += dpcm->pcm_jiffie;  //0..MAX_BUFFER_SIZE step=jiffie
        }
        // if pcm_count has been reached, call snd_pcm_period_elapsed
        // to signal the end of one period (e.g. 288 for mpg or 768 for wav)
        if (dpcm->pcm_irq_pos >= dpcm->pcm_count) { // >= MAX_PERIOD_SIZE? 
            count=dpcm->pcm_count;        // number of bytes to be sent
            pos=dpcm->pcm_buf_pos-count;  // start offset in DMA buffer
            // try to send data to dsp
            status = dsp_sendstream(dpcm->substream->pcm->device, dpcm->substream->runtime->dma_area+pos, count);
            if (status != 0) {  // sending not possible
                dpcm->sendingnotpossible=1;
            } else {            // sending successful
                dpcm->sendingnotpossible=0;
                dpcm->sentframes++;
                if (dpcm->sentframes == 3) // 3 frames in buffer so we can start playback
                {
                  // start decoder playback
                  status=dsp_decod_action(dpcm->substream->pcm->device, DECOD_START);
                  print_log(DEBUGA "reply of dsp_decod_action = %i\n",status);
                }
                // wrap counter if end of buffer is reached
                dpcm->pcm_buf_pos %= dpcm->pcm_size;
                // wrap this counter too
                dpcm->pcm_irq_pos %= dpcm->pcm_count;    
                // tell the PCM middle layer when the buffer position goes across the prescribed period size
                snd_pcm_period_elapsed(dpcm->substream);
                print_log(DEBUGC "timer_function: Period elapsed (p) - pcm_count=%i - pcm_size=%i - src=%p - jiffie=%i\n",dpcm->pcm_count,dpcm->pcm_size,dpcm->substream->runtime->dma_area,dpcm->pcm_jiffie);
            }
            // enable interrupts
            spin_unlock_irqrestore(&dpcm->lock, flags);
        } else {  
            // wrap counter if end of buffer is reached
            dpcm->pcm_buf_pos %= dpcm->pcm_size;
            // enable interrupts
            spin_unlock_irqrestore(&dpcm->lock, flags);
        }
    } else if (dpcm->substream->stream == 1) { // capture stream
        count = dpcm->pcm_count;  // number of bytes to be captured
        pos = dpcm->pcm_buf_pos;  // start offset in DMA buffer
        // read from HIF buffer
        status = readbuf(dpcm->substream->pcm->device, dpcm->substream->runtime->dma_area+pos, count);
        if (status == 0) {  // we got new data from HIF buffer => increase pointers..
            dpcm->pcm_buf_pos += count;
            // wrap counter if end of buffer is reached
            dpcm->pcm_buf_pos %= dpcm->pcm_size;
            // wrap this counter too
            //dpcm->pcm_irq_pos %= dpcm->pcm_count;    
            // tell the PCM middle layer when the buffer position goes across the prescribed period size
            snd_pcm_period_elapsed(dpcm->substream);
            print_log(DEBUG "timer_function: Period elapsed (c) - pcm_count=%i - pcm_size=%i - src=%p - jiffie=%i\n",dpcm->pcm_count,dpcm->pcm_size,dpcm->substream->runtime->dma_area,dpcm->pcm_jiffie);
        }
        // enable interrupts
        spin_unlock_irqrestore(&dpcm->lock, flags);
    }
}

3.
Sometimes I am getting underruns with aplay or xruns with arecord. Currently I am not quite sure why they occur, but I guess this has to do with some of above problems?

-bash-3.2# aplay 20575_24k_100.wav
Playing WAVE '20575_24k_100.wav ' : Signed 16 bit Little Endian, Rate 24000 Hz, Mono
underrun!!! (at least 8.019 ms long)


As a reference I used the dummy driver and the tutorial Writing an ALSA Driver. If there are some other drivers that may be similar and I can look at, I am thankful for every hint! So far thanks for helping me!

Greetings,
Max

-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
