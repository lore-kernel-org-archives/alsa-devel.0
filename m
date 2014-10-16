From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] thinkpad-acpi: Try to use full software mute control
Date: Thu, 16 Oct 2014 11:40:06 -0700
Message-ID: <CALCETrXz_x7E5aVvr7S1aTtGLbE8PKpVJFrBCZTEXZKjdi0F3w@mail.gmail.com>
References: <cover.1413481880.git.luto@amacapital.net> <72f375b46a34702fc9f8be419fa83c219fbc28c5.1413481880.git.luto@amacapital.net>
 <20141016183130.GA15835@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20141016183130.GA15835@khazad-dum.debian.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, Jerone Young <jerone.young@canonical.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2014 at 11:31 AM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Thu, 16 Oct 2014, Andy Lutomirski wrote:
>> ThinkPads have hardware volume controls and three buttons to control
>> them.  (These are separate from the standard mixer.)  By default,
>> the buttons are:
>>
>>  - Mute: Mutes the hardware volume control and generates KEY_MUTE.
>>  - Up: Unmutes, generates KEY_VOLUMEUP, and increases volume if
>>    applicable.  (Newer thinkpads only have hardware mute/unmute.)
>>  - Down: Unmutes, generates KEY_VOLUMEDOWN, and decreases volume
>>    if applicable.
>
> On IBM ThinkPads, the "generates KEY_foo" thing is controlable by the
> driver.  In fact, thinkpad_acpi defaults to NOT send these, all breakage
> is entirely the fault of userspace that enables it instead of doing OSD
> out of the extra mixer, and then fails to deal with the side-effects.

Are you sure?  I'm reasonably confident that the KEY_MUTE comes from
i8042, not from an ACPI GPE.  Even without this patch, pressing the
mute button sends KEY_MUTE.  Maybe there's a control I missed, but if
we turn off KEY_MUTE, then I don't know how we'd be notified at all
that the HW mixer changed state.  (In any case, with this patch,
everything seems to work.)

>
> On Lenovo ThinkPads, it depends on BIOS/EC version for the X60/T60.  Later
> versions will behave like the X61/T61. Since family 200 you can tell the
> EC to switch modes (latch, toggle, none), but Lenovo didn't test it well
> enough.

"none" seems to work well on all ThinkPads that I've tried.  The other
modes seem to have spotty support.

>
>> This behavior is unfortunate, since modern userspace will also
>> handle the hotkeys and change the other mixer.  If the software
>
> Like I said, we disable that by default, and userspace enables them back
> because they want to use it as a keyboard.  We could override it entirely
> on the IBM thinkpads, and refuse to issue any key events no matter what, I
> suppose.

How?  The only way I ever found to do that was using the i8042_filter
in the older incarnations of this driver, and that was incredibly
complex, added little obvious value, and *still* didn't give a fully
consistent UI, since userspace doesn't understand the extra thinkpad
mixer.

>
>> This should also allow us to remove _OSI(Linux) for all ThinkPads.
>
> No, it doesn't.  Only after an exaustive search for what _OSI(Linux)
> changes across a brickload of thinkpad ACPI dumps could we say that for
> sure.

I think we only need that for the four models in question.  Also, all
the commit messages for those quirk additions seem to suggest that
they were done to improve volume controls.  And I'm pretty sure I
already checked at least one of those models (that's how I discovered
HAUM/SAUM in the first place).

Anyway, patch 2 is optional.

>
>> For future reference: It turns out that we can ask ACPI for one of
>> three behaviors directly on very new models.  They are "latch" (the
>> default), "none" (no automatic control), and "toggle" (mute unmutes
>> when muted).  All of the modes besides "none" seem to be a bit buggy,
>> though, and there is no known way to get any notification that the
>> hardware state has changed other than listening for a mute button
>> press on the i8042 port.
>
> Yeah.
>
>> + * The EC or perhaps SMM firmware can optionally automatically change
>> + * the volume in response to user input.  Unfortunately, this rarely
>
> It is the EC, which also emulates the i8042 KBC.
>
> I don't see any problems with the code, will have to test it in a IBM
> thinkpad, though (I have one).

Please test v2 instead. :)

--Andy

>
> --
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh



-- 
Andy Lutomirski
AMA Capital Management, LLC
