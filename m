From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 22 Jun 2015 17:49:22 +0500
Message-ID: <55880452.7000100@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>	<557E86DD.8020709@metafoo.de>	<CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>	<557EBEAA.70004@metafoo.de>	<CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>	<557EDE22.7080808@metafoo.de>	<CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>	<5587AE77.1020709@metafoo.de>	<5587D845.4040309@ladisch.de>	<CAN8ccibQvDmdydn3QjHH==mNNizWuH+FOwRMu_BFRYGAfu9ukw@mail.gmail.com>	<5587FB52.9070401@gmail.com>
 <CAN8ccib-qYEFK95GYiN-PW9PLXkLZhC+Z2JbsLzdb7ye5aaFWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AD26264F40
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 14:47:32 +0200 (CEST)
Received: by lbnk3 with SMTP id k3so1842341lbn.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 05:47:31 -0700 (PDT)
In-Reply-To: <CAN8ccib-qYEFK95GYiN-PW9PLXkLZhC+Z2JbsLzdb7ye5aaFWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

22.06.2015 17:34, Raymond Yau wrote:
>
>  >>>
>  >>> The ALSA API requires the driver to provide a cyclic sample buffer (or
>  >>> something that behaves like one).
>  >>>
>  >>> However, not all hardware works this way.  USB and FireWire require the
>  >>> driver to continually queue new packets, whose size and timing are
>  >>> determined by the bus clock and are not directly related to the ALSA
>  >>> ring buffer.  These drivers use double buffering; the actual DMA
> happens
>  >>> from those packets, not from the ring buffer.
>  >>>
>  >>
>  >> If those queued packets/urb cannot be rewind, snd_pcm_rewindable should
>  >> return zero for those driver
>  >
>  >
>  > Not really.
>  >
>  > As I understand it, the kernel periodically converts a piece of the
> ring buffer (located in RAM) into an URB, and it gets sent through the
> USB bus. Parts of the buffer that are not yet converted to URB are
> perfectly rewindable.
>  >
>  > In other words, for USB devices, the kernel already implements the
> "low-latency background thread that makes unrewindable devices
> rewindable" idea that I discussed (as a strawman proposal) here for
> userspace:
>  >
>  >
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/080868.html
>  >
>
> This mean that SNDRV_PCM_INFO_BATCH represent exact one period is not
> correct for usb and firewire since hw_ptr does not increment in period size

Well, according to the new definition, "SNDRV_PCM_INFO_BATCH on the 
other hand has become to mean that the device is only capable of 
reporting the audio pointer with a coarse granularity". In the USB case, 
we indeed have coarse granularity (6 ms in the worst case), but not as 
bad as one period.

>
> Do this mean .period_bytes_min of snd-usb-audio is incorrect since
> .period_bytes_min should be at least size of urb/packet ?
>

I don't see anything wrong here. With the USB device that my colleague 
has here at work, the minimum period size is 48 samples, i.e. 1 ms, 
which looks exactly like one USB data packet.

-- 
Alexander E. Patrakov
