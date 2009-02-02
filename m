From: Tim Barnette <tim.barnette@gmail.com>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Mon, 2 Feb 2009 14:19:13 -0500
Message-ID: <b71cdde20902021119v48c1c6cdo8a6983f8e165102a@mail.gmail.com>
References: <4983FE7A.1040201@wanadoo.fr> <49840333.2080303@wanadoo.fr>
	<200902021620.52104.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F48310389A
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 20:19:15 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so808039wah.16
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2009 11:19:14 -0800 (PST)
In-Reply-To: <200902021620.52104.herton@mandriva.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Jean=2DPierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

Herton, I downloaded the patches. What do I do with them?  Will these
address MSI PCI enable and config mentioned in your email?

Thank You,
Tim Barnette

2009/2/2 Herton Ronaldo Krzesinski <herton@mandriva.com.br>

> Em S=E1bado 31 Janeiro 2009, =E0s 05:52:19, Jean-Pierre Andr=E9 escreveu:
> >
> > Hi,
> >
> > > Hi all, I have an HP DV4 1155-SE, I've been unable to get sound worki=
ng
> > > through the speakers, although it does work through the headhpones. I
> ran
> > > alsa-.upgrade which downloaded compiled, and installed 1.0.19 - still
> no
> > > luck.
> > >
> >
> > I have the same IDT codec 92HD71B7X on another
> > HP DV4 model, and I have tracked the problem to be
> > the kernel configuring IRQ 22 through the APIC, but
> > interrupts triggerring IRQ 20 (on kernel 2.6.27 and
> > alsa 1.0.19). It would be interesting if you could
> > confirm this by analyzing /proc/interrupts.
> >
> > The workarounds I know of are :
> > - adding irqpoll to the boot options,
> > - or adding noapic to the boot options,
> > - using mplayer to play music.
> >
> > There are with option "snd-hda-intel model=3Dhp-m4"
> > (this option is for HP DV5/DV7, but HP DV4
> > is probably different)
> >
> > I have not enough knowledge to tell where the problem
> > lies : kernel, apic, alsa.
>
> It looks like some of these HP laptops have some sort of IRQ issue indeed,
> to
> me it was reported that enabling pci MSI (both system wide and with
> enable_msi=3D1 given to snd-hda-intel) cured issues in some cases, along =
with
> some changes to sigmatel codec handling code in snd-hda-intel
>
> I have a ticked opened where people started to complain about sound issues
> with hda-intel+sigmatel codec starting with alsa 1.0.18rc3 (sorry, it's a
> great mess, type of the ticket everyone says sound doesn't work and report
> in,
> but where I tried to filter some things out):
> https://qa.mandriva.com/show_bug.cgi?id=3D44855
> Also some reports are hard to understand sometimes.
> With alsa 1.0.18 final in 2.6.27 (or 2.6.28) many issues related on the
> ticket
> were fixed, but issues with HP laptops remained.
>
> I don't have any of affected HP laptops for test, but based on sigmatel
> datasheets, reports of users and pin cfgs used in .ini files of sigmatel
> windows drivers I made some changes to sigmatel code, plus added patch to
> set
> enable_msi. The only issue I have with the changes, and that's why I didn=
't
> submit yet, is that I should have split them, don't know if everything is
> really required, and ask here to clarify some things below; also the
> changes
> are outdated compared to current sound git tree.
>
> I'm attaching here the changes, they were made against kernel 2.6.28.2
> - One patch deals with the sigmatel codec code, some things to note (othe=
rs
> are cited on the patch):
> * despite being almost the same, only with some models missing
> widgets/pins, I
> splitted support from patch_stac92hd71bxx for idt 92HD71B5X (4 port),
> 92HD75B1/2 (5 port). Mostly because of different number of pins between
> them,
> may be could have still hacked more stac92xx_set_config_regs to avoid thi=
s.
> * Many people complained about the Analog Loopback, causing problems when
> it's
> enabled; I really don't know what exactly this is supposed to do (is it
> just a
> mute of outputs or something like is described here?:
> http://people.atrpms.net/~pcavalcanti/alsa-1.0.15rc2_snd-hda-intel.html<h=
ttp://people.atrpms.net/%7Epcavalcanti/alsa-1.0.15rc2_snd-hda-intel.html>)
> and
> all sigmatel datasheets I look don't mention it, in the patch I removed i=
t.
> * power management on pins (stac92hd71bxx_pwr_nids) are not listed on
> sigmatel
> datasheets I dowloaded from idt site (for STAC92HD71Bx and STAC92HD75Bx),
> so I
> removed its setting (or I'm missing something here...).
> - The other patch adds a quirk list to force enable_msi=3D1. PCI_MSI must=
 be
> enabled to give results.
>
> >
> > Regards
> >
> > Jean-Pierre
> >
> >
> > > I ran alsa-info, output here:
> > >
> http://www.alsa-project.org/db/?f=3D844b7ee6468067460e17b7fc694e49052072a=
26f
> > >
> > > I filed a bug, here:
> > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4374
> > >
> > > Any ideas?
> > >
>
> --
> []'s
> Herton
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
