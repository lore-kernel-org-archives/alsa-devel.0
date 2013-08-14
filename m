From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/2] add sysfs for acpi interfaces of thinkpad hardware
 mute
Date: Wed, 14 Aug 2013 11:27:13 +0200
Message-ID: <520B4D71.6070109@canonical.com>
References: <1376458802-11923-1-git-send-email-alex.hung@canonical.com>  <1376458937.30031.1.camel@x230>  <CAJ=jqua8STZQideGbQTDh2W8iHcF4J9OJAC5tw-bkdBLLzsP2A@mail.gmail.com>  <1376459647.30031.2.camel@x230>  <CAJ=jqub1sRSzBRv_R6soDVAydRL+5nmA9-pMC4E+sgXhP6tbPw@mail.gmail.com>  <1376460872.30031.4.camel@x230>  <CAJ=jquaCHpBPKVYHKKCyMoih3NVCL8VmyiiN5Vy0UmTTTrwKjQ@mail.gmail.com>  <1376463610.30031.6.camel@x230>  <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>  <520B3511.7020604@canonical.com> <1376466691.30031.14.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1376466691.30031.14.camel@x230>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Alex Hung <alex.hung@canonical.com>, Tim Chen <tim.chen119@canonical.com>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 08/14/2013 09:51 AM, Matthew Garrett wrote:
> On Wed, 2013-08-14 at 09:43 +0200, David Henningsson wrote:
> 
>> First, the hardware mute. Because this is directly connected to the
>> internal speaker (and headphones?), it needs to turn into a ALSA
>> kcontrol on the sound card that controls speaker and/or headphones. And
>> it needs to named accordingly, e g "Speaker Playback Switch" if it
>> controls the speaker only.
>> Exactly how this is going to work out given the arbitrary module load
>> order of snd-hda-intel and thinkpad-acpi, I'm not sure, but the way of
>> creating another sound card (which I've seen on some thinkpads) just
>> isn't working out for userspace.
> 
> Sure. There was arguably a benefit in exposing the hardware mixer back
> in the *40 and earlier machines, since volume was also under hardware
> control back then. The mute support is somewhat vestigial, and I don't
> think trying to tie into it is going to make things better.

You seem to know the history better than I do, but if there are
significant power savings or some faint noise removed (e g by turning an
amplifier off or so) by using the hardware mute, then it could still be
worth pursuing.

>> Second, about the mute LEDs and mic-mute LEDs, we currently have several
>> interfaces to choose from:
>>  a) HP LEDs currently uses a ALSA kcontrol to control them. For Mute LED
>> there is also a limited automatic control of this LED from kernel space
>> (by default), so it follows the status of "Master Playback Switch" IIRC.
> 
> HDA has support for mute LEDs that are tied to GPIO lines on the codec -
> is this the extent of it?

Yes, essentially. HDA has support for GPIOs, and HP on IDT codecs use
that to control LEDs. HP on Realtek codecs (not as common) use VREF
outputs on unused mic pins.

>>  b) thinkpad-acpi currently uses custom sysfs nodes to control the LEDs.
> 
> Right.
> 
>>  c) and we also have the /sys/class/leds interface.
> 
> Yeah.
> 
>> It's important we get a consistent interfaces towards userspace for the
>> LEDs. And we should also make sure we don't have a permissions problem:
>> if we want the mute/mic-mute LED to follow the status of the currently
>> selected sound card in PulseAudio, which IMO should be our goal, writes
>> cannot be root-only.
> 
> I'm not convinced that should be our goal - if the mic mute light is on,
> I'd expect *all* mics to be muted, since the point of the light there is
> something of a privacy guard. 

I see your point, but the question is what is more of a privacy guard
here. Do you expect USB mics and Bluetooth mics/headsets to be muted too?

If so, are you expecting some kind of kernel-wide block of recording,
including bluetooth, USB, and other sound cards? It does not sound like
a practical approach to me.

And if not, where do you draw the line and why?

> It's not quite as clear that I'd expect
> the mute LED to bind to everything. However, given a single "currently
> selected sound card", there's no obviously user-visible difference
> between muting the current device and muting all devices.
> 
> Given the privacy concerns around the microphone LED, I think any
> exposed LED would have to be either under kernel control. Having a
> compromised component of a user session be able to record audio while
> leaving the LED lit would be a problem.

To decide what the LEDs bind to is a design issue. I was thinking that
by giving control to userspace would give different
implementations/distros/etc the most freedom to do what design they wanted.

However, since, the hotkeys and the mutes are often very closely related
physically (e g the mute LED is physically located on the mute button),
I would expect them to follow each other. And the mute hotkey mutes the
current default PulseAudio output, so I'd expect the mic mute hotkey to
mute the current default PulseAudio input, and the LEDs to update
according to those mute states.

The privacy issue is interesting, but I don't see a practical way of
implementing things that would protect us against compromised userspaces.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
