From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001074]: pcm_dmix hangs on device close
Date: Fri, 13 May 2005 22:57:03 +0200
Message-ID: <0fc5005bc8cad25b06626fbb3cd9057e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 018C72DE
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2005 22:57:03 +0200 (MEST)
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
Last Modified:              05-13-2005 22:57 CEST
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
 tiwai - 05-12-05 13:50 
----------------------------------------------------------------------
But the timer in dmix is supposed to be opened in non-blocking mode.
See snd_timer_open() in pcm_direct.c.

----------------------------------------------------------------------
 chtephan - 05-13-05 22:57 
----------------------------------------------------------------------
Ok, this is bad, really bad.

You are, of course, right.

The problem is a very bad ioctl mixup:

16035 open("/dev/snd/timer", O_RDONLY|O_NONBLOCK) = 19
[...]
16038 ioctl(19, FIONBIO, [0])        = 0 (!!!)
[...]
16038 read(19,  <unfinished ...>

I wrote an ioctl interceptor via LD_PRELOAD to find out that the
mysterious FIONBIO is actually:

src/timer/timer_hw.c: line 159 (snd_timer_hw_stop)

>       if (ioctl(tmr->poll_fd, SNDRV_TIMER_IOCTL_STOP) < 0)

The numeric value of SNDRV_TIMER_IOCTL_STOP

asound.h:       SNDRV_TIMER_IOCTL_STOP = _IO('T', 0x21),

_IO('T', 0x21) = _IOC(0, 0, 'T', 0x21) = ('T' << 8) + 0x21 = 0x5421

And guess what?

#define FIONBIO                0x5421

This is *very* bad.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 08:48 ikonst         New Issue                                    
05-09-05 17:33 chtephan       Note Added: 0004627                          
05-09-05 17:53 chtephan       Issue Monitored: chtephan                    
05-09-05 20:41 chtephan       File Added: timer-flush-blocking.diff             
      
05-09-05 20:42 chtephan       Note Added: 0004629                          
05-11-05 17:23 ikonst         Note Added: 0004638                          
05-11-05 18:11 tiwai          Note Added: 0004639                          
05-12-05 13:34 chtephan       Note Added: 0004641                          
05-12-05 13:50 tiwai          Note Added: 0004642                          
05-13-05 22:57 chtephan       Note Added: 0004656                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
