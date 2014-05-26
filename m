From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Mon, 26 May 2014 22:21:10 +0600
Message-ID: <538369F6.4040306@gmail.com>
References: <20140526130352.GA17414@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id D2DF0265370
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 18:21:13 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id w7so4384095lbi.1
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 09:21:13 -0700 (PDT)
In-Reply-To: <20140526130352.GA17414@austad.us>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrik Austad <henrik@austad.us>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

26.05.2014 19:03, Henrik Austad wrote:
> Hi all!
>
> This is an RFC for a new class of soundcards. I am not very familiar
> with how ALSA is tied together underneath the hood, so what you see
> here, is based on my naive understanding of ALSA. I wear asbestos
> underwear on a regular basis, so I prefer honesty over sugarcoating :)

Hello. All of this looks very interesting, but a bit more information is 
needed in order to put this in context.

First: is this supposed to work with any ethernet card? Or is some 
special hardware needed on the PC side? If so, which hardware?

Second: I would like to know more about the buffering model. For 
simplicity, let's consider playback from a PC to a remote receiver. 
Obviously, as the intention is to create something that looks like a 
regular ALSA sound card, there should be a circular buffer that holds 
sound samples (just like the DMA buffer on regular sound cards). There 
also needs to be "something" that sends samples from this buffer into 
the network. Is my understanding correct?

> * IEEE 1722 (and 1733 for layer-3) Layer 2 Transport for
>    audio/video. The packing is similar to what is done in Firewire. You
>    have 8kHz frame intervals for class A, 4kHz for class B. This gives
>    relatively few samples pr. frame. Currently we only look at Layer 2 as
>    small peripherals (microphones, speakers) will only have to implement
>    L2 instead of the entire IP-stack.

So, are you proposing to create a real-time kernel thread that will wake 
up 4000 or 8000 times per second in order to turn a few samples from the 
circular buffer into an Ethernet packet and send it, also advancing the 
"hardware pointer" in the process? Or do you have an idea how to avoid 
that rate of wakeups?

-- 
Alexander E. Patrakov
