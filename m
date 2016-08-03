From: Rob Nertney <rob@rob-otics.com>
Subject: Re: Stale data interleaved in capture driver
Date: Wed, 3 Aug 2016 14:39:13 -0700
Message-ID: <CALAeOVOZZgh5SThku3SF_7CPrrm_SbLEbR83mkSMefCy5GdrKA@mail.gmail.com>
References: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
 <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C4532668AD
 for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2016 23:39:15 +0200 (CEST)
Received: by mail-vk0-f51.google.com with SMTP id w127so156308158vkh.2
 for <alsa-devel@alsa-project.org>; Wed, 03 Aug 2016 14:39:15 -0700 (PDT)
In-Reply-To: <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens, sorry for the delay, this got sent to spam for some reason

I've made changes to remove the high-frequency. I originally tried that
method because my DMA IRQ fires whenever it writes 1/2 frame (it doesn't
have coalescing support yet). Ive noticed that whatever I set my
buffer/periods to, i always get one good buffer-size chunk in the WAV file,
then it displays the very first half-frame of data, then correctly
continues onward, but interleaving two sets of incrementing data. I think
it might be when I increment buf_pos for the pointer callback, or maybe
something else.

Here's how I have the hardware/driver right now:

I have a DMA which is looping across 64Kbytes. I verified this is correctly
in simulation.
The DMA is configured to interrupt at 32Bytes (A half frame. My Full frame
is 16ch, S32LE = 64Bytes).

The driver counts the 32Byte IRQs until it reaches one period worth. From
what I can tell (please correct me if I'm wrong), the periods_min and
periods_max are up to me to define, since i don't interrupt on a period
boundary. I divide the 64K buffer into 8 periods of 8KB each. Since my
frame is 64Bytes, that is 128 frames/period. Since the DMA fires at each
half frame (due to FPGA configuration), This is 256 IRQs I need to count
to, before I call snd_pcm_period_elapsed.

//pertinent snd_pcm_hardware lines:
  .buffer_bytes_max = 65536,
  .period_bytes_min = 65536/8,
  .period_bytes_max = 65536/8,
  .periods_min      = 8,
  .periods_max     = 8,

static irqreturn_t my_dma_irq(int irq, void *dev_id)
{
  struct my_device *dev = dev_id;
  unsigned int last_ptr, size;

  spin_lock(&dev->lock);
  dev->irq_count++;
  dev->buf_pos += 32; //32 bytes have been transferred

  if(dev->buf_pos >= (dev->pcm_buffer_size))
     dev->buf_pos = 0;

  if(dev->irq_count == 256){ //256 IRQs elapsed==128 frames == 8Kbytes ==
1/8 max_buffer
    spin_unlock(&dev->lock);
    snd_pcm_period_elapsed(dev->substream);
    spin_lock(&dev->lock);
    dev->irq_count = 0;
    }
  }
handle_irq();
spin_unlock(&dev->lock);
return IRQ_HANDLED;

On Sun, Jul 31, 2016 at 11:34 PM, Clemens Ladisch <clemens@ladisch.de>
wrote:

> Rob Nertney wrote:
> > an IRQ every 32Bytes (half-frame)
> >
> > I wrote my handler as described in the high-frequency interrupts
> described
> > here:
> > http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s07.html
>
> This does not make sense; you need a timer only when you do not have
> a proper interrupt.  Why do you think you need to do it this way?
>
> > My data is valid until 1/4 buffer full, then it interleaves stale (lower
> > numbers) in, replacing the desired numbers. It's sporadic, and it appears
> > to repeat, as if ALSA never returns to the 0-offset of dma_area.
>
> ALSA just reports what your driver tells it; this sounds like a bug
> in your driver or in the hardware.
>
>
> Regards,
> Clemens
>
