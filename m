From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Exposing the ThinkPad HW mute switch to ALSA?
Date: Mon, 6 Oct 2014 17:06:19 -0700
Message-ID: <CALCETrUKJTXVQ1qDtix=zxibb9KujuE96Xq9C2=qYYJX2j3U_w@mail.gmail.com>
References: <CALCETrULBrany=JLyZsfq6oiGDDUZOZyA+=7=GqLW8h+ZoHJVA@mail.gmail.com>
 <s5hoatpxsav.wl-tiwai@suse.de> <20141006190942.GA8238@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id D5582260309
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 02:06:39 +0200 (CEST)
Received: by mail-lb0-f178.google.com with SMTP id w7so5158593lbi.23
 for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2014 17:06:39 -0700 (PDT)
In-Reply-To: <20141006190942.GA8238@khazad-dum.debian.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 6, 2014 at 12:09 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Mon, 06 Oct 2014, Takashi Iwai wrote:
>> > ThinkPads have an extra mute switch that's controlled by the embedded
>> > controller.  There are some hardware buttons associated with it.
>> >
>> > We (thinkpad-acpi) can be notified about state changes in the mute
>> > switch, we can see presses of the hardware buttons and program them to
>> > send KEY_MUTE or not as appropriate, and we can (optionally) change
>> > the HW mute state.
>> >
>> > However, I have no clue how to correctly expose the mute switch
>> > through ALSA so that userspace will know what it controls.  It
>> > currently shows up as its own sound card, which is ridiculous.
>> >
>> > Can anyone give me any hints as to how to expose this bonus audio
>> > control in a sensible manner?  I know essentially nothing about ALSA.
>> >
>> > (Some older ThinkPads also have a hardware volume control with similar
>> > behavior.)
>>
>> It's a bit difficult issue, since this needs the weak module
>> dependency.  And even worse, different sound drivers might be used for
>> a single thinkpad_acpi.  So, from the programming POV, the individual
>> sound card instance is the easiest approach.
>>
>> Though, some HD-audio codec drivers already have a weak binding of
>> thinkpad_acpi stuff for Mic-mute switch.  I guess we can move the
>> handling of the master mute switch to the sound driver as well.
>>
>> If doing so, each relevant sound driver needs to implement it.
>> IIRC, snd-intel8x0 is used on old Thinkpads.  Any others?
>
> As far as I know, all old ones use the snd-intel8x0 AC97 hba, but several
> different codecs behind that.

FWIW, I don't know whether any of the pre-hda thinkpads have the ACPI
HAUM/SAUM mechanism, so I have no idea how good our support for the
hardware mute switch and controls will ever be on those laptops.

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
