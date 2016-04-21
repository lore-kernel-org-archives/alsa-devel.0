From: Allan Klinbail <aklinbail@gmail.com>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 21:16:33 +0000
Message-ID: <CA+aoAJdDzP4F-Woru+tzcWvYY05BuKBR31pWabGzh5hn3Fhniw@mail.gmail.com>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
 <57181862.6060501@sakamocchi.jp>
 <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
 <571836C0.40605@sakamocchi.jp>
 <CA+aoAJeU=y=mP0=_xeQXDfcG5uWg8azpuddQG6MxJ=NEZkA31A@mail.gmail.com>
 <57185E39.5090401@sakamocchi.jp>
 <CA+aoAJdVcu0C6KiLEDTf38awUAjtk2xddumicFNRw-QXx2Ww2w@mail.gmail.com>
 <5718A236.3070104@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9980926683D
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 23:16:43 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id u206so151970594wme.1
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 14:16:43 -0700 (PDT)
In-Reply-To: <5718A236.3070104@sakamocchi.jp>
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

I'm sorry I've made you so upset.
I'm only taking the perspective of how these devices are used. Which you
may feel unproductive,  however many of us feel is important.

I do work in system design for corporate IT,  and while we sometimes come
up with a perfect system, they might not fit the use case.  It upsets and
frustrates us, but if the design does not fit the use case it is not going
to be used and our project will not get funding.

I really do understand where you are coming from,  not from a technical
perspective but how this might be frustrating.

The point of the last email wasn't to ask you to change focus on how you
address the issue of latency but explaining the reality that until the
software changes,  that a new approach is not going to be utilised.  This
covers both open and closed (commercial)  software.

That doesn't make it a bad endeavour it is always good to work for better
solutions,  but you are likely to come up against people like me who would
like the driver to fit the existing use cases.

I did request one change, which was to make an abstraction  so that a user
does not have trouble addressing these devices as one device, without
having to perform complex configuration tasks..  I do understand that
technically that isn't how the device works,  but it is not useful to for
the user to treat it as separate devices.

While you may consider this an unproductive conversation from a technical
standpoint,  as you have stated,  I am not the only person/owner of a
device to raise this issue.  That would indicate that the current
implementation doesn't fit the real world use cases for the devices.

Whether that means someone else has to write a simple abstraction to make
the device seen as one device,  or something else has to happen,  I don't
know...

As Jonathan Woithe has pointed out on FFADO lists,  the long term  goal IS
for ALSA to take over the streaming function. With FFADO to remain in
userspace to potentially provide mixer tools or other functions.

For those off us that have bought these devices many have spent a lot of
money for particular use cases and performance , and in the case of this
specific device spending in the order of 3,000 USD.  Many of us using the
devices with commercial software for professional or semi-professional
uses.

That makes this particular conversation quite scary and very important.

BTW,  telling me my brain can't be fixed is pretty hostile.. However,  I'll
assume that this is a language issue rather than deliberately intending to
offend me.





On Thu, 21 Apr 2016 7:49 pm Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> First, I have no hostility to you.
>
> Since I extended snd-dice in the late of 2014, I have been exposed to
> the similar insistences many times, in public or private, from users who
> own Dice-based models. Their insistences tends to include unreasonbable
> judgements about something related, ignorance of developers' intension
> and the state of development for ALSA firewire stack. So I feel to have
> a waste of time to receive such intensions, because they're not
> productive at all.
>
>
> On Apr 21 2016 14:38, Allan Klinbail wrote:
> > As I admitted, my understanding is basic and limited. Clearly I have got
> it
> > wrong.
> >
> > However, (snip)
>
> Well, you still repeat the same insistences again, after our discussion.
> It means that I fail to refresh your knowledge about PCM frame handling
> in this operating systems. That's a pretty sad to me.
>
>
> One of my motivation to work for ALSA firewire stack is to use sound and
> music units on IEEE 1394 bus for the purpose as you described, via ALSA
> kernel/userspace interface, according to ways reasonable to many system
> requirements.
>
> The shape of ALSA firewire stack represents the requrements from design
> of actual operating system, actual sound subsystem in Linux, actual
> audio and music units on IEEE 1394 bus, actual packet streaming protocol
> and actual quirks of the units. If you need my technical explaination
> about them, I'm willing to describe them. You won't accept it even if I
> did, because I've already introduced a part of them and you won't
> refresh your brain.
>
> This is the end of such an unproductive discussion, sorry.
>
>
> Regards
>
> Takashi Sakamoto
>
