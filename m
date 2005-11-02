From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001524]: Heavy use of ALSA brings down all applications using libasound (major crash)
Date: Wed, 2 Nov 2005 13:10:31 +0100
Message-ID: <51bc03ad506a9dbb1d95fb13fea336d5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7CB57125
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2005 13:10:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1524> 
======================================================================
Reported By:                hhanke
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1524
Category:                   0_general
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-02-2005 13:10 CET
Last Modified:              11-02-2005 13:10 CET
======================================================================
Summary:                    Heavy use of ALSA brings down all applications using
libasound (major crash)
Description: 
After heavy use of ALSA combined with openning and closing the device each
time before playing a sample and stopping sound playback by snd_pcm_drop
sometimes, after a few hours, something very strange happens and it brings
all applications using ALSA on that machine down (on SIGSEGV or they just
hang and take 100% CPU). After the crash, itt is not possible to start any
application using ALSA (e.g. alsaplayer) because they can't open ALSA
device, until you kill all the applications that were using ALSA at the
time of the crash. Then you can work normally again without the need to
restart ALSA, reload the modules or anything

The crash affects all applications using ALSA on that machine (or at least
using alsalib) but doesn't affect other applications. I've rulled out
running out of memmory and disk space by my tests. The crash affects even
ALSA applications that do nothing and just sit idle, even a newly executed
alsaplayer not playing any sound, the Festival sound synthesizer who is
not doing any sound output in my case, etc. The application that do not
crash on SIGSEGV just hang in some strange place (poll(), sleep() etc.)
and produce 100% CPU load.

This only happens if some other application is playing sound at the same
time
when my test application runs, but is not a DMIX issue since it also
happens on machines not using DMIX.

I discovered that if I modify my sound output code in my test program not
to call snd_pcm_open/close each time I want to play a sound (and thus many
many times) and only use snd_pcm_hw_params_alloc/free, then the bug
disappears
(however, this modification is not practically usable since it only works
with DMIX enabled drivers).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-05 13:10 hhanke         New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
