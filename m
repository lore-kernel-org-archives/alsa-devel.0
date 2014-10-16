From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] thinkpad-acpi: Try to use full software mute control
Date: Thu, 16 Oct 2014 12:34:16 -0700
Message-ID: <CALCETrUsw07EXJQ+mYYQ5h3nmSqh=fbJLWvEGh--m=t_VVwJXQ@mail.gmail.com>
References: <cover.1413481880.git.luto@amacapital.net> <72f375b46a34702fc9f8be419fa83c219fbc28c5.1413481880.git.luto@amacapital.net>
 <20141016183130.GA15835@khazad-dum.debian.net> <CALCETrXz_x7E5aVvr7S1aTtGLbE8PKpVJFrBCZTEXZKjdi0F3w@mail.gmail.com>
 <20141016185455.GB15835@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20141016185455.GB15835@khazad-dum.debian.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2014 at 11:54 AM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Thu, 16 Oct 2014, Andy Lutomirski wrote:
>> > On IBM ThinkPads, the "generates KEY_foo" thing is controlable by the
>> > driver.  In fact, thinkpad_acpi defaults to NOT send these, all breakage
>> > is entirely the fault of userspace that enables it instead of doing OSD
>> > out of the extra mixer, and then fails to deal with the side-effects.
>>
>> Are you sure?  I'm reasonably confident that the KEY_MUTE comes from
>
> Yes.
>
>> i8042, not from an ACPI GPE.  Even without this patch, pressing the
>
> The EC *is* the i8042 in a ThinkPad.  Really.  You talk to the same chip and
> to the same firmware over the ACPI EC ports, the i8042 ports, and the
> Renesas extra LPC3 channel (used by HDAPS and SBS).

Huh, interesting.  That makes sense.

>
> That said, on a **IBM** ThinkPad, _nothing_ related to the digital volume
> control comes from the i8042 port.  In fact, with older BIOSes, you couldn't
> even get it from ACPI unless you hooked the GPE directly because the
> required ACPI L/E methods were missing and were added by later versions of
> the T4x/R4x/X3x BIOS.
>
> The EC firmware in a thinkpad is often more capable than what the BIOS
> exposes.
>
> KEY_MUTE comes from the i8042 in Lenovo Thinkpads, only.  And they started
> doing that when they removed the hardware volume control chip.  It was
> retrofitted in later versions of the T60 BIOS (v2.x), I don't know how well
> though.

So the question is: are there IBM models (or models that don't send
KEY_MUTE, anyway) that nonetheless expose HAUM and SAUM?  If not, then
my patch should be okay.  If so, we'll need further filtering.

>
>> > On Lenovo ThinkPads, it depends on BIOS/EC version for the X60/T60.  Later
>> > versions will behave like the X61/T61. Since family 200 you can tell the
>> > EC to switch modes (latch, toggle, none), but Lenovo didn't test it well
>> > enough.
>>
>> "none" seems to work well on all ThinkPads that I've tried.  The other
>> modes seem to have spotty support.
>
> I am fine that we go with "none" and emulate everything in the driver where
> supported, yes.
>
>> >> This behavior is unfortunate, since modern userspace will also
>> >> handle the hotkeys and change the other mixer.  If the software
>> >
>> > Like I said, we disable that by default, and userspace enables them back
>> > because they want to use it as a keyboard.  We could override it entirely
>> > on the IBM thinkpads, and refuse to issue any key events no matter what, I
>> > suppose.
>>
>> How?  The only way I ever found to do that was using the i8042_filter
>> in the older incarnations of this driver, and that was incredibly
>
> You didn't try it on a IBM thinkpad, just on Lenovo thinkpads, then...

I'm not sure I ever owned an IBM thinkpad.  I used Acer back then, and
my next laptop is quite likely to be

>
>> >> This should also allow us to remove _OSI(Linux) for all ThinkPads.
>> >
>> > No, it doesn't.  Only after an exaustive search for what _OSI(Linux)
>> > changes across a brickload of thinkpad ACPI dumps could we say that for
>> > sure.
>>
>> I think we only need that for the four models in question.  Also, all
>> the commit messages for those quirk additions seem to suggest that
>> they were done to improve volume controls.  And I'm pretty sure I
>> already checked at least one of those models (that's how I discovered
>> HAUM/SAUM in the first place).
>>
>> Anyway, patch 2 is optional.
>
> Since you did due diligency, I'm fine with that.  It is already in a
> separate patch, so it is easy to bissect and revert anyway.
>
>> >> + * The EC or perhaps SMM firmware can optionally automatically change
>> >> + * the volume in response to user input.  Unfortunately, this rarely
>> >
>> > It is the EC, which also emulates the i8042 KBC.
>> >
>> > I don't see any problems with the code, will have to test it in a IBM
>> > thinkpad, though (I have one).
>>
>> Please test v2 instead. :)
>
> I will only be able to do that during the weekend anyway, so feel free to
> send a v3 if you need :-)
>
> --
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh



-- 
Andy Lutomirski
AMA Capital Management, LLC
