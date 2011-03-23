From: Grzegorz Orciuch <g.orciuch@gmail.com>
Subject: snd-bt87x unknown soundcard, detected but no sound.
Date: Wed, 23 Mar 2011 11:26:46 +0100
Message-ID: <AANLkTim0UEfH619Kzufdfr1Xi6Y-GbtApK7Zgwe7WGgT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FE3210399E
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 11:26:47 +0100 (CET)
Received: by pwi9 with SMTP id 9so1236955pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 03:26:47 -0700 (PDT)
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

Hi,
I've the TV card which is=A0Kworld KW-TV878RF and tv module bttv gives
the vision well.
It registers also the sound device in lspci -vv:
----
01:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64 (1000ns min, 63750ns max)
Interrupt: pin A routed to IRQ 3
Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D4K]
Capabilities: [44] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
Not readable
Capabilities: [4c] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
-----
then I load the module snd-bt87x with no argument, then it says the
card is not detected.
Then I load the module as "modprobe snd-bt87x load_all=3D1
digital_rate=3D44100" (also 32k is not giving sound)
----
ALSA sound/pci/bt87x.c:866: unknown card 0x878-0x00:0x00
ALSA sound/pci/bt87x.c:869: please mail id, board name, and, if it
works, the correct digital_rate option to
<alsa-devel@alsa-project.org>
Bt87x 0000:01:08.1: PCI INT A -> GSI 17 (level, low) -> IRQ 17
ALSA sound/pci/bt87x.c:937: bt87x0: Using board 0, analog, digital
(rate 44100 Hz)
-----
Can you somehow help me ? Now I'm going to connect audio-out with
soundblaster line-in, as workaround.
BR,
Gregory
