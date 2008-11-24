From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Re: Medion MD96420. ALC883/ALC268 conflicts
Date: Tue, 25 Nov 2008 00:14:32 +0100
Message-ID: <200811250014.32126.cave.dnb2m97pp@aliceadsl.fr>
References: <200811241658.04771.cave.dnb2m97pp@aliceadsl.fr>
	<s5hljv9xf4g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 82F9D244AE
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 00:14:36 +0100 (CET)
Received: from [192.168.0.230] (213.36.0.219) by mail.libertysurf.net
	(7.3.118.8) id 49255ECD00133FBA for alsa-devel@alsa-project.org;
	Tue, 25 Nov 2008 01:10:33 +0100
In-Reply-To: <s5hljv9xf4g.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 24 November 2008 17:28, Takashi Iwai wrote:
> At Mon, 24 Nov 2008 16:58:04 +0100,
>
> Nigel Henry wrote:
> > I've been helping GN out on the user list, to get his sound working. The
> > sound is now working, but only by using the options line below.
> > options snd-hda-intel probe_mask=1. I see on the changelog for 1.0.18 >
> > 1.0.18a that Takashi added a quirk for a Medion MD96630 as below.
> >
> > <quote>
> > - ALSA: hda - Add a quirk for MEDION MD96630
> > Use model=lenovo-ms7195-dig for MEDION MD96630 laptop (17c0:4085)
> > with ALC888 codec.
> > Reference: Novell bnc#412548
> > https://bugzilla.novell.com/show_bug.cgi?id=412528
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> >
> > <end quote>
> >
> > Some details of his machine, OS, and other output below.
> >
> > Medion MD96420. Model MIM 2300 Notebook PC
> >
> > OS: Fedora 9, with alsadriver 1.0.16 upgraded to 1.0.18a
> >
> > Desktop:  KDE 4.1
> >
> > /sbin/lspci  (soundcard part)
> > 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
> > Controller (rev 03)
> >  Subsystem: Mitac Unknown device 8227
> >  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR+ FastB2B- DisINTx-
> >  Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> > <MAbort- >SERR- <PERR- INTx-
> >  Latency: 0, Cache Line Size: 64 bytes
> >  Interrupt: pin A routed to IRQ 22
> >  Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=16K]
> >  Capabilities: <access denied>
> >  Kernel driver in use: HDA Intel
> >  Kernel modules: snd-hda-intel
> >
> > [graeme@flintstone ~]$ cat /proc/asound/cards
> >   0 [Intel          ]: HDA-Intel - HDA Intel
> >                        HDA Intel at 0xfc200000 irq 22
> >
> > [graeme@flintstone ~]$ grep ^Codec /proc/asound/card?/codec*
> > /proc/asound/card0/codec#0:Codec: Realtek ALC883
> > /proc/asound/card0/codec#1:Codec: LSI ID 1040
> > /proc/asound/card0/codec#2:Codec: Realtek ALC268
>
> I seem to forget the fix for probe_mask.
> How about the patch below?
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index c5eb36b..86d5cef 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2073,6 +2073,8 @@ static struct snd_pci_quirk probe_mask_list[]
> __devinitdata = { SND_PCI_QUIRK(0x17aa, 0x20ac, "Thinkpad X/T/R61", 0x01),
>   /* broken BIOS */
>   SND_PCI_QUIRK(0x1028, 0x20ac, "Dell Studio Desktop", 0x01),
> + /* including bogus ALC268 in slot#2 that conflicts with ALC888 */
> + SND_PCI_QUIRK(0x17c0, 0x4085, "Medion MD96630", 0x01),
>   {}
>  };

Apologies if I'm not understanding your reply.

There does not appear to be a problem with probe_mask=1 , as when he uses that 
as below, the sounds work on his Medion MD96420 laptop.
options snd-hda-intel probe_mask=1

What appears to be needed is a quirk to be added for the Medion MD96420 
laptop, much as you have done for the Medion MD96630 above.

It appears that you need more info to add the quirk. I can find the vendor ID 
(17co Wistrom Corp), but no product ID's are listed.

Any suggestions as to what he can do to get the necessary info that you may 
need to apply the quirk for this machine?

Nigel.
