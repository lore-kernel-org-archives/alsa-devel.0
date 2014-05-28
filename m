From: Henrik Austad <henrik@austad.us>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Wed, 28 May 2014 11:32:35 +0200
Message-ID: <20140528093235.GB26498@austad.us>
References: <20140526130352.GA17414@austad.us> <538369F6.4040306@gmail.com>
 <20140527090216.GB20915@austad.us> <5384977C.5070009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id F2B122655A1
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 11:37:03 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id el20so7257458lab.15
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 02:37:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5384977C.5070009@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2014 at 03:47:40PM +0200, Clemens Ladisch wrote:
> Henrik Austad wrote:
> > [...]
> > As to moving samples from the buffer onto the network, one approach would
> > be to wrap a set of samples and place it into a ready frame with headers
> > and bits set and leave it in a buffer for the network layer to pick up.
> >
> > The exact method here is not clear to me yet, I need to experiment, and
> > probably send something off to the networking guys. But before I do that,
> > I'd like to have a reasonable sane idea of how ALSA should handle this.
> 
> ALSA expects that the sound card hardware fetches samples whenever it
> needs them.

Right, that's what I thought. Is it correct to assume that _all_
soundcards do this? I.e. no polled memory ops here, only DMA?

> For USB and FireWire, there is a short queue of packets; the driver
> appends new packets whenever a bunch of older packets has been completed
> (as reported by an interrupt).

Yes, that is what I thought was happening. I was then hoping to do
something similar with AVB, just with the networking part instead. So
the net subsystem would act as a hardware device to ALSA and provide a
wakeup to the snd_media_driver once it is done.

On a regular PCI soundcard, I had the impression that it would also
fetch the samples whenever it needed them (you only mention USB and
Firewire). Is this correct, or is PCI a whole different ballpark?

> (This queue is separate from the ALSA ring buffer, which is then never
> accessed directly by hardware.)

Ah, so userspace places samples in a buffer via alsalib, and
snd_<whatever> then moves the samples from that buffer into another
buffer which the hardware can access directly?

> > The process of evening out the rate of samples is what traffic shaping and
> > stream reservation will help you do (or enforce, ymmv), to some extent at
> > least. The credit based shaper algorithm is designed to force bursty
> > traffic into a steady stream.
>
> In the case of USB and FireWire, the hardware already knows to send
> isochronous packets at a rate of 8 kHz.

Yes, that is true.

> A 'normal' NIC wouldn't be able to do this.  Are there NICs that have
> a separate queue for isochronous packets?  Or how else can this be
> handled?

As I said in another email, I've only found i210 with support for AVB at
the moment (sorry for the rather intense Intel plugfest this turned
into).

>From the datasheet [1]:
"""
The I210 implements 4 receive queues and 4 transmit queues, where up to
two queues are dedicated for stream reservation or priority, and up to
three queues for strict priority. In Qav mode, the MAC flow control is
disabled. Note that Qav mode is supported only in 100 Mb/s and 1000
Mb/s. Furthermore, Qav is supported only in full-duplex mode with no
option for Jumbo packets transmission.
"""

It goes on further down (In sec 7.2.7.5 if you're interested) to say:
"""
A queue is eligible for arbitrations only if it has descriptors pointing
to at least a single packet in host memory. For SR queues with the time
based element enabled a queue is only eligible for arbitration if the
fetch time of the up coming packet has been reached.
"""

So, for this, I interpret it as saying that if you create a set of
frames ready for transmission and assign them to a queue with a reserved
stream and prioritized queue, the NIC itself will take care of fetching
data.

If this is a correct interpretation, I don't know, but I think it is a
fair assessment that you can get support from HW to do this. It also
means that avb_media_driver needs to have some awareness over actual
network hardware. This could get somewhat messy.

1) http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/i210-ethernet-controller-datasheet.pdf
-- 
Henrik Austad
