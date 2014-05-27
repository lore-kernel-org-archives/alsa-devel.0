From: Henrik Austad <henrik@austad.us>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Tue, 27 May 2014 11:02:16 +0200
Message-ID: <20140527090216.GB20915@austad.us>
References: <20140526130352.GA17414@austad.us>
 <538369F6.4040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 96CB426557B
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 11:06:43 +0200 (CEST)
Received: by mail-lb0-f176.google.com with SMTP id p9so4665609lbv.7
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 02:06:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <538369F6.4040306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, alsa-devel@alsa-project.org, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 10:21:10PM +0600, Alexander E. Patrakov wrote:
> 26.05.2014 19:03, Henrik Austad wrote:
> >Hi all!
> >
> >This is an RFC for a new class of soundcards. I am not very familiar
> >with how ALSA is tied together underneath the hood, so what you see
> >here, is based on my naive understanding of ALSA. I wear asbestos
> >underwear on a regular basis, so I prefer honesty over sugarcoating :)
> 
> Hello. All of this looks very interesting, but a bit more
> information is needed in order to put this in context.

Hi Alexander, thank you for the feedback.

First a disclaimer, I am in no sense an expert in this area, so if 
something seems fishy, it might just be.

> First: is this supposed to work with any ethernet card? Or is some
> special hardware needed on the PC side? If so, which hardware?

In theory, any NIC should work. That's theory. In practice, it will be a 
real benefit if the NIC can timestamp etherframes on ingress and egress, 
and that requires some extra silicon. I've only heard of the I210 (from 
Intel) that does this, but I may be wrong.

The benefit from doing this is faster clock convergence for the gPTP 
protocol.

AVB uses the term "clock syntonization" which means that the clocks of 2 
entities running at the same frequency. Since this is next to impossible, 
having a PLL to slightly change and lock the frequency whenever the 
GrandMaster updates the PTP time is required.

If you do not have the capability of doing this, you can fall back to 
synchronization, which requires some extra care when you correlate the 
timestamp for a sample to the local media clock.

AVB does place some hard requirements on the network infrastructure though, 
you need switches capable of SRP,MSRP,gPTP and queueing enhancements.

> Second: I would like to know more about the buffering model. For
> simplicity, let's consider playback from a PC to a remote receiver.

Sure, I think this is a pretty good scenario for how ALSA would use AVB.

> Obviously, as the intention is to create something that looks like a
> regular ALSA sound card, there should be a circular buffer that
> holds sound samples (just like the DMA buffer on regular sound
> cards). There also needs to be "something" that sends samples from
> this buffer into the network. Is my understanding correct?

Yes, that is pretty much what I've planned. Since we cannot interrupt 
userspace to fill the buffer all the time, I was planning on adding a ~20ms 
buffer. If this is enough, I don't know yet.

As stated in the previous mail, I'm no alsa-expert, I expect to learn a lot 
as I dig into this :)

As to moving samples from the buffer onto the network, one approach would 
be to wrap a set of samples and place it into a ready frame with headers 
and bits set and leave it in a buffer for the network layer to pick up.

The exact method here is not clear to me yet, I need to experiment, and 
probably send something off to the networking guys. But before I do that, 
I'd like to have a reasonable sane idea of how ALSA should handle this.

I expect this to be rewritten a few times :)

> >* IEEE 1722 (and 1733 for layer-3) Layer 2 Transport for
> >   audio/video. The packing is similar to what is done in Firewire. You
> >   have 8kHz frame intervals for class A, 4kHz for class B. This gives
> >   relatively few samples pr. frame. Currently we only look at Layer 2 as
> >   small peripherals (microphones, speakers) will only have to implement
> >   L2 instead of the entire IP-stack.
> 
> So, are you proposing to create a real-time kernel thread that will
> wake up 4000 or 8000 times per second in order to turn a few samples
> from the circular buffer into an Ethernet packet and send it, also
> advancing the "hardware pointer" in the process? Or do you have an
> idea how to avoid that rate of wakeups?

I'm hoping to get some help from the NICs hardware and a DMA engine here as
it would be pretty crazy to do a task wakeup 8k times/sec. Not only would 
the overhead be high, but if you have a 125us window for filling a buffer, 
you are going to fail miserably in a GPOS.

For instance, if you can prepare, say 5ms worth of samples at a go, that 
would mean you have to prepare 40 frames. If you then could get the NIC and 
network infrastructure take thos frames and even them out over the next 5 
ms, all would be well.

The process of evening out the rate of samples is what traffic shaping and 
stream reservation will help you do (or enforce, ymmv), to some extent at 
least. The credit based shaper algorithm is designed to force bursty 
traffic into a steady stream. How much you can press the queues, I'm not 
sure. It may very well be that 40 frames is too much.

As you can see, a lot of uncertanties, and a long way to walk.

Thanks for pointing these things out though, it gives me some extra 
elements to pursue - thanks!


-- 
Henrik Austad
