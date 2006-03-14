From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001921]: Unsupported Sound Card
Date: Tue, 14 Mar 2006 14:57:46 +0100
Message-ID: <4514608af27d77cfe5a9bceaa6258677@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 920DC17C
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 14:57:46 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1921> 
======================================================================
Reported By:                sk0rp10
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1921
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Slackware current
Kernel Version:             2.6.15.6 vanilla
Resolution:                 duplicate
Duplicate:                  1890
Fixed in Version:           
======================================================================
Date Submitted:             03-14-2006 00:21 CET
Last Modified:              03-14-2006 14:57 CET
======================================================================
Summary:                    Unsupported Sound Card
Description: 
Sound Card equipped on VAIO VGN-FE11S is unsupported by intel-hda. Once the
module is loaded, alsamixer recognizes a Sigmatel ID 7661 chip, only one
mixer control is shown in Playback tab, named PCM. Module is loaded with
no error but no sound comes out from speakers. Here is lspci:

00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev
03)
00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics Port
(rev 03)
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial
ATA Storage Controllers cc=IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 01d8
(rev a1)
06:00.0 Network controller: Intel Corporation: Unknown device 4222 (rev
02)
0a:03.0 CardBus bridge: Texas Instruments: Unknown device 8039
0a:03.1 FireWire (IEEE 1394): Texas Instruments: Unknown device 803a
0a:03.2 Mass storage controller: Texas Instruments: Unknown device 803b
0a:08.0 Ethernet controller: Intel Corporation: Unknown device 1092 (rev
02)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001890 Only the PCM channel in alsa mixer, unm...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-06 00:21 sk0rp10        New Issue                                    
03-14-06 00:21 sk0rp10        File Added: 30701302.pdf                     
03-14-06 00:21 sk0rp10        Distribution              => Slackware current
03-14-06 00:21 sk0rp10        Kernel Version            => 2.6.15.6 vanilla
03-14-06 14:57 tiwai          Relationship added       duplicate of 0001890
03-14-06 14:57 tiwai          Duplicate ID             0 => 1890           
03-14-06 14:57 tiwai          Status                   assigned => resolved
03-14-06 14:57 tiwai          Resolution               open => duplicate   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
