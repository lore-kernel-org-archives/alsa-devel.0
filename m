From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001714]: Intel HDA (AD1986A) no sound
Date: Mon, 30 Jan 2006 13:40:51 +0100
Message-ID: <0952a3396be9c4d58d71e468a6ebb73e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8418C1C8
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2006 13:40:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1714> 
======================================================================
Reported By:                kratz00
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1714
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               LFS
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-04-2006 18:04 CET
Last Modified:              01-30-2006 13:40 CET
======================================================================
Summary:                    Intel HDA (AD1986A) no sound
Description: 
It's a Samsung M50 Notebook.
I also tried Alsa 1.0.10 but the problem is the same.
There are no specific module options for the AD1986A chip, right?

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
        Subsystem: Samsung Electronics Co Ltd Unknown device c01e
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

loaded modules:
snd_pcm_oss            47136  0 
snd_mixer_oss          16512  1 snd_pcm_oss
snd_hda_intel          14224  0 
snd_hda_codec         122624  1 snd_hda_intel
snd_pcm                75912  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              19844  1 snd_pcm
snd                    46144  6
snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          8328  2 snd_hda_intel,snd_pcm

======================================================================

----------------------------------------------------------------------
 kratz00 - 01-30-06 13:40 
----------------------------------------------------------------------
tried alsa-driver-1.0.11rc3 and still no luck :/

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 18:04 kratz00        New Issue                                    
01-04-06 18:04 kratz00        Distribution              => LFS             
01-04-06 18:04 kratz00        Kernel Version            => 2.6.15          
01-30-06 13:40 kratz00        Note Added: 0007837                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
