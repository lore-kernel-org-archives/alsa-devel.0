From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000282]: ES1688 driver assumes inappropriate port for OPL3; no way to change
Date: Fri, 30 Dec 2005 05:24:22 +0100
Message-ID: <f225c02b7beb20cd32585b7f7749960a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16B0218F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:24:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=282> 
======================================================================
Reported By:                jessleah
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   282
Category:                   ISA - es1688
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux 3.0 (Woody) for i386
Kernel Version:             2.4.25
======================================================================
Date Submitted:             05-19-2004 05:22 CEST
Last Modified:              12-30-2005 05:24 CET
======================================================================
Summary:                    ES1688 driver assumes inappropriate port for OPL3;
no way to change
Description: 
On a ThinkPad 560 (which uses an ES1688 chip), the OPL3 should use the port
range 0x388-0x38b. However, ALSA 1.0.4 for some reason assumes that the
port you specify for the ES1688 (i.e. 0x220, in my case) is the base port
of the OPL3 chip, which is just plain wrong.

I go:
modprobe snd-es1688-lib
modprobe snd-mpu401-uart
modprobe snd-opl3-lib
modprobe snd-es1688 port=0x220 irq=7 dma8=1 mpu_port=0x330 mpu_irq=9

And when I cat /proc/ioports | grep -i opl, I get:

0220-0221 : OPL2/3 (left)
0222-0223 : OPL2/3 (right)

Needless to say, MIDI doesn't work!

The OSS/Free driver works fine with my OPL3, and the same command (cat
/proc/ioports | grep -i opl) yields:

0388-038b : Yamaha OPL3

MIDI works fine with the OSS/Free driver.

Heeeeeeeeeeeeeeeeeeeeeeeeelp...
======================================================================

----------------------------------------------------------------------
 jdthood - 04-04-05 22:23 
----------------------------------------------------------------------
It isn't apparent to me that anything has been done about this.

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:24 
----------------------------------------------------------------------
Has there been any improvement in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-04 05:22 jessleah       New Issue                                    
05-19-04 05:22 jessleah       Distribution              => Debian GNU/Linux 3.0
(Woody) for i386
05-19-04 05:22 jessleah       Kernel Version            => 2.4.25          
05-19-04 14:20 jessleah       Issue Monitored: jessleah                    
04-04-05 22:23 jdthood        Note Added: 0004331                          
12-30-05 05:24 rlrevell       Note Added: 0007244                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
