From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001091]: dmix hangs on 2nd-3rd snd_pcm_drop
Date: Fri, 6 May 2005 17:48:49 +0200
Message-ID: <3f7d497954caa3e97a2fa0360a9e5924@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3249520D
	for <alsa-devel@alsa-project.org>; Fri,  6 May 2005 17:48:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1091> 
======================================================================
Reported By:                ikonst
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1091
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-06-2005 17:48 CEST
Last Modified:              05-06-2005 17:48 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 17:48 ikonst         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
