From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Tue, 27 May 2014 15:47:40 +0200
Message-ID: <5384977C.5070009@ladisch.de>
References: <20140526130352.GA17414@austad.us> <538369F6.4040306@gmail.com>
 <20140527090216.GB20915@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2CD652657B8
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 15:47:46 +0200 (CEST)
In-Reply-To: <20140527090216.GB20915@austad.us>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrik Austad <henrik@austad.us>, "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, alsa-devel@alsa-project.org, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

Henrik Austad wrote:
> [...]
> As to moving samples from the buffer onto the network, one approach would
> be to wrap a set of samples and place it into a ready frame with headers
> and bits set and leave it in a buffer for the network layer to pick up.
>
> The exact method here is not clear to me yet, I need to experiment, and
> probably send something off to the networking guys. But before I do that,
> I'd like to have a reasonable sane idea of how ALSA should handle this.

ALSA expects that the sound card hardware fetches samples whenever it
needs them.

For USB and FireWire, there is a short queue of packets; the driver
appends new packets whenever a bunch of older packets has been completed
(as reported by an interrupt).

(This queue is separate from the ALSA ring buffer, which is then never
accessed directly by hardware.)

> The process of evening out the rate of samples is what traffic shaping and
> stream reservation will help you do (or enforce, ymmv), to some extent at
> least. The credit based shaper algorithm is designed to force bursty
> traffic into a steady stream.

In the case of USB and FireWire, the hardware already knows to send
isochronous packets at a rate of 8 kHz.

A 'normal' NIC wouldn't be able to do this.  Are there NICs that have
a separate queue for isochronous packets?  Or how else can this be
handled?


Regards,
Clemens
