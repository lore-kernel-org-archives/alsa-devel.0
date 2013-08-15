From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [alsa-devel] [PATCH 0/2] add sysfs for acpi interfaces of
 thinkpad hardware mute
Date: Thu, 15 Aug 2013 19:54:36 +0530
Message-ID: <1376576676.9527.39.camel@localhost>
References: <1376458802-11923-1-git-send-email-alex.hung@canonical.com>
	 <1376458937.30031.1.camel@x230>
	 <CAJ=jqua8STZQideGbQTDh2W8iHcF4J9OJAC5tw-bkdBLLzsP2A@mail.gmail.com>
	 <1376459647.30031.2.camel@x230>
	 <CAJ=jqub1sRSzBRv_R6soDVAydRL+5nmA9-pMC4E+sgXhP6tbPw@mail.gmail.com>
	 <1376460872.30031.4.camel@x230>
	 <CAJ=jquaCHpBPKVYHKKCyMoih3NVCL8VmyiiN5Vy0UmTTTrwKjQ@mail.gmail.com>
	 <1376463610.30031.6.camel@x230>
	 <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>
	 <520B3511.7020604@canonical.com> <1376466691.30031.14.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1376466691.30031.14.camel@x230>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: David Henningsson <david.henningsson@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tim Chen <tim.chen119@canonical.com>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, Alex Hung <alex.hung@canonical.com>, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-08-14 at 07:51 +0000, Matthew Garrett wrote:
> On Wed, 2013-08-14 at 09:43 +0200, David Henningsson wrote:
> 
> > First, the hardware mute. Because this is directly connected to the
> > internal speaker (and headphones?), it needs to turn into a ALSA
> > kcontrol on the sound card that controls speaker and/or headphones. And
> > it needs to named accordingly, e g "Speaker Playback Switch" if it
> > controls the speaker only.
> > Exactly how this is going to work out given the arbitrary module load
> > order of snd-hda-intel and thinkpad-acpi, I'm not sure, but the way of
> > creating another sound card (which I've seen on some thinkpads) just
> > isn't working out for userspace.
> 
> Sure. There was arguably a benefit in exposing the hardware mixer back
> in the *40 and earlier machines, since volume was also under hardware
> control back then. The mute support is somewhat vestigial, and I don't
> think trying to tie into it is going to make things better.
> 
> > Second, about the mute LEDs and mic-mute LEDs, we currently have several
> > interfaces to choose from:
> >  a) HP LEDs currently uses a ALSA kcontrol to control them. For Mute LED
> > there is also a limited automatic control of this LED from kernel space
> > (by default), so it follows the status of "Master Playback Switch" IIRC.
> 
> HDA has support for mute LEDs that are tied to GPIO lines on the codec -
> is this the extent of it?
> 
> >  b) thinkpad-acpi currently uses custom sysfs nodes to control the LEDs.
> 
> Right.
> 
> >  c) and we also have the /sys/class/leds interface.
> 
> Yeah.
> 
> > It's important we get a consistent interfaces towards userspace for the
> > LEDs. And we should also make sure we don't have a permissions problem:
> > if we want the mute/mic-mute LED to follow the status of the currently
> > selected sound card in PulseAudio, which IMO should be our goal, writes
> > cannot be root-only.
> 
> I'm not convinced that should be our goal - if the mic mute light is on,
> I'd expect *all* mics to be muted, since the point of the light there is
> something of a privacy guard. It's not quite as clear that I'd expect
> the mute LED to bind to everything. However, given a single "currently
> selected sound card", there's no obviously user-visible difference
> between muting the current device and muting all devices.
> 
> Given the privacy concerns around the microphone LED, I think any
> exposed LED would have to be either under kernel control. Having a
> compromised component of a user session be able to record audio while
> leaving the LED lit would be a problem.

The privacy concerns valid, but they're not insurmountable. You could
make userspace listen to the LED status and react as if the mute button
was pressed, making sure the two can never really go out of sync (just
an example off the top of my head).

Even if you don't do that, IMO it makes sense to expose the LEDs to
userspace. We're effectively talking about how the LEDs should behave as
an extension of the UI, and freezing the policy that governs that UI in
userspace is pretty inflexible.

-- Arun
