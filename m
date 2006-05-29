From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000917]: intel8x0 ACPI suspend/resume
	trouble
Date: Mon, 29 May 2006 11:23:11 +0200
Message-ID: <129ed2eb297da704283055e4da54e067@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7AE3516B
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 11:23:11 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Status:                     feedback
Distribution:               Ununtu
Kernel Version:             2.6.11-rc3
======================================================================
Date Submitted:             02-17-2005 20:16 CET
Last Modified:              05-29-2006 11:23 CEST
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
 danone - 03-17-06 10:52 
----------------------------------------------------------------------
I have a similar problem on my HP Compaq nx8220. After resuming from s3
sound seems to work with headphones but the inbuild speakers stay mute.
Tried several things: 
rmmod/modprobe soundmodules => doesn't help
alsactl power off => wrecks resume
playback while suspending => wrecks suspend
diff content of /proc/asound before/after => no difference
Could it be related to this problem?

----------------------------------------------------------------------
 iMil - 05-29-06 11:23 
----------------------------------------------------------------------
same problem here with a nx8220 laptop, kernel 2.6.16, FC5.

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
06-29-05 20:05 tiwai          File Added: ich-resume-fix.diff                   

06-29-05 20:28 christophe     Note Added: 0005313                          
06-29-05 23:17 christophe     Note Added: 0005320                          
12-30-05 22:09 rlrevell       Note Added: 0007268                          
03-01-06 00:59 rlrevell       Status                   new => closed       
03-02-06 13:00 christophe     Status                   closed => feedback  
03-02-06 13:00 christophe     Resolution               open => reopened    
03-02-06 13:00 christophe     Note Added: 0008302                          
03-17-06 10:52 danone         Note Added: 0008635                          
03-17-06 10:52 danone         Issue Monitored: danone                      
05-29-06 11:23 iMil           Note Added: 0010009                          
======================================================================
