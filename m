From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-03-05-02-22.tar.gz
	uploaded
Date: Mon, 05 Mar 2007 15:49:15 +0100
Message-ID: <45EC2DEB.1050108__31819.4367494018$1173106410$gmane$org@googlemail.com>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D444D177
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2007 15:50:58 +0100 (MET)
Received: by wx-out-0506.google.com with SMTP id h30so1487065wxd
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2007 06:50:57 -0800 (PST)
In-Reply-To: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

akpm@linux-foundation.org napisa=B3(a):
> The mm snapshot broken-out-2007-03-05-02-22.tar.gz has been uploaded to
> =

>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2007-0=
3-05-02-22.tar.gz
> =

> It contains the following patches against 2.6.21-rc2:
> =


Outstanding issue - my 3d surround doesn't work since 2.6.20.

I'll bisect this commits
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D724339d76d9407cd1a8ad32a9c1fdf64840cc51b
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D6026179519896e7d35b2564e7544487d1c8948e7

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH=
5R) AC'97 Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at d000 [size=3D256]
        Region 1: I/O ports at d400 [size=3D64]
        Region 2: Memory at f5fff800 (32-bit, non-prefetchable) [size=3D512]
        Region 3: Memory at f5fff400 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,=
D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

Advanced Linux Sound Architecture Driver Version 1.0.14rc2 (Wed Feb 14 07:4=
2:13 2007 UTC).

CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm

CONFIG_SND_INTEL8X0=3Dm

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
