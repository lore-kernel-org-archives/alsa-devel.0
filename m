From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000917]: intel8x0 ACPI suspend/resume trouble
Date: Thu, 17 Feb 2005 22:38:48 +0100
Message-ID: <d3023e2b6f6b612572e7ef257b89a049@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E77CA26C
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 22:38:48 +0100 (MET)
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
Last Modified:              02-17-2005 22:38 CET
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
 christophe - 02-17-05 21:06 
----------------------------------------------------------------------
Looking at intel8x0.c,
it seems that I should use the option with the value hp_only against the
snd-intel8x0 module.

I will try and report the result,
Thanks.

----------------------------------------------------------------------
 christophe - 02-17-05 22:38 
----------------------------------------------------------------------
With the ac97_quirk, it seems like I have no more sound at all.

Right now the sounds is good quality, I will try to remove/insert the
module next time I get a crapy sound.

Two remarks concerning my earlier observation that the second side was
back after lowering the pcm volume:
1. It doesn't work all the time.
2. When everything is fine, I can have both the master and the pcm volume
at the max value. When I was getting the right side back eralier, when
moving the pcm volume up, I was loosing the right side again. 

Otherwise, I noticed that the "Jack Sense" track in the mixer does not
seem to work, and the headphone volume is ignored. Is it the normal
behavior?

Thanks,
Christophe

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
