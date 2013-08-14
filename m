From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/2] add sysfs for acpi interfaces of thinkpad hardware
 mute
Date: Wed, 14 Aug 2013 09:43:13 +0200
Message-ID: <520B3511.7020604@canonical.com>
References: <1376458802-11923-1-git-send-email-alex.hung@canonical.com> <1376458937.30031.1.camel@x230> <CAJ=jqua8STZQideGbQTDh2W8iHcF4J9OJAC5tw-bkdBLLzsP2A@mail.gmail.com> <1376459647.30031.2.camel@x230> <CAJ=jqub1sRSzBRv_R6soDVAydRL+5nmA9-pMC4E+sgXhP6tbPw@mail.gmail.com> <1376460872.30031.4.camel@x230> <CAJ=jquaCHpBPKVYHKKCyMoih3NVCL8VmyiiN5Vy0UmTTTrwKjQ@mail.gmail.com> <1376463610.30031.6.camel@x230> <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Tim Chen <tim.chen119@canonical.com>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

(Added alsa-devel to CC)

On 08/14/2013 09:16 AM, Alex Hung wrote:
> Added in David and Tim who also has some ideas to share.
> 
> On Wed, Aug 14, 2013 at 3:00 PM, Matthew Garrett
> <matthew.garrett@nebula.com> wrote:
>> On Wed, 2013-08-14 at 14:41 +0800, Alex Hung wrote:
>>> Hi Matthew,
>>>
>>> The problem is that thinkpad-acpi does not aware of mute is changed by
>>> either hotkey presses or in desktop.
>>
>> Ok, how about this. Register the LED with the kernel LED subsystem. Add
>> a new LED trigger for volume-mute. Have the HDA driver call that trigger
>> whenever the mute state changes.
>>
>> --
>> Matthew Garrett <matthew.garrett@nebula.com>
> 
> 
> 

So, to take a wider grip on this issue.

First, the hardware mute. Because this is directly connected to the
internal speaker (and headphones?), it needs to turn into a ALSA
kcontrol on the sound card that controls speaker and/or headphones. And
it needs to named accordingly, e g "Speaker Playback Switch" if it
controls the speaker only.
Exactly how this is going to work out given the arbitrary module load
order of snd-hda-intel and thinkpad-acpi, I'm not sure, but the way of
creating another sound card (which I've seen on some thinkpads) just
isn't working out for userspace.

Second, about the mute LEDs and mic-mute LEDs, we currently have several
interfaces to choose from:
 a) HP LEDs currently uses a ALSA kcontrol to control them. For Mute LED
there is also a limited automatic control of this LED from kernel space
(by default), so it follows the status of "Master Playback Switch" IIRC.
 b) thinkpad-acpi currently uses custom sysfs nodes to control the LEDs.
 c) and we also have the /sys/class/leds interface.
There might be even more solutions.

It's important we get a consistent interfaces towards userspace for the
LEDs. And we should also make sure we don't have a permissions problem:
if we want the mute/mic-mute LED to follow the status of the currently
selected sound card in PulseAudio, which IMO should be our goal, writes
cannot be root-only.
To have the HDA driver call into the LED subsystem is better than
nothing, but in the end we would want the LEDs to follow whatever sound
input/output the user currently uses, whether that is bluetooth, USB,
HDMI, or internal audio.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
