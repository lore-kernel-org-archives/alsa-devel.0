From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001714]: Intel HDA (AD1986A) no sound
Date: Sat, 25 Mar 2006 15:31:04 +0100
Message-ID: <37721c54b7d6b84440c67af0bed8f3e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D04DF1CC
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 15:31:04 +0100 (MET)
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
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1714
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               LFS
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-04-2006 18:04 CET
Last Modified:              03-25-2006 15:31 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001841 Mixer not working  / fujitsu laptop V20...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-23-06 17:45 
----------------------------------------------------------------------
Could you try 1.0.11rc4?

----------------------------------------------------------------------
 kratz00 - 03-25-06 15:31 
----------------------------------------------------------------------
i did, still the same :(

i will attach asound.state

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 18:04 kratz00        New Issue                                    
01-04-06 18:04 kratz00        Distribution              => LFS             
01-04-06 18:04 kratz00        Kernel Version            => 2.6.15          
01-30-06 13:40 kratz00        Note Added: 0007837                          
02-07-06 00:48 gerick         Issue Monitored: gerick                      
02-08-06 13:13 simonckenyon   Issue Monitored: simonckenyon                    
03-10-06 18:26 tiwai          Relationship added       duplicate of 0001841
03-10-06 18:26 tiwai          Duplicate ID             0 => 1841           
03-10-06 18:26 tiwai          Status                   new => resolved     
03-10-06 18:26 tiwai          Resolution               open => duplicate   
03-10-06 18:26 tiwai          Assigned To               => tiwai           
03-10-06 18:26 tiwai          Note Added: 0008408                          
03-15-06 21:49 kratz00        Status                   resolved => feedback
03-15-06 21:49 kratz00        Resolution               duplicate => reopened
03-15-06 21:49 kratz00        Note Added: 0008574                          
03-23-06 17:45 tiwai          Note Added: 0008896                          
03-25-06 15:31 kratz00        Note Added: 0008948                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
