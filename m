From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001074]: pcm_dmix hangs on device close
Date: Wed, 11 May 2005 17:23:44 +0200
Message-ID: <61b7f00642ce2111d906a89e5a862c49@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 89D5A208
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2005 17:23:44 +0200 (MEST)
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
Last Modified:              05-11-2005 17:23 CEST
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
 chtephan - 05-09-05 20:42 
----------------------------------------------------------------------
The problem is that if the timer fd is non-blocking, a read will not return
when there is no more data but block. Something like that patch helps.

----------------------------------------------------------------------
 ikonst - 05-11-05 17:23 
----------------------------------------------------------------------
The patch solves the problem for me. Also solves issue 1091 at the same
time. Pleae check it in and mark both bugs as resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 08:48 ikonst         New Issue                                    
05-09-05 17:33 chtephan       Note Added: 0004627                          
05-09-05 17:53 chtephan       Issue Monitored: chtephan                    
05-09-05 20:41 chtephan       File Added: timer-flush-blocking.diff             
      
05-09-05 20:42 chtephan       Note Added: 0004629                          
05-11-05 17:23 ikonst         Note Added: 0004638                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
