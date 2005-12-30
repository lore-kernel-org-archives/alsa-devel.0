From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001186]: SIS7012: the speakers can sound, but not the headphones.
Date: Fri, 30 Dec 2005 22:15:26 +0100
Message-ID: <354f247d698533c6a779b8699d47ca42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E1CF194
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 22:15:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1186> 
======================================================================
Reported By:                shiyutang
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1186
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandriva Linux 2005
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-12-2005 11:30 CEST
Last Modified:              12-30-2005 22:15 CET
======================================================================
Summary:                    SIS7012: the speakers can sound, but not the
headphones.
Description: 
The model of my laptop PC is Acer TravelMate 273xv. I install Mandriva
Linux 2005 in it and find a strange problem, that is I can have sound from
the speakers, but not the headphones.

The machine I bought has the following specs:
Processor	1.7Ghz Pentium 4 (Mobile)
RAM	256 MB DDR
HDD	30GB
CD	DVD
Motherboard chipset: SIS 650
FDD	Built in
USB	3 Ports, USB 1.1
Firewire IEEE 1394 small 4 pin socket
PCMCIA	Two sockets
Modem	SoftModem, Lucent
LAN	Built in 10/100, RTL8139 compatible
Video	built-in GPU, 1024x768, Monitor out, S-Video Out
Legacy	Both serial and Parallel ports
Mouse	Touchpad. I have added a Logitech mouse
Supplied OS	Windows XP

A strange status may help you:
If you are using Windows XP, and using SIS 7012 driver downloaded from
SIS, you will meet the same problem as ALSA, speakers sound but headphones
not sound. But if you are using Realtek ALC 650 driver downloaded from
Realtek(http://152.104.125.9/pc/ac97/alc650/wdm_a373.exe), both speakers
and headphones will sound. So I think this model of Acer laptop doesn't
use the common SIS 7012.

Not only I meet the problem, another Debian user also meet it and post it
on linux-laptop.net, see
http://www.martinjones.net/acerlinux/linuxsound.html
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 22:15 
----------------------------------------------------------------------
Any improvement in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-05 11:30 shiyutang      New Issue                                    
06-12-05 11:30 shiyutang      Distribution              => Mandriva Linux 2005
06-12-05 11:30 shiyutang      Kernel Version            => 2.6.11          
06-13-05 14:55 dale           Issue Monitored: dale                        
12-30-05 22:15 rlrevell       Note Added: 0007271                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
