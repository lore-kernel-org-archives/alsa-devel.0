From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001074]: pcm_dmix hangs on device close
Date: Mon, 9 May 2005 20:42:16 +0200
Message-ID: <07f6de78c284e410230cc1b4bc41ff4f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CC1992EF
	for <alsa-devel@alsa-project.org>; Mon,  9 May 2005 20:42:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1074> 
======================================================================
Reported By:                ikonst
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1074
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-24-2005 08:48 CEST
Last Modified:              05-09-2005 20:42 CEST
======================================================================
Summary:                    pcm_dmix hangs on device close
Description: 
The fix in pcm_dmix.c revision 1.71 causes the following regression:

Everytime I access a Flash site thru my 'aoss'-wrapped Mozilla, it hangs:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x40a951c3 in poll ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x4001a1fd in poll ()
from /usr/lib/libaoss.so
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x40c7bf78 in
snd_pcm_wait_nocheck (pcm=0x9a7a6a0, timeout=-1)
    at pcm.c:2234
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x40cb27fb in
snd_pcm_dmix_drain (pcm=0x9a7a6a0) at pcm_dmix.c:504
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x40c79bd4 in
snd_pcm_drain (pcm=0xfffffffc) at pcm.c:1044
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x40c8cbb7 in
snd_pcm_generic_drain (pcm=0xfffffffc) at
pcm_generic.c:151
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x40c79bd4 in
snd_pcm_drain (pcm=0xfffffffc) at pcm.c:1044
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0x40bb24e7 in
lib_oss_pcm_close () from /usr/lib/libalsatoss.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8  0x400199b4 in close ()
from /usr/lib/libaoss.so
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9  0x441712b9 in
PlatformSoundMix::UnlockAudioCallback ()
   from /usr/lib/flashplugin-nonfree/libflashplayer.so
...

======================================================================

----------------------------------------------------------------------
 chtephan - 05-09-05 17:33 
----------------------------------------------------------------------
I can confirm this. Seeing exactly the same with beep-media-player and dmix
here.

Seems this was introduced with 1.0.9-rc3, but worked with 1.0.9-rc2.

Here's a duplicate:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1091

(TASK_INTERRUPTIBLE in schedule())
May  9 17:30:24 leto [<d1bbefd4>] snd_timer_user_read+0xb4/0x230
[snd_timer]
May  9 17:30:24 leto [<c0161d25>] vfs_read+0x95/0x160
May  9 17:30:24 leto [<c016207d>] sys_read+0x3d/0x70
May  9 17:30:24 leto [<c01030ab>] sysenter_past_esp+0x54/0x75

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0xffffe410 in
__kernel_vsyscall ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x4124161b in
__read_nocancel () from /lib/libpthread.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x41d7f071 in
snd_timer_hw_read () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x41d7e9c9 in
snd_timer_read () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x41d6b30a in
snd_pcm_direct_clear_timer_queue () from
/usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x41d6b34d in
snd_pcm_direct_timer_stop () from
/usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x41d6d444 in
snd_pcm_dmix_drop () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0x41d333f2 in
snd_pcm_drop () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8  0xb76b0eeb in
alsa_pause () from /usr/lib/bmp/Output/libALSA.so

Linux 2.6.12-rc3-mm3

----------------------------------------------------------------------
 chtephan - 05-09-05 20:42 
----------------------------------------------------------------------
The problem is that if the timer fd is non-blocking, a read will not return
when there is no more data but block. Something like that patch helps.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 08:48 ikonst         New Issue                                    
05-09-05 17:33 chtephan       Note Added: 0004627                          
05-09-05 17:53 chtephan       Issue Monitored: chtephan                    
05-09-05 20:41 chtephan       File Added: timer-flush-blocking.diff             
      
05-09-05 20:42 chtephan       Note Added: 0004629                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
