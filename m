From: Tim Barnette <tim.barnette@gmail.com>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Sun, 1 Feb 2009 17:34:41 -0500
Message-ID: <b71cdde20902011434x690860d7jf9e1fc762ff2d3a9@mail.gmail.com>
References: <4983FE7A.1040201@wanadoo.fr> <49840333.2080303@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FE331037F0
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 23:34:45 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so609642wah.16
	for <alsa-devel@alsa-project.org>; Sun, 01 Feb 2009 14:34:44 -0800 (PST)
In-Reply-To: <49840333.2080303@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Jean=2DPierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean-Pierre, thank you for the suggestions.

Unfortunately, I have tried the boot options irqpoll, noapic with no luck.
Additionally, I installed mplayer and it produced no sound through the
speakers.  Finally, I added option snd-hda-intel model=3Dhp-m4 and hp-m5 in
alsa-base with no luck.

The whole time, if I plugged my headphones in, they would continue to work.

I did just notice one more thing. Although Linux shows my sounds as volume
all the way up, and not muted.  The speaker mute button on the laptop
appears in red with the mute symbol (meaning it's muted).  Any idea why that
is?  Possible that it's the wrong driver?  This is bizarre as the headhpones
work fine.

Any ideas?

On Sat, Jan 31, 2009 at 2:52 AM, Jean-Pierre Andr=E9 <
jean-pierre.andre@wanadoo.fr> wrote:

>
> Hi,
>
> > Hi all, I have an HP DV4 1155-SE, I've been unable to get sound working
> > through the speakers, although it does work through the headhpones. I r=
an
> > alsa-.upgrade which downloaded compiled, and installed 1.0.19 - still no
> > luck.
> >
>
> I have the same IDT codec 92HD71B7X on another
> HP DV4 model, and I have tracked the problem to be
> the kernel configuring IRQ 22 through the APIC, but
> interrupts triggerring IRQ 20 (on kernel 2.6.27 and
> alsa 1.0.19). It would be interesting if you could
> confirm this by analyzing /proc/interrupts.
>
> The workarounds I know of are :
> - adding irqpoll to the boot options,
> - or adding noapic to the boot options,
> - using mplayer to play music.
>
> There are with option "snd-hda-intel model=3Dhp-m4"
> (this option is for HP DV5/DV7, but HP DV4
> is probably different)
>
> I have not enough knowledge to tell where the problem
> lies : kernel, apic, alsa.
>
> Regards
>
> Jean-Pierre
>
>
> > I ran alsa-info, output here:
> >
> http://www.alsa-project.org/db/?f=3D844b7ee6468067460e17b7fc694e49052072a=
26f
> >
> > I filed a bug, here:
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4374
> >
> > Any ideas?
> >
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
