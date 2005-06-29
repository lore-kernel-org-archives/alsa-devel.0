From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000917]: intel8x0 ACPI suspend/resume trouble
Date: Wed, 29 Jun 2005 20:05:15 +0200
Message-ID: <04457c6966369a7e1ee619adb403a3c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA4711D3
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 20:05:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=917> 
======================================================================
Reported By:                christophe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   917
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ununtu
Kernel Version:             2.6.11-rc3
======================================================================
Date Submitted:             02-17-2005 20:16 CET
Last Modified:              06-29-2005 20:05 CEST
======================================================================
Summary:                    intel8x0 ACPI suspend/resume trouble
Description: 
I have a problem with the driver for my soundcard after
ACPI suspend/resume cycles with a 2.6.11-rc3 kernel. (I add the same
problem with prior kernels, I first tried with 2.6.8).

This is a IBM x40 laptop (23865FU) with an intel chipset.

The relevant lspci line is:
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97
Audio Controller (rev
+01)

The driver I use is snd_intel8x0.

The problem is that after a suspend/resume cycle the sound
output is either off or only on one side or with statics.

I tried to do:

~$ alsactl power off
~$ alsactl power on

without any change.

If I suspend/resume multiple time I can get the sound output
a little better (like on one side instead of off). But so far
to get the correct sound back I need to reboot.

Is it a known problem?
Is there a way to force the driver to reinitialized the chipset?

Thanks for alsa,
Christophe

======================================================================

----------------------------------------------------------------------
 christophe - 06-29-05 16:04 
----------------------------------------------------------------------
I just tested with 1.0.9b and got the same result.
The diff of everything in /proc/asound/card0/ gives me the exact same
differences: the c in the control words and the same register changes.

----------------------------------------------------------------------
 tiwai - 06-29-05 20:05 
----------------------------------------------------------------------
Does the attached patch fix something?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-05 20:16 christophe     New Issue                                    
02-17-05 20:16 christophe     Distribution              => Ununtu          
02-17-05 20:16 christophe     Kernel Version            => 2.6.11-rc3      
02-17-05 20:30 tiwai          Note Added: 0003636                          
02-17-05 21:01 christophe     Note Added: 0003639                          
02-17-05 21:06 christophe     Note Added: 0003640                          
02-17-05 22:38 christophe     Note Added: 0003643                          
02-18-05 09:29 alexs81        Issue Monitored: alexs81                     
02-18-05 09:41 alexs81        Note Added: 0003649                          
02-18-05 18:00 christophe     Note Added: 0003657                          
02-18-05 20:34 alexs81        File Added: output_proc_asound_card0_codec97_0    
               
02-18-05 20:35 alexs81        Note Added: 0003659                          
02-18-05 20:50 christophe     Note Added: 0003660                          
02-18-05 21:13 alexs81        Note Added: 0003661                          
02-18-05 21:16 christophe     Note Added: 0003662                          
02-18-05 21:32 alexs81        Note Added: 0003663                          
02-18-05 21:39 rlrevell       Note Added: 0003664                          
02-19-05 02:40 christophe     Note Added: 0003668                          
02-19-05 12:07 alexs81        Note Added: 0003669                          
02-19-05 22:15 christophe     Note Added: 0003671                          
02-19-05 22:16 christophe     Note Added: 0003672                          
02-21-05 19:16 christophe     Note Added: 0003681                          
02-21-05 19:21 christophe     Note Added: 0003682                          
06-28-05 16:49 christophe     Note Added: 0005298                          
06-29-05 16:04 christophe     Note Added: 0005306                          
06-29-05 20:05 tiwai          Note Added: 0005308                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
