From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-03-05-02-22.tar.gz
	uploaded
Date: Wed, 7 Mar 2007 20:41:30 +0100
Message-ID: <6bffcb0e0703071141j42309702w793e4a76b1b23bfa@mail.gmail.com>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
	<45EC2DEB.1050108@googlemail.com> <45EEA3C4.7000501@googlemail.com>
	<20070307104746.f08a2e84.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 16A3324338
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2007 20:41:42 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id j3so656572ugf
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2007 11:41:36 -0800 (PST)
In-Reply-To: <20070307104746.f08a2e84.akpm@linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 07/03/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 07 Mar 2007 12:36:36 +0100 Michal Piotrowski <michal.k.k.piotrows=
ki@gmail.com> wrote:
>
> > Michal Piotrowski napisa=B3(a):
> > > Hi,
> > >
> > > akpm@linux-foundation.org napisa=B3(a):
> > >> The mm snapshot broken-out-2007-03-05-02-22.tar.gz has been uploaded=
 to
> > >>
> > >>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2=
007-03-05-02-22.tar.gz
> > >>
> > >> It contains the following patches against 2.6.21-rc2:
> > >>
> > >
> > > Outstanding issue - my 3d surround doesn't work since 2.6.20.
> > >
> > > I'll bisect this commits
> > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D724339d76d9407cd1a8ad32a9c1fdf64840cc51b
> > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D6026179519896e7d35b2564e7544487d1c8948e7
> > >
> > > 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (IC=
H5/ICH5R) AC'97 Audio Controller (rev 02)
> > >         Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B-
> > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 0
> > >         Interrupt: pin B routed to IRQ 17
> > >         Region 0: I/O ports at d000 [size=3D256]
> > >         Region 1: I/O ports at d400 [size=3D64]
> > >         Region 2: Memory at f5fff800 (32-bit, non-prefetchable) [size=
=3D512]
> > >         Region 3: Memory at f5fff400 (32-bit, non-prefetchable) [size=
=3D256]
> > >         Capabilities: [50] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0=
+,D1-,D2-,D3hot+,D3cold+)
> > >                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> > >
> > > Advanced Linux Sound Architecture Driver Version 1.0.14rc2 (Wed Feb 1=
4 07:42:13 2007 UTC).
> > >
> > > CONFIG_SND=3Dm
> > > CONFIG_SND_TIMER=3Dm
> > > CONFIG_SND_PCM=3Dm
> > > CONFIG_SND_RAWMIDI=3Dm
> > > CONFIG_SND_SEQUENCER=3Dm
> > > CONFIG_SND_SEQ_DUMMY=3Dm
> > > CONFIG_SND_OSSEMUL=3Dy
> > > CONFIG_SND_MIXER_OSS=3Dm
> > > CONFIG_SND_PCM_OSS=3Dm
> > > CONFIG_SND_PCM_OSS_PLUGINS=3Dy
> > > CONFIG_SND_SEQUENCER_OSS=3Dy
> > > CONFIG_SND_RTCTIMER=3Dm
> > > CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
> > > # CONFIG_SND_DYNAMIC_MINORS is not set
> > > CONFIG_SND_SUPPORT_OLD_API=3Dy
> > > CONFIG_SND_VERBOSE_PROCFS=3Dy
> > > # CONFIG_SND_VERBOSE_PRINTK is not set
> > > # CONFIG_SND_DEBUG is not set
> > >
> > > CONFIG_SND_AC97_CODEC=3Dm
> > > CONFIG_SND_DUMMY=3Dm
> > > CONFIG_SND_VIRMIDI=3Dm
> > >
> > > CONFIG_SND_INTEL8X0=3Dm
> >
> > As I said above, center and rear speakers doesn't work with this patch.
> >
> > $ git-bisect good
> > 831466f4ad2b5fe23dff77edbe6a7c244435e973 is first bad commit
> > commit 831466f4ad2b5fe23dff77edbe6a7c244435e973
> > Author: Randy Cushman <rcushman_linux@earthlink.net>
> > Date:   Tue Dec 19 18:42:16 2006 +0100
> >
> >     [ALSA] ac97 - fix microphone and line_in selection logic
> >
> >     This patch fixes the Microphone and LINE_IN select logic for
> >     Analog Devices surround codecs with shared jacks.  The existing
> >     code can never utilize the shared jacks for Microphone and LINE_IN
> >     due to the reversed jack selection logic.  The patched code
> >     correctly selects the shared jack for input if the 'Channel Mode'
> >     selector does not specify that the jack is to be used for output.
> >     Specifically, in '2ch' mode the Center/LFE jack is used for
> >     microphone input and the Surround jack is used for LINE_IN,
> >     in '4ch' mode the Center/LFE jack is used for microphone input
> >     and the Surround jack is used for output, and in '6ch' mode
> >     both jacks are used for output.
> >
> >     Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>
> >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >     Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> >
>
> Is 2.6.21-rc3 similarly broken?

Yes.

>
> This patch reverts cleanly if needed.
>

Regards,
Michal

-- =

Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)
-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
