From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002175]: Wish: alsa buffer to allow
	suspend-resume without closing sound applications
Date: Wed, 31 May 2006 03:13:16 +0200
Message-ID: <f572369ab24442c9c1d74f6eb34a147e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 58B62146
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 03:13:16 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2175> 
======================================================================
Reported By:                RichardNeill
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2175
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-31-2006 03:13 CEST
Last Modified:              05-31-2006 03:13 CEST
======================================================================
Summary:                    Wish:  alsa buffer to allow suspend-resume without
closing sound applications
Description: 
SUMMARY
-------
I propose a new feature which will be of great help to laptop users during
suspend.

MOTIVATION
----------
When suspending a laptop and then resuming, it's usually necessary to
remove the sound modules and reload them. Removing the modules can only
occur if all sound applications are killed and then restarted. This is
always annoying (eg restarting xmms), but particularly problematic in
cases such as:

  - a sound server, such as Arts is running, maybe needing a KDE restart
  - Mozilla (or similar) has at one time allowed a plugin to access sound.

     but we don't want to lose the contents of 50 open tabs!
  - the timidity service is providing a MIDI interface systemwide.
 
it's also very un user-friendly, especially to non-technical users.

I propose creating a buffer device, which sound apps use instead of
/dev/dsp. Then buffer would cope gracefully with /dev/dsp disappearing and
re-appearing again.


DETAILS
-------

I'm no kernel expert, but here is how I see it working. I'm only going to
consider /dev/dsp for simplicity.

1) At the moment, /dev/dsp is provided by snd_xxx. snd_xxx cannot be
removed while /dev/dsp is open.

2) I propose that instead, we have a new kernel module which provides
/dev/abuffer/dsp:

   Application -> /dev/abuffer/dsp -> /dev/dsp -> snd_xxx


3) /dev/abuffer/dsp must do the following:

    i) The file must always exist, and not go away.

    ii) In normal use, it transfers data directly to /dev/dsp

    iii) The kernel module which provides /dev/abuffer/dsp must not lock 
/dev/dsp with "device is in use".

    iv) When the snd_xxx module is unloaded, /dev/dsp will vanish. 
At this point, /dev/abuffer/dsp must seamlessly redirect its input to
/dev/null, and its output from /dev/zero. (or maybe it should block).

    v)When snd_xxx is reloaded, /dev/abuffer/dsp reconnects seamlessly to
/dev/dsp.


4)Thus, the soundcard can be completely disconnected, and reset, while the
application remains blisfully unaware. As far as the application is
concerned. the file-handle for /dev/abuffer/dsp remains valid all the
time. 

During the period immediately pre/post-suspend (while the snd_xxx module
is unloaded, but the application may still be running), writes to
/dev/buffer/dsp are silently discarded, and reads result in a string of
zeros. Or, it can block. 


5) This has to be repeated for /dev/mixer and all the other sound
devices.


I hope this idea is useful; I'd certainly love to see it implemented! 

Thanks very much - Richard
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-06 03:13 RichardNeill   New Issue                                    
======================================================================
