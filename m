From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000428]: unresolved symbols in snd-pcm.ko on alpha linux-2.6.7
Date: Fri, 22 Oct 2004 16:49:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ea665e6ebda5fa499de61eb2edb4dec9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 56E1629D
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2004 16:49:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=428> 
======================================================================
Reported By:                svetljo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   428
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake cooker
Kernel Version:             2.6.7
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             08-06-2004 21:15 CEST
Last Modified:              10-22-2004 16:49 CEST
======================================================================
Summary:                    unresolved symbols in snd-pcm.ko on alpha
linux-2.6.7
Description: 
trying to compile latest alsa driver 1.0.6-rc1
results in unresolved symbols at module link time
in snd-pcm.ko

gcc-3.4 , linux-2.6.7

here is the message:
*** Warning: "__ioremap" [sound/core/snd-pcm.ko] undefined!
*** Warning: "virt_to_phys" [sound/core/snd-pcm.ko] undefined!

which results in unusable alsa drivers
======================================================================

----------------------------------------------------------------------
 svetljo - 08-13-04 14:40 
----------------------------------------------------------------------
general /*probably stupid */ question

why don't you use remap_page_range instead of io_remap_page_range 
wouldn't this solve the problem

----------------------------------------------------------------------
 perex - 10-22-04 16:49 
----------------------------------------------------------------------
Please, reopen if this bug still exists with 1.0.7rc2..

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-04 21:15 svetljo        New Issue                                    
08-06-04 21:15 svetljo        Distribution              => Mandrake cooker 
08-06-04 21:15 svetljo        Kernel Version            => 2.6.7           
08-11-04 19:31 svetljo        Issue Monitored: svetljo                     
08-12-04 11:09 svetljo        Note Added: 0001552                          
08-12-04 11:35 perex          Note Added: 0001553                          
08-12-04 11:42 svetljo        Note Added: 0001554                          
08-12-04 11:54 perex          Note Added: 0001555                          
08-12-04 12:06 svetljo        Note Added: 0001556                          
08-12-04 12:45 svetljo        Note Added: 0001557                          
08-12-04 14:07 svetljo        Note Added: 0001558                          
08-13-04 14:40 svetljo        Note Added: 0001563                          
10-22-04 16:49 perex          Status                   assigned => resolved
10-22-04 16:49 perex          Resolution               open => unable to
duplicate
10-22-04 16:49 perex          Note Added: 0002249                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
