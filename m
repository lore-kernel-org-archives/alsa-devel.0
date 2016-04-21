From: Allan Klinbail <aklinbail@gmail.com>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 02:52:47 +0000
Message-ID: <CA+aoAJeU=y=mP0=_xeQXDfcG5uWg8azpuddQG6MxJ=NEZkA31A@mail.gmail.com>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
 <57181862.6060501@sakamocchi.jp>
 <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
 <571836C0.40605@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DAF82608B3
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 04:52:57 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id e201so70588780wme.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 19:52:57 -0700 (PDT)
In-Reply-To: <571836C0.40605@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for the advice.  I am not upset with the case that the ALSA firewire
drivers are not intending to replace ffado, although it would have been
convenient.

I have read the posted paper, and while I basically understand it's
premise, I don't feel that this approach is necessarily suitable for
"prefoessional" audio use cases (with DAW software and other music
production software). I feel I understand why the Jack developers have
maintained the traditional approach.  Although I admit my understanding is
basic and limited.

Latency in this case is specifically important from a "Round trip"
viewpoint, the time for the audio reaching the AD converter being processed
by the DAW application (and associated plugins) to the time it reaches the
DA converter.
There are fixed latencies, such as introduced by the converters and also
the latency from the speaker distance to the ears of the musician. (if
monitoring headphones are not being used by the musician). For a musician
to be able to process their mechnical movements at the correct time to the
audio they are hearing requires a fixed latency to occur and typically this
needs to be under 10ms for their not to be a perceived delay.

This is starkly different from typical desktop usage or even gaming usage
where multiple random audio streams are expected.

Audio streams in DAW use cases, are highly predictable. In a typical setup,
there will be no audio coming from sources outside of the DAW framework
(this may involve and intercommunicating applications, however there would
be no random media player startups, or sound coming from a new web page for
example).

The ability to "rewind" to insert new streams into the path of the hardware
buffers is not typical for these circumstances.

FYI - AMT 8 is an 8 in / 8 out MIDI device (128 channels capable). I use 2
of them, as I have many hardware devices (synthesizers and audio processing
units) that need communication with MIDI protocol.

Regards



On Thu, Apr 21, 2016 at 12:11 PM Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On Apr 21 2016 09:14, Allan Klinbail wrote:
> > Thanks Takashi ,
> >
> > It was my understanding that FFADO would eventually be deprecated,  so am
> > trying to provide test feedback for my device.  I thought comparable
> > performance would be a goal.
>
> Your misunderstanding.
>
> ALSA firewire stack is not an alternative of FFADO implementation.
> Against understanding of most of FFADO users, the implementation of this
> stack doesn't come from FFADO implementation, therefore they're based on
> quite different designs and code bases.
>
> (It's your misfortune that FFADO project has already lost
> well-established developers who can explain about it.)
>
> And you should realize that the decrease of size of PCM buffer is an
> ancient technique to reduce communication latency in a past decade. JACK
> developers still adhere on it, against their aim, unfortunately.  To
> understand this aspect, please read Alexander Patrakov's paper proposed
> in LAC 2015.
> http://lac.linuxaudio.org/2015/papers/10.pdf
>
> It's a bit difficult to you. But when thinking about the 'latency'
> severely, at least, users and developers should understand what in the
> article, at least. About the communication latency, I'm willing to use
> my time for this direction, but not for the others.
>
> > Using ALSA is desirable as I have a large number of MIDI devices (2*AMT
> 8)
> > and 3 other control devices..  Using ALSA provides better connectivity
> than
> > a2jmidi..
>
> What's the 'AMT'?
>
> > I will try alsa in,  plug.. I am concerned though this is not an ideal
> > solution due to trying to sync multiple devices which in reality share a
> > clock..  Adding even more latency..
>
> Even if using FFADO implementation, you can't achieve it. It pretends as
> what you say. Of cource, the size of PCM buffer is accumulated to the
> communication latency.
>
> > I will continue using FFADO for production work,  but am happy to keep
> > testing if you believe improvements can be made.
>
> I haven no plan of my development for the direction about which you
> mentioned, sorry. There're more crutial issues than them.
>
>
> Regards
>
> Takashi Sakamoto
>
