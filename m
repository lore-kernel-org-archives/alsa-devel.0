From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Exposing the ThinkPad HW mute switch to ALSA?
Date: Tue, 7 Oct 2014 17:25:13 +1100
Message-ID: <CACckToV0LiiZywtPT4OmvwuK6qVX41wbwuUiR-JdjG87javH_g@mail.gmail.com>
References: <CALCETrULBrany=JLyZsfq6oiGDDUZOZyA+=7=GqLW8h+ZoHJVA@mail.gmail.com>
 <s5hoatpxsav.wl-tiwai@suse.de>
 <20141006190942.GA8238@khazad-dum.debian.net>
 <CALCETrUKJTXVQ1qDtix=zxibb9KujuE96Xq9C2=qYYJX2j3U_w@mail.gmail.com>
 <s5hsij0lacx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 38442260411
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 08:25:14 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id gq15so5787682lab.12
 for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2014 23:25:13 -0700 (PDT)
In-Reply-To: <s5hsij0lacx.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andy Lutomirski <luto@amacapital.net>
List-Id: alsa-devel@alsa-project.org

so I have a really dumb question.

Why can't the controls be mapped as HCI rather than a soundcard? given
there's no audio production capability here only a control capability.

Also this seems to be how they end up functioning on a modern system they
get bound to pulse which remaps them to whatever's 'active'

Why does everyone say that this is a soundcard when it's really a keyboard
(from my pov)

also what's the least surprise here?

Should this control control volume of my BT headset when it's active (It
currently does which I find convenient but I can see an argument that it's
surprising and should be bound to the phys hardware on the laptop)

On Tue, Oct 7, 2014 at 4:25 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 6 Oct 2014 17:06:19 -0700,
> Andy Lutomirski wrote:
> >
> > On Mon, Oct 6, 2014 at 12:09 PM, Henrique de Moraes Holschuh
> > <hmh@hmh.eng.br> wrote:
> > > On Mon, 06 Oct 2014, Takashi Iwai wrote:
> > >> > ThinkPads have an extra mute switch that's controlled by the
> embedded
> > >> > controller.  There are some hardware buttons associated with it.
> > >> >
> > >> > We (thinkpad-acpi) can be notified about state changes in the mute
> > >> > switch, we can see presses of the hardware buttons and program them
> to
> > >> > send KEY_MUTE or not as appropriate, and we can (optionally) change
> > >> > the HW mute state.
> > >> >
> > >> > However, I have no clue how to correctly expose the mute switch
> > >> > through ALSA so that userspace will know what it controls.  It
> > >> > currently shows up as its own sound card, which is ridiculous.
> > >> >
> > >> > Can anyone give me any hints as to how to expose this bonus audio
> > >> > control in a sensible manner?  I know essentially nothing about
> ALSA.
> > >> >
> > >> > (Some older ThinkPads also have a hardware volume control with
> similar
> > >> > behavior.)
> > >>
> > >> It's a bit difficult issue, since this needs the weak module
> > >> dependency.  And even worse, different sound drivers might be used for
> > >> a single thinkpad_acpi.  So, from the programming POV, the individual
> > >> sound card instance is the easiest approach.
> > >>
> > >> Though, some HD-audio codec drivers already have a weak binding of
> > >> thinkpad_acpi stuff for Mic-mute switch.  I guess we can move the
> > >> handling of the master mute switch to the sound driver as well.
> > >>
> > >> If doing so, each relevant sound driver needs to implement it.
> > >> IIRC, snd-intel8x0 is used on old Thinkpads.  Any others?
> > >
> > > As far as I know, all old ones use the snd-intel8x0 AC97 hba, but
> several
> > > different codecs behind that.
> >
> > FWIW, I don't know whether any of the pre-hda thinkpads have the ACPI
> > HAUM/SAUM mechanism, so I have no idea how good our support for the
> > hardware mute switch and controls will ever be on those laptops.
>
> IIRC, they have, and the mute worked completely independently from the
> onboard sound controller.  But my memory is pretty vague.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
