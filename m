From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002175]: Wish: alsa buffer to allow
	suspend-resume without closing sound applications
Date: Thu, 1 Jun 2006 05:01:36 +0200
Message-ID: <9639816986fc1fd27f7ba4beae12ac75@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5422013C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 05:01:36 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Last Modified:              06-01-2006 05:01 CEST
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

----------------------------------------------------------------------
 RichardNeill - 06-01-06 04:56 
----------------------------------------------------------------------
I'm using 1.0.10, (Mandriva community 2006,kernel 2.6.14), and I did the
following test:

1)Stop all sound apps, restart the alsa service. 
    [Clean initial state]

2)Play a sound - it works; close the player.

3)Suspend and resume (without reloading alsa modules)

4)Play a sound - it works; close the player.

5)Start up another sound app. I used alsamixergui.  (the timidity service,

  timidity -iADq -Os also provides the same result). Leave it running.

6)Suspend and resume, (without reloading alsa modules)

7)Try to play a sound - it fails
     
8)Kill alsamixergui; reload the modules.

9)Play a sound - it works.
  
  
CONCLUSION:
  4) => Alsa modules survice a suspend without needing to be reloaded.
  9) => Alsa modules only survive a suspend when they are not in use! 


---

Also, despite using aoss where possible, there are still a few "legacy"
apps in common use, eg "play". So it would be nice if the /dev/dsp devices
coped with suspend too.

----------------------------------------------------------------------
 rlrevell - 06-01-06 05:01 
----------------------------------------------------------------------
1.0.10 is too old for debugging, please repeat the test with 1.0.11.

"play" is trivial to fix - just use "aplay" instead.  The hard problems
are Skype and Flash ;-)

Anyway, /dev/dsp vs. ALSA really has nothing to do with this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-06 03:13 RichardNeill   New Issue                                    
05-31-06 22:40 rlrevell       Note Added: 0010031                          
05-31-06 22:54 rlrevell       Note Added: 0010034                          
06-01-06 04:56 RichardNeill   Note Added: 0010040                          
06-01-06 05:01 rlrevell       Note Added: 0010041                          
======================================================================
