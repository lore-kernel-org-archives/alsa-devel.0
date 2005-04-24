From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001074]: pcm_dmix hangs on device close
Date: Sun, 24 Apr 2005 08:48:36 +0200
Message-ID: <e83f0844529150c0260833f5c3c78d5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 58B4E23F
	for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2005 08:48:36 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              04-24-2005 08:48 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 08:48 ikonst         New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
