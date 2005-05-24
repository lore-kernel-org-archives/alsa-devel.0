From: Atro Tossavainen <atossava@cc.helsinki.fi>
Subject: Gainward Hollywood@Home 7.1 Sound Card
Date: Tue, 24 May 2005 15:49:19 +0300 (EEST)
Message-ID: <200505241249.j4OCnJ7H016485@kruuna.helsinki.fi>
Reply-To: Atro.Tossavainen@helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kruuna.helsinki.fi (kruuna.helsinki.fi [128.214.205.14])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8D1E91E3
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 14:49:20 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: manne.laukkanen@sci.fi
List-Id: alsa-devel@alsa-project.org

Hello,

A friend of mine gave me a Gainward Hollywood@Home 7.1 Sound Card to
play with since he couldn't get it to work in Linux and figured that
if there was somebody who could it'd be me.  Well, I can't, because
this particular card isn't supported in ALSA although its chipset is.

In lspci -vvvv, it appears thus:

00:0b.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
        Subsystem: CardExpert Technology: Unknown device 0200
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e400 [size=32]
        Region 1: I/O ports at e800 [size=128]
        Capabilities: [80] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

When I modprobe snd-ice1724, the following appears in dmesg:

ice1724: No matching model found for ID 0xb0100002
ice1724: Invalid EEPROM version 1

These results are from a vanilla 2.6.11 kernel.  Help is appreciated,
but this is certainly not an urgent issue.

Regards,
-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
