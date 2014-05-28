From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Wed, 28 May 2014 15:12:57 +0200
Message-ID: <5385E0D9.5080508@ladisch.de>
References: <20140526130352.GA17414@austad.us> <538369F6.4040306@gmail.com>
 <20140527090216.GB20915@austad.us> <5384977C.5070009@ladisch.de>
 <20140528093235.GB26498@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 8957B2655A1
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 15:12:59 +0200 (CEST)
In-Reply-To: <20140528093235.GB26498@austad.us>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrik Austad <henrik@austad.us>
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

Henrik Austad wrote:
> On Tue, May 27, 2014 at 03:47:40PM +0200, Clemens Ladisch wrote:
>> Henrik Austad wrote:
>>> [...]
>>> As to moving samples from the buffer onto the network, one approach would
>>> be to wrap a set of samples and place it into a ready frame with headers
>>> and bits set and leave it in a buffer for the network layer to pick up.
>>>
>>> The exact method here is not clear to me yet, I need to experiment, and
>>> probably send something off to the networking guys. But before I do that,
>>> I'd like to have a reasonable sane idea of how ALSA should handle this.
>>
>> ALSA expects that the sound card hardware fetches samples whenever it
>> needs them.
>
> Right, that's what I thought. Is it correct to assume that _all_
> soundcards do this? I.e. no polled memory ops here, only DMA?

All _real_ sound cards use DMA.  As for the rest, I don't want to talk
about them.  ;-)

>> For USB and FireWire, there is a short queue of packets; the driver
>> appends new packets whenever a bunch of older packets has been completed
>> (as reported by an interrupt).
>
> Yes, that is what I thought was happening. I was then hoping to do
> something similar with AVB, just with the networking part instead. So
> the net subsystem would act as a hardware device to ALSA and provide a
> wakeup to the snd_media_driver once it is done.
>
> On a regular PCI soundcard, I had the impression that it would also
> fetch the samples whenever it needed them (you only mention USB and
> Firewire). Is this correct, or is PCI a whole different ballpark?

I mentioned USB and FireWire because these buses require that samples
are sent wrapped inside packets, which implies that the hardware cannot
access the samples in ALSA's ring buffer directly.  (Actually, this
would be posibble with a flexible enough scatter/gather support, but
this has not been implemented yet.)

Regular PCI sound cards typically get told the location of the ring
buffer in memory, and then do everything by themselves.  (The driver
then does not need to do anything, except reporting the current position
in the buffer to userspace.  This is where disabling period wakeups
would make sense.)

>>> The process of evening out the rate of samples is what traffic shaping and
>>> stream reservation will help you do (or enforce, ymmv), to some extent at
>>> least. The credit based shaper algorithm is designed to force bursty
>>> traffic into a steady stream.
>>
>> In the case of USB and FireWire, the hardware already knows to send
>> isochronous packets at a rate of 8 kHz.
>
> Yes, that is true.
>
>> A 'normal' NIC wouldn't be able to do this.  Are there NICs that have
>> a separate queue for isochronous packets?  Or how else can this be
>> handled?
>
> As I said in another email, I've only found i210 with support for AVB at
> the moment.

Wikipedia also mentions XMOS and Marvell 88E8059.

> """
> For SR queues with the time based element enabled a queue is only
> eligible for arbitration if the fetch time of the up coming packet has
> been reached.
> """

This is exactly what I meant.

> It also means that avb_media_driver needs to have some awareness over actual
> network hardware.

Implementing AVB (802.1Qav) is not possible without hardware support, so
of course this needs some new inteface to the hardware driver(s).


Hmmm, what about <https://github.com/AVnu/Open-AVB>?


Regards,
Clemens
