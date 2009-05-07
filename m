From: Jon Smirl <jonsmirl@gmail.com>
Subject: appl_ptr and DMA overrun at end of stream
Date: Thu, 7 May 2009 12:23:51 -0400
Message-ID: <9e4733910905070923i16683486n678653ba56c28b74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by alsa0.perex.cz (Postfix) with ESMTP id D7D871038C3
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 18:23:53 +0200 (CEST)
Received: by gv-out-0910.google.com with SMTP id i36so152582gve.24
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 09:23:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am having problem with DMA overrun at the end of the audio stream.
Is there an official way to know the address of the last valid audio
sample?

mpc5200 ac97 is keeping a bunch of descriptors queued in a loop to
continuously play music. I believe this is the way ALSA wants it. Now
say the last period is
half full. ALSA fills the other half with silence. When that period
finishes playing it will generate an interrupt. ALSA comes back from
that interrupt with trigger(STOP).

But, our CPU is slow compared to a 3Ghz desktop, there is considerable
latency from the period end interrupt to trigger(STOP) getting called.
 So the DMA hardware starts playing the next period before
trigger(STOP) can get the DMA stopped.  I turned off tried turning off
BestComm, flushing the FIFO, and turning off the audio clocks.  None
can be done fast enough. That next period contains stale data from
further back in the stream. When the front part of it plays it makes a
burst of noise.

What I need is the address of the end of valid data in the buffer. I
need that address so that I can program the DMA automatically stop at
end of stream and not overrun. Search around in the guys of ALSA I
found appl_ptr. I can use appl_ptr to determine the location of end of
stream and prevent DMA overrun. When there is no valid data I don't
enqueue the
descriptor.

 s->appl_ptr track the previous value of  s->runtime->control->appl_ptr.
The difference between these two is the amount of valid data in the buffer.
When this difference goes to zero, I stop queue new buffers to ALSA.
That fixes the DMA overrun.

static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
{
       struct bcom_bd *bd;

       while (s->appl_ptr < s->runtime->control->appl_ptr) {

               if (bcom_queue_full(s->bcom_task))
                       return;

               s->appl_ptr += s->period_size;

               /* Prepare and enqueue the next buffer descriptor */
               bd = bcom_prepare_next_buffer(s->bcom_task);
               bd->status = s->period_bytes;
               bd->data[0] = s->period_next_pt;
               bcom_submit_next_buffer(s->bcom_task, NULL);

               /* Update for next period */
               s->period_next_pt += s->period_bytes;
               if (s->period_next_pt >= s->period_end)
                       s->period_next_pt = s->period_start;
       }
}



-- 
Jon Smirl
jonsmirl@gmail.com
