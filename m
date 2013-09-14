From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB Audio initialization race
Date: Sat, 14 Sep 2013 09:44:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1309140939540.30219-100000@netrider.rowland.org>
References: <5233A426.7070606@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by alsa0.perex.cz (Postfix) with SMTP id 1A5412617AB
 for <alsa-devel@alsa-project.org>; Sat, 14 Sep 2013 15:44:52 +0200 (CEST)
In-Reply-To: <5233A426.7070606@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Sep 2013, David Henningsson wrote:

> 2013-09-13 17:06, Alan Stern skrev:
> > On Fri, 13 Sep 2013, David Henningsson wrote:
> >
> >> 2013-09-13 16:39, Alan Stern skrev:
> >>> On Fri, 13 Sep 2013, David Henningsson wrote:
> >>>
> >>>> I'm sometimes seeing that USB audio devices are not initialized
> >>>> correctly by PulseAudio, but I can't reproduce this myself.
> >>>>
> >>>> I have, however, spotted what I think is a race condition in the driver
> >>>> code, if a device has more than one interface. snd_card_register is
> >>>> called once for every interface, which means that it will be shown to
> >>>> userspace after the first interface has been probed. So the race could
> >>>> look like:
> >>>>
> >>>> 1) The first interface is probed, which might contain the mixer controls
> >>>> 2) snd_card_register is called, which sends a signal to userspace
> >>>> 3) PulseAudio probes the device and notices that it has no PCMs, so it
> >>>> ignores the device
> >>>> 4) The second interface is probed, which adds the PCMs
> >>>> 5) snd_card_register is again called, which is a no-op since the card
> >>>> already exist
> >>>> 6) User is unhappy because his plugged in sound card did not show up in
> >>>> PulseAudio.
> >>>>
> >>>> So, assuming all this is right, it seems like we need some type of
> >>>> callback from the usb driver when all the interfaces for the sound card
> >>>> has been probed, so we can call snd_card_register at that point instead.
> >>>> Thoughts?
> >>> The driver probably doesn't know when all the interfaces have been
> >>> probed.
> >> I'm unsure if you mean "the usb driver" or "the usb audio driver" in the
> >> sentence above, but the USB driver would enumerate all interfaces and
> >> call the usb audio driver for every interface, and so the USB driver
> >> would know when all the interfaces have been probed, right?
> > I'm not sure what you mean by "the USB driver".  The USB core registers
> > all the interfaces, which causes them to be probed.  The USB core does
> > know when all the interfaces have been registered.
> Ok.
> >> Is there a way the USB audio driver can subscribe, or get an additional
> >> callback of some sort, when that happens?
> > No, not currently.
> 
> Given the use case we have here, do you think that would be a reasonable 
> solution to the problem?

I'd prefer to look at other solutions.

> >>> Maybe it would be better to send a signal to userspace each
> >>> time snd_card_register is called, even if nothing is done.
> >> That sounds very suboptimal, given that PulseAudio's probing mechanism
> >> can be quite heavy (depending on the device).
> 
> As Clemens said, there are device nodes being added, but having a look 
> at how this is handled in udev's 78-sound-card.rules [1], the rule has a 
> big comment section in the beginning. This comment claims that |"||The 
> control device node creation can be used as synchronization point". I 
> understand this will happen on the first call to snd_card_register, and 
> only then.|
> 
> >>> Alternatively, when the first interface is probed, the driver could
> >>> claim all the other interfaces belonging to the same association.
> >> Not sure how well that would work out with "composite" devices, e g
> >> headset with volume up/down buttons?
> > Presumably the HID interface (with the button controls) would not be in
> > the audio interface association.  Anyway, the audio driver wouldn't
> > claim anything that wasn't an audio interface.
> Ok, I'll trust you to know this better than me. :-)
> 
> I'm not sure exactly what "claim all the other interfaces belonging to 
> the same association" means, but if it means it can enumerate all those 
> interfaces it has claimed but not yet probed, maybe the USB audio driver 
> can use this information to avoid calling snd_card_register until after 
> probing the last interface?

A driver claims an interface when it wants to be bound to that
interface right away, without waiting for a probe.  Thus, when the
first audio interface in a USB device is probed, the audio driver takes 
the opportunity to claim all the other audio interfaces associated with 
it.

In this case, it sounds like the control interface (A) gets probed,
which causes the sound card to be registered.  A little later, the PCM
interface (B) is probed.  The sound driver recognizes that interface B
is connected with interface A and adds this information to the sound
card, but it's already too late.

So here's my question: If the sound driver recognizes that interface B
is connected with interface A when B is probed, why can't it recognize
this fact when A is probed?  It could claim B while A's probe is
running.  Then the sound card would be registered with the PCM 
component already in place.

Alan Stern
