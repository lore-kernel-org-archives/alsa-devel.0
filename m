From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Fri, 5 Aug 2005 05:25:43 +0200
Message-ID: <32667427b33c643c6235be56d65d78db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0C4914E
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 05:25:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1310> 
======================================================================
Reported By:                oxi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1310
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge AMD64
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             08-04-2005 22:50 CEST
Last Modified:              08-05-2005 05:25 CEST
======================================================================
Summary:                    Driver cant find firmware for Layla24
Description: 
Hello,

After modprobe snd-layla24 ,
in dmesg|tail:

ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALSA /usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla24: probe of 0000:00:0e.0 failed with error -2

Same issue that another guy is experiencing with a Layla20:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1244
======================================================================

----------------------------------------------------------------------
 oxi - 08-05-05 05:20 
----------------------------------------------------------------------
Well i did some research and yes, i just installed it. But the problem is
still there!

debian:/usr/src/alsa-firmware-1.0.9# ./configure;make;make install
debian:/usr/src/alsa-firmware-1.0.9# /etc/init.d/alsasound stop
Shutting down sound driver: /usr/sbin/alsactl: save_state:1163: No
soundcards found...
done
debian:/usr/src/alsa-firmware-1.0.9# modprobe snd-layla24
debian:/usr/src/alsa-firmware-1.0.9# dmesg|tail
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALSA /usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla24: probe of 0000:00:0e.0 failed with error -2

*Its not the same previous message, as i have checked it.

----------------------------------------------------------------------
 oxi - 08-05-05 05:25 
----------------------------------------------------------------------
debian:/usr/lib/hotplug/firmware/ea# ls -l
total 776
-rw-r--r--  1 root root 78761 2005-08-05 05:16 3g_asic.fw
-rw-r--r--  1 root root 17162 2005-08-05 05:16 darla20_dsp.fw
-rw-r--r--  1 root root 15022 2005-08-05 05:16 darla24_dsp.fw
-rw-r--r--  1 root root 32058 2005-08-05 05:16 echo3g_dsp.fw
-rw-r--r--  1 root root 19022 2005-08-05 05:16 gina20_dsp.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 gina24_301_asic.fw
-rw-r--r--  1 root root 22342 2005-08-05 05:16 gina24_301_dsp.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 gina24_361_asic.fw
-rw-r--r--  1 root root 22450 2005-08-05 05:16 gina24_361_dsp.fw
-rw-r--r--  1 root root 27682 2005-08-05 05:16 gina3g_dsp.fw
-rw-r--r--  1 root root 16082 2005-08-05 05:16 indigo_dj_dsp.fw
-rw-r--r--  1 root root 15354 2005-08-05 05:16 indigo_dsp.fw
-rw-r--r--  1 root root 16658 2005-08-05 05:16 indigo_io_dsp.fw
-rw-r--r--  1 root root 32385 2005-08-05 05:16 layla20_asic.fw
-rw-r--r--  1 root root 24710 2005-08-05 05:16 layla20_dsp.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 layla24_1_asic.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 layla24_2A_asic.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 layla24_2S_asic.fw
-rw-r--r--  1 root root 27930 2005-08-05 05:16 layla24_dsp.fw
-rw-r--r--  1 root root   634 2005-08-05 05:16 loader_dsp.fw
-rw-r--r--  1 root root 20346 2005-08-05 05:16 mia_dsp.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 mona_2_asic.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 mona_301_1_asic_48.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 mona_301_1_asic_96.fw
-rw-r--r--  1 root root 24130 2005-08-05 05:16 mona_301_dsp.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 mona_361_1_asic_48.fw
-rw-r--r--  1 root root 31146 2005-08-05 05:16 mona_361_1_asic_96.fw
-rw-r--r--  1 root root 24258 2005-08-05 05:16 mona_361_dsp.fw

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-05 22:50 oxi            New Issue                                    
08-04-05 22:50 oxi            Distribution              => Debian Sarge AMD64
08-04-05 22:50 oxi            Kernel Version            => 2.6.12.3        
08-04-05 23:48 rlrevell       Note Added: 0005653                          
08-05-05 04:57 oxi            Note Added: 0005656                          
08-05-05 04:59 oxi            Issue Monitored: oxi                         
08-05-05 05:00 rlrevell       Note Added: 0005657                          
08-05-05 05:20 oxi            Note Added: 0005658                          
08-05-05 05:25 oxi            Note Added: 0005659                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
