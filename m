From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001091]: dmix hangs on 2nd-3rd snd_pcm_drop
Date: Tue, 24 May 2005 12:31:02 +0200
Message-ID: <6bcba9d41c60654d7850b448db7fe414@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BDA601DF
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 12:31:02 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1091> 
======================================================================
Reported By:                ikonst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1091
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-06-2005 17:48 CEST
Last Modified:              05-24-2005 12:31 CEST
======================================================================
Summary:                    dmix hangs on 2nd-3rd snd_pcm_drop
Description: 
Rhythmbox performs a "drop" upon pressing Pause. When playing thru a dmix
device, toggling pause-play a couple of time (one or two is enough) will
cause alsa-lib to hang. Here's the relevant stack trace:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x40be8741 in
__read_nocancel () from /lib/tls/libpthread.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x444790a8 in
snd_timer_hw_read (handle=0xbfffdcc8,
buffer=0xfffffe00,
    size=8) at timer_hw.c:184
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x44478a7a in
snd_timer_read (timer=0x8, buffer=0xbfffdcc8, size=8)
    at timer.c:879
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x44465cbd in
snd_pcm_direct_clear_timer_queue (dmix=0x8883020)
    at pcm_direct.c:429
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x44465cfd in
snd_pcm_direct_timer_stop (dmix=0x8883020)
    at pcm_direct.c:437
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x44468744 in
snd_pcm_dmix_drop (pcm=0xfffffe00) at pcm_dmix.c:475
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x4442fb24 in
snd_pcm_drop (pcm=0xfffffe00) at pcm.c:1021
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0x443cf985 in
gst_alsa_hw_params_dump ()
   from /usr/lib/gstreamer-0.8/libgstalsa.so
...

======================================================================

----------------------------------------------------------------------
 tiwai - 05-24-05 12:31 
----------------------------------------------------------------------
Fixed on 1.0.9rc4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 17:48 ikonst         New Issue                                    
05-24-05 12:31 tiwai          Status                   new => resolved     
05-24-05 12:31 tiwai          Resolution               open => fixed       
05-24-05 12:31 tiwai          Assigned To               => tiwai           
05-24-05 12:31 tiwai          Note Added: 0004720                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
