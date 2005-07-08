From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001034]: (potential) problems introduced with the " improved stream linking and plugin code cleanups" patch by perex
Date: Fri, 8 Jul 2005 10:38:15 +0200
Message-ID: <a1fb9658f811d4186cafd59d0cc9b11d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3107186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:15 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1034> 
======================================================================
Reported By:                modax
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1034
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-03-2005 17:42 CEST
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    (potential) problems introduced with the " improved
stream linking and plugin code cleanups" patch by perex
Description: 
I'm not an alsa developer so I hadn't known anything about alsa internals
up until I started debugging alsa-lib to fix an annoying bug I was having
with alsa 1.0.9rc1 and above. I'm not sure whether my patch/suggestions
are 100% correct or the best way fix to those bugs.

The initial problem I'm refering to is described in bug#1009 note
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0004275. I narrowed my
search of the regression down to the big patch,
which was submitted to alsa-lib CVS on 2005-01-20 by perex. The patch
cleans up plugin code. Unfortunately, some things have been overlooked by
the author. Firstly, I'll start with my problem and a fix for it.

As I described in note
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0004275, I had problems
with -Dsurround51 on my
NFORCE board. The root of the problem was a combination of two plugins -
route and hooks - used in surround51 configuration. Later I learned, that
removing one of them helped, but they both wouldn't work. The portion of
code which is to blame for the regression can be seen in
hooks-channel-info-fix.patch (attached). Just compare the original
pcm_hooks.c:snd_pcm_hooks_channel_info() (before "2005-01-20" patch) and
pcm_generic.c:snd_pcm_generic_channel_info(), which was supposed to
replace it. They are completely different functions. Other plugins which
are likely to suffer from the same bug are:
  * pcm_file.c
  * pcm_plug.c

However, most other plugins used
pcm_plugin.c:snd_pcm_plugin_channel_info() before the "2005-01-20" patch.
It shares the same code with snd_pcm_generic_channel_info(). So this issue
raises a few question:
  * Is snd_pcm_generic_channel() as it is now valid? At least pcm_hooks
and likely pcm_file and pcm_plug don't work with it.
  * If it's valid, there is a necessity to create another generic
function, which clones the code previously provided by
snd_pcm_{hooks,file,plug}_channel_info() functions.

The attached patch solves the problem for me, but it is not an universal
solution. The patch should be applied against CVS as of 2005-01-21 or
later.

And now here it comes some other remarks regarding the "2005-01-20"
patch.
  * I guess, snd_pcm_plugin_fast_ops.status = snd_pcm_generic_status in
pcm_plugin.c is incorrect because it makes snd_pcm_plugin_status()
reduntant and these functions don't share the same code.
  * Plugins which haven't been "cleaned up" by the "2005-01-20" patch
include:
    - pcm_meter.c
    - pcm_null.c
    - pcm_share.c
    - pcm_shm.c
    The latter two seem to be kinda different beasts whereas the first two
shouldn't be too difficult to "_generic_"'ize.
======================================================================

----------------------------------------------------------------------
 modax - 04-03-05 17:53 
----------------------------------------------------------------------
I wonder where my alsa/os info has disappered. The bug applies to alsa-lib
1.0.8+cvs20050121 and later. I'm running Debian unstable and Linux kernel
2.6.11.5  with alsa-driver 1.0.9rc2+cvs20050330

----------------------------------------------------------------------
 tiwai - 04-05-05 18:07 
----------------------------------------------------------------------
Thanks for reports.  I fixed this on CVS in the similar way.
snd_pcm_generic_channel_info_slave() is added to be called from these
three plugins.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-05 17:42 modax          New Issue                                    
04-03-05 17:42 modax          File Added: hooks-channel-info-fix.diff           
        
04-03-05 17:53 modax          Note Added: 0004312                          
04-05-05 18:07 tiwai          Status                   new => resolved     
04-05-05 18:07 tiwai          Resolution               open => fixed       
04-05-05 18:07 tiwai          Assigned To               => tiwai           
04-05-05 18:07 tiwai          Note Added: 0004338                          
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
