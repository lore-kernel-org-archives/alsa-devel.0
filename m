From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001047]: module hangs at seemingly random times
Date: Wed, 18 Jan 2006 15:51:34 +0100
Message-ID: <1b3edd7f2594c02aaac336bbc9870e92@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D70FA16A
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 15:51:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047> 
======================================================================
Reported By:                alien999999999
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1047
Category:                   PCI - au88x0
Reproducibility:            sometimes
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.6.7
======================================================================
Date Submitted:             04-12-2005 20:43 CEST
Last Modified:              01-18-2006 15:51 CET
======================================================================
Summary:                    module hangs at seemingly random times
Description: 
sometimes i start playing a song, and it starts playing a few second or so
and hangs, then i kill the application and modprobe -r all sound modules
and modprobe them again to make it work again.

BUT: sometimes not only that happens, but also when i try to kill the apps
it will not kill. when that happens, all kill, killall, top, ps aux
commands hang at the command line and cannot be killed by CTRL-C or
otherwise, i have been able to see that when i stopped my display
managener I did an lsmod and it gave something like this:

snd-pcm-oss            59752  11
snd-mixer-oss          20480  1 snd-pcm-oss
snd-au8810             43760  220
snd-ac97-codec         83408  1 snd-au8810
snd-pcm               108172  112 snd-pcm-oss,snd-au8810,snd-ac97-codec
snd-page-alloc         10384  1 snd-pcm
gameport                3840  1 snd-au8810
snd-mpu401-uart        11904  1 snd-au8810


as you can see the snd-au8810 module seem to have an impossible number of
"dependencies" (i think has to do with the number of unclosed sound-apps
trying to be played; this could be since gaim is programmed to execute an
'aplay %s')

i've had this major crash below only 3 times; and the logs didn't detect
anything specific at the time. the only thing the logs mentioned at that
time was an ntpd sync going on; so the only thing i can think of is that
at a certain moment when a sync is going on, some kind of lock is holding
cause this to happen... the only thing that i can do to fix this is
reset...

it is interesting to note that i also have an snd-emu10k1 as second card,
which never gave problems like this, and i am always able to "modprobe -r
snd-emu10k1" ...
======================================================================

----------------------------------------------------------------------
 Raymond - 01-17-06 12:27 
----------------------------------------------------------------------
The function vortex_EqHw_SetLevels() only set 20 eq peaks and 4 other
registers, so eq_levels[] need 24 values instead of 64 values.


Index: alsa-driver/alsa-kernel/pci/au88x0/au88x0_eqdata.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_eqdata.c,v
retrieving revision 1.2
diff -u -r1.2 au88x0_eqdata.c
--- alsa-driver/alsa-kernel/pci/au88x0/au88x0_eqdata.c	13 Jan 2006
17:16:29 -0000	1.2
+++ alsa-driver/alsa-kernel/pci/au88x0/au88x0_eqdata.c	17 Jan 2006
09:55:43 -0000
@@ -104,12 +104,7 @@
 };
 
 /*_rodataba0:*/
-static u16 eq_levels[64] = {
-	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+static u16 eq_levels[24] = {
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000

----------------------------------------------------------------------
 Raymond - 01-18-06 15:51 
----------------------------------------------------------------------
- fix the init of codec interface of au8810 and au8830
- enable the rear pcm slots when codec is quad

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-05 20:43 alien999999999 New Issue                                    
04-12-05 20:43 alien999999999 Distribution              => Mandrake        
04-12-05 20:43 alien999999999 Kernel Version            => 2.6.7           
04-12-05 20:48 alien999999999 Note Added: 0004461                          
04-12-05 20:49 alien999999999 File Added: au88x0.c                         
04-12-05 20:49 alien999999999 File Added: au88x0.h                         
04-12-05 20:50 alien999999999 File Added: au88x0_core.c                    
04-12-05 20:50 alien999999999 File Added: au88x0_mixer.c                    
04-12-05 20:51 alien999999999 Note Added: 0004462                          
08-24-05 11:13 Raymond        Note Added: 0005928                          
10-27-05 02:27 Raymond        Note Added: 0006564                          
01-03-06 04:04 Raymond        Note Added: 0007397                          
01-04-06 22:08 alien999999999 Note Added: 0007455                          
01-05-06 07:21 Raymond        Note Added: 0007462                          
01-05-06 20:32 shurick        Issue Monitored: shurick                     
01-06-06 17:17 alien999999999 Note Added: 0007488                          
01-06-06 17:33 alien999999999 File Added: alsa-cvs-2006-01-04.patch             
      
01-13-06 13:51 Raymond        Note Added: 0007639                          
01-13-06 18:18 tiwai          Note Added: 0007648                          
01-14-06 04:53 Raymond        Note Added: 0007653                          
01-14-06 05:00 Raymond        Note Edited: 0007653                         
01-17-06 12:27 Raymond        Note Added: 0007697                          
01-18-06 15:51 Raymond        Note Added: 0007710                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
