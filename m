From: noreply@alsa-project.org
Subject: [ALSA - driver 0000373]: Sound in Quake 3 does not work
Date: Sun, 18 Jul 2004 19:13:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040718171325.61A8A28006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C138144
	for <alsa-devel@alsa-project.org>; Sun, 18 Jul 2004 19:13:25 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000373
======================================================================
Reported By:                damage
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     373
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse Linux 9.1
Kernel Version:             2.6.5-7.95-default
======================================================================
Date Submitted:             07-09-2004 21:37 CEST
Last Modified:              07-18-2004 19:13 CEST
======================================================================
Summary:                    Sound in Quake 3 does not work
Description: 
I already tried several things to get sound working in Quake 3. It doesn't 
work. Sound in other applications, such as xmms, works without problems.
My System: SUSE Linux 9.1 Pro 64bit, MSI K8T Neo FIS2R, Athlon 64 3200,
1GB 
RAM, VIA 8237 on board sound

I tried it with the ALSA version that comes with the Default Suse Kernel,
then 
with version 1.05a and at the moment I've installed a version from CVS two

days ago. I loaded the alsa module with dxs_support 0 to 4, that didn't 
resolve the issue.

Without changing anything in the ALSA configuration Quake 3 starts and the

game runs without problems, but there is no sound. The following error 
message is displayed when Quake 3 starts.
------- sound initialization -------
Could not mmap dma buffer PROT_WRITE|PROT_READ
trying mmap PROT_WRITE (with associated better compatibility / less 
performance code)
/dev/dsp: Input/output error
Could not mmap /dev/dsp
------------------------------------

Enabling direct access to the OSS playback device and disabling the OSS 
capture device with 
echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
echo "quake3.x86 0 0 disable" > /proc/asound/card0/pcm0c/oss
I get sound in the Quake 3 menu, but as soon as I enter a map the game
hangs 
and the only way to get back to X is to kill the process.

I also tried the user space ALSA OSS wrapper library. With this library I
only 
get some crackling noises in the menu and in the game.

With xrun_debug 1 I get a few of the following messages (at least with the

actually installed drivers from CVS) in the system log. These messages are

also there when I run other applications than Quake 3.
Jul  8 19:07:48 mordor kernel: ALSA sound/core/pcm_lib.c:199: Unexpected 
hw_pointer value [1] (stream = 0, delta: -1024, max jitter = 8192): wrong 
interrupt acknowledge?
Jul  8 19:07:48 mordor kernel: ALSA sound/pci/via82xx.c:731: invalid 
via82xx_cur_ptr, using last valid pointer
Jul  8 19:08:00 mordor last message repeated 194 times

I don't know whether that has something to do with the problem.

======================================================================

----------------------------------------------------------------------
 damage - 07-09-2004 21:46 CEST 
----------------------------------------------------------------------
I did some minor corrections to the uploaded file and uploaded it a second
time, as the comments were wrong.

This bug seems to be related to the following bugs which are filed for
other sound cards:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000254
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000015

----------------------------------------------------------------------
 tokugawa - 07-11-2004 00:04 CEST 
----------------------------------------------------------------------
"I get sound in the Quake 3 menu, but as soon as I enter a map the game
hangs
and the only way to get back to X is to kill the process."

Hi, the same here...  i'm going on vacation right now, so i can't help
much... but:

1) open the pk3 (like baseq3/pak0.pk3) files (these are zip)
2) move from them music dir to some other (so q3 will not found them)
3) run q3
4) tada!! qukae3 works, music hangs the game, without it game works
5) But there are no 'turn off music' in quake3 (music volume option don't
work... hangs are happen even if you turn down music completly in
options), so I just deleted music dirs from my pk3's. (just run zip -vd
pak0.pk3 'music/*' )

Heh... but you can't play online, because you have a hacked pk3 files...,
so we have to wait for a real fix

I'm hope that will help in bug hunting. If you can, please confirm that
behaviour.

----------------------------------------------------------------------
 damage - 07-11-2004 02:35 CEST 
----------------------------------------------------------------------
I can absolutely confirm all of what tokugawa said. Deleting the music
files makes the game work with sound. Of course then there is no music in
the game and you can't play online anymore. The latter makes the game
kinda boring ;) .

----------------------------------------------------------------------
 damage - 07-18-2004 19:13 CEST 
----------------------------------------------------------------------
Does anybody have a tip on how to debug this? I tried several things, like
getting an strace, and running it in gdb, but neither was really helpful
at locating the reason for the freeze (at least for me). The strace looks
nearly identical when running with and without music. gdb doesn't tell me
much as I get either a _really_ big list when I want a backtrace after
interrupting the frozen game, or there is nothing at all in the backtrace.
Seems to depend on the time I interrupt the process.
Perhaps a debugging statement somewhere in the ALSA source could help?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-09-04 21:37 damage         New Bug                                      
07-09-04 21:37 damage         File Added: alsa_q3_debug.txt                    
07-09-04 21:37 damage         Distribution              => Suse Linux 9.1  
07-09-04 21:37 damage         Kernel Version            => 2.6.5-7.95-default
07-09-04 21:41 damage         File Added: alsa_q3_debug.txt                    
07-09-04 21:46 damage         Bugnote Added: 0001396                       
07-09-04 21:50 damage         Bug Monitored: damage                        
07-11-04 00:04 tokugawa       Bugnote Added: 0001406                       
07-11-04 02:35 damage         Bugnote Added: 0001407                       
07-18-04 19:13 damage         Bugnote Added: 0001459                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
