From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000917]: intel8x0 ACPI suspend/resume trouble
Date: Mon, 21 Feb 2005 19:16:07 +0100
Message-ID: <97d37f72a8608bce3a68a5f7d4df20b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C7AD0CB
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 19:16:07 +0100 (MET)
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
Last Modified:              02-21-2005 19:16 CET
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
 christophe - 02-19-05 22:16 
----------------------------------------------------------------------
I should have precised that what I did to power it off is:

alsactl power off

----------------------------------------------------------------------
 christophe - 02-21-05 19:16 
----------------------------------------------------------------------
I saved all proc files before and after a suspend/resume cycle and look at
the diff:

In /proc/asound/card0/intel8x0 
I have the following diff:
before: Global control        : 0xc0000002
after:  Global control        : 0x00000002

/proc/asound/card0/pcm0p/sub0/[status,sw_params,hw_params] contains
"closed" after while they have more content before but I suspect it's
normal.
And the file /proc/asound/card0/pcm0p/sub0/info contains the same in both
case except the value of subdevices_avail which is 0 before and 1 before.

Finally I have the following change in the registers:

before:
0:10 = 8989
0:12 = 9f9f
0:14 = 0000
0:16 = 9f9f
0:18 = 1010
0:1a = 0000
0:1c = 8080
...
0:76 = 2010

after:
0:10 = 8909
0:12 = 9f1f
0:14 = 0000
0:16 = 9f1f
0:18 = 1010
0:1a = 0000
0:1c = 8000
...
0:76 = 0010

I will try to figure out the meaning of the global control and the
registers. The sound output was perfect before and crappy after (symmetric
for once, but the more I increase the pcm volume the crappier it becomes
until a certain point where I get only sound from the left channel).

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
