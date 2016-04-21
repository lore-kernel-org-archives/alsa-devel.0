From: Allan Klinbail <aklinbail@gmail.com>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 05:38:14 +0000
Message-ID: <CA+aoAJdVcu0C6KiLEDTf38awUAjtk2xddumicFNRw-QXx2Ww2w@mail.gmail.com>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
 <57181862.6060501@sakamocchi.jp>
 <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
 <571836C0.40605@sakamocchi.jp>
 <CA+aoAJeU=y=mP0=_xeQXDfcG5uWg8azpuddQG6MxJ=NEZkA31A@mail.gmail.com>
 <57185E39.5090401@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6F92608B3
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 07:38:28 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id v188so229215822wme.1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 22:38:28 -0700 (PDT)
In-Reply-To: <57185E39.5090401@sakamocchi.jp>
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

Thanks for the clarification.

As I admitted, my understanding is basic and limited. Clearly I have got it
wrong.

However, whichever way you code it, as a musician many of us require a
round trip latency from input to output of 10ms or less for us to be able
to comfortably record performances in real time. (Or for engineers to
provide an environment that makes the recording process comfortable for our
clients)

Until that can be facilitated by the driver and also supported by the
software, then it is a rather pointless argument.

For the moment jackd is the system that is best supported by the different
applications for audio to pass between them. It also provides the best
session management tools and also the best synchronisation between MIDI and
audio signal.

If you can educate the software developers how to better utilise the driver
to provide that environment, then that is great. Typically that process
will then take time. So if you do get through your more crucial tasks, I'm
sure there are many users who would appreciate an improvement in the buffer
performance.

As I have stated, I have the equipment to help perform testing and am
willing to do so (even if I will continue to use FFADO for my work). It
doesn't have to be testing in that one specific area.

I do request for a more elegant way to ensure that the entire unit is
treated as one device and while I am clearly ignorant in the detailed
working of the driver, I am more capable than a typical user.

Regards

Allan




On Thu, Apr 21, 2016 at 2:59 PM Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On Apr 21 2016 11:52, Allan Klinbail wrote:
> > I have read the posted paper, and while I basically understand it's
> > premise, I don't feel that this approach is necessarily suitable for
> > "prefoessional" audio use cases (with DAW software and other music
> > production software). I feel I understand why the Jack developers have
> > maintained the traditional approach.  Although I admit my understanding
> is
> > basic and limited.
> >
> > Latency in this case is specifically important from a "Round trip"
> > viewpoint, the time for the audio reaching the AD converter being
> processed
> > by the DAW application (and associated plugins) to the time it reaches
> the
> > DA converter.
> > There are fixed latencies, such as introduced by the converters and also
> > the latency from the speaker distance to the ears of the musician. (if
> > monitoring headphones are not being used by the musician). For a musician
> > to be able to process their mechnical movements at the correct time to
> the
> > audio they are hearing requires a fixed latency to occur and typically
> this
> > needs to be under 10ms for their not to be a perceived delay.
> >
> > This is starkly different from typical desktop usage or even gaming usage
> > where multiple random audio streams are expected.
> >
> > Audio streams in DAW use cases, are highly predictable. In a typical
> setup,
> > there will be no audio coming from sources outside of the DAW framework
> > (this may involve and intercommunicating applications, however there
> would
> > be no random media player startups, or sound coming from a new web page
> for
> > example).
> >
> > The ability to "rewind" to insert new streams into the path of the
> hardware
> > buffers is not typical for these circumstances.
>
> You have complete misunderstanding. The usage of audio workstation is
> not so special in an aspect of using sound devices.
>
> It better for you to distinguish the size of PCM buffer, the
> communication delay on the data bus, process scheduling timing, and so
> on. I think you roughly lump them togather as a name of 'latency', and
> it brings unreasonable conclusions.
>
>
> Regards
>
> Takashi Sakamoto
>
