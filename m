From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000899]: Cannot aplay to Sound Galaxy card with alsa-lib 1.0.8: looks for "/usr/share/alsa/cards/Sound Galaxy.conf"
Date: Fri, 8 Jul 2005 10:35:06 +0200
Message-ID: <51b66362cba09fb1ff7c8b88db9da238@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19298186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=899> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   899
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-09-2005 17:14 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    Cannot aplay to Sound Galaxy card with alsa-lib
1.0.8: looks for "/usr/share/alsa/cards/Sound Galaxy.conf"
Description: 
This is forwarded Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=293907.  Please see
http://bugs.debian.org/293907 for the full report.

The submitter says that with his Sound Galaxy card he cannot get aplay
to work.  He gets the following error when he runs aplay:

-------------- error message ----------------------

ALSA lib conf.c:2792:(snd_config_hook_load) "/usr/share/alsa/cards/Sound
Galaxy.conf" is not a word
ALSA lib conf.c:2672:(snd_config_hooks_call) function
snd_config_hook_load_for_all_cards returned error: Invalid argument
ALSA lib pcm.c:1947:(snd_pcm_open_conf) Invalid type for PCM default
definition (id: default, value: cards.pcm.default)
aplay: main:508: audio open error: Invalid argument

------------ end error message ---------------------

There is no "Sound Galaxy.conf" file, but the user doesn't get an error
message when he uses alsa-lib 1.0.7.

======================================================================

----------------------------------------------------------------------
 jdthood - 02-12-05 10:07 
----------------------------------------------------------------------
Will this bug:

    http://bugs.debian.org/294880

also be fixed by your patch?

----------------------------------------------------------------------
 tiwai - 02-14-05 16:23 
----------------------------------------------------------------------
I believe yes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 17:14 jdthood        New Issue                                    
02-09-05 17:56 tiwai          Note Added: 0003560                          
02-09-05 17:57 tiwai          File Added: conf-space-fix.diff                   

02-09-05 17:59 tiwai          Status                   new => resolved     
02-09-05 17:59 tiwai          Resolution               open => fixed       
02-09-05 17:59 tiwai          Assigned To               => tiwai           
02-09-05 17:59 tiwai          Note Added: 0003561                          
02-09-05 17:59 tiwai          Assigned To              tiwai =>            
02-12-05 10:07 jdthood        Status                   resolved => feedback
02-12-05 10:07 jdthood        Resolution               fixed => reopened   
02-12-05 10:07 jdthood        Note Added: 0003570                          
02-14-05 16:23 tiwai          Status                   feedback => resolved
02-14-05 16:23 tiwai          Resolution               reopened => fixed   
02-14-05 16:23 tiwai          Assigned To               => tiwai           
02-14-05 16:23 tiwai          Note Added: 0003599                          
02-14-05 16:24 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
