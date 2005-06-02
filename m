From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001149]: CPU overload error and arts exits
Date: Thu, 2 Jun 2005 15:26:06 +0200
Message-ID: <1185db2efb7f79235c8368624ecdabeb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D43031A9
	for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2005 15:26:06 +0200 (MEST)
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
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1149> 
======================================================================
Reported By:                anandrajan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1149
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.3 Pro x86-64 version
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-01-2005 16:35 CEST
Last Modified:              06-02-2005 15:26 CEST
======================================================================
Summary:                    CPU overload error and arts exits
Description: 
Hardware: A7V Deluxe with onboard Realtek ALC 850 sound and Marvel gigabit
ethernet, AMD Athlon 64 3000+, 1GB DDR 400, two IDE disks, NEC DVD RW,
Plextor CD-RW, ELSA GLoria III nVidia Quadro2 Pro videocard, Soundblaster
Live PCI soundcard

Software: SuSE 9.3 Pro x86-64 version, KDE 3.4, alsa 1.0.8 drivers

Originally I had configured both the onboard Realtek and the Soundblaster
cards. Then I removed the Realtek from the configuration. Unfortunately
and even when full duplex is not checked in KDE 3.4, I get a CPU overload
error and then arts exits. If I monitor what's happening, I see the CPU
usage in arts increasing until it maxes out the CPU after which I get this
error. The arts page claims that this is a driver issue.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-01-05 16:45 
----------------------------------------------------------------------
Try 1.0.9.  This should have been fixed.

----------------------------------------------------------------------
 anandrajan - 06-02-05 15:26 
----------------------------------------------------------------------
I upgraded to 1.0.9 and the results are mixed - sorry couldn't resist :-).
While arts doesn't crash after KDE starts up, I can make arts crash by
enabling system sounds and resizing a window several times in succession.
Don't know if this is a emu10k1 (alsa) or arts problem. When the window is
resized several times and arts has to emit a sound each time, it draws
more and more of the CPU and then crashes. Also, I've seen arts crash by
itself a couple of times. Regardless, it works better now but not
perfectly.

Duplex is enabled right now. Also, I've attached my /dev/sndstat file
since it still claims that I'm running alsa 1.0.8 in emulation.

Output of /dev/sndstat

Sound Driver:3.8.1a-980706 (ALSA v1.0.8 emulation code)
Kernel: Linux agape-server 2.6.11.4-20a-default
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Wed Mar 23 21:52:37 UTC
2005 x86_64
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
Sound Blaster Live! (rev.8, serial:0x80271102) at 0xd800, irq 185

Audio devices:
0: EMU10K1 (DUPLEX)

Synth devices:
0: Emu10k1

Midi devices:
0: EMU10K1 MPU-401 (UART)

Timers:
7: system timer

Mixers:
0: Cirrus Logic CS4297A rev 4

RPMS related to alsa that are installed on my machine:

alsa-32bit-9.3-7
alsa-tools-1.0.9-0.pm.1
kalsatools-1.5.0-349
alsa-1.0.9-5.1
alsaplayer-0.99.76-72.1
alsa-firmware-1.0.9-0.pm.0
alsamodular-1.8.7-5
kalsatools-debuginfo-1.5.0-348
alsa-devel-1.0.9-5.1
alsamixergui-0.9.0rc1-544
alsa-tools-gui-1.0.9-0.pm.1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-01-05 16:35 anandrajan     New Issue                                    
06-01-05 16:35 anandrajan     Distribution              => SuSE 9.3 Pro x86-64
version
06-01-05 16:35 anandrajan     Kernel Version            => 2.6.11          
06-01-05 16:45 tiwai          Note Added: 0004859                          
06-02-05 15:26 anandrajan     Note Added: 0004877                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
