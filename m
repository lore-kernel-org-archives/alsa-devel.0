From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000727]: segmentation fault when running modprobe & alsaconf, no sound, no mixer on D915GAV
Date: Thu, 16 Dec 2004 09:09:04 +0100
Message-ID: <7793bbf2deaf3734ff50d8c104e36a51@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A780241
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 09:09:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=727> 
======================================================================
Reported By:                IMAMUDDIN AKBAR
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   727
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-16-2004 09:09 CET
Last Modified:              12-16-2004 09:09 CET
======================================================================
Summary:                    segmentation fault when running modprobe & alsaconf,
no sound, no mixer on D915GAV
Description: 

i have compiled alsa-driver-1.0.7 alsa-lib-1.0.7 alsa-utils-1.0.7
but thereis still no sound, and nomiser appear when running alsamixer

i use Intel D915GAV with lspci -v:
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 03)
        Subsystem: Intel Corp.: Unknown device e203
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at ffa3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

when i run 
# modprobe snd-azx
Segmentation fault
#lsmod
snd_azx                31094  6
snd_pcm_oss            51752  0
snd_mixer_oss          21760  1 snd_pcm_oss
snd_pcm                89860  2 snd_azx,snd_pcm_oss
snd_timer              27524  1 snd_pcm

when i run amixer
no mixer appear on screen

and when i reboot my computer it cannot boot and just hang...
so i have to uninstall all alsa from rescue to boot again.

Help me to make mysound work fine...
 




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-16-04 09:09 IMAMUDDIN AKBARNew Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
