From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001741]: just one mixer element
Date: Thu, 12 Jan 2006 11:56:38 +0100
Message-ID: <986ee349fd6f34f2fa4259ea52e30e33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0451E13C
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 11:56:38 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1741> 
======================================================================
Reported By:                julien_brule
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1741
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-12-2006 11:56 CET
Last Modified:              01-12-2006 11:56 CET
======================================================================
Summary:                    just one mixer element
Description: 
hello,

everything is installed, alsamixer show just the pcm slider which one is
unmuted and at 74 but still sound with xmms  alsa output.

lspci -vn:

0000:00:1b.0 0403: 8086:27d8 (rev 01)
        Subsystem: 1028:01a8
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]


lspci -v :

0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)
        Subsystem: Dell: Unknown device 01a8
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]


uname -ar:
Linux pcspajb 2.6.12-1-em64t-p4 #1 Wed Sep 28 03:24:19 CEST 2005 x86_64
GNU/Linux

distrib : Debian/etch


aplay some.mp3:
ALSA lib timer_hw.c:269:(snd_timer_hw_open) extended read is not supported
(SNDRV_TIMER_IOCTL_TREAD)
Playing raw data 'mp3/steve_coleman/world
expansion/perpetuate_the_funk.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono
Aborted by signal Interruption...

dpkg-query -l alsa:
alsa-base        1.0.10-3

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-06 11:56 julien_brule   New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
