From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000407]: toplevel.config.in seems to be missing (and not built) in alsa-driver
Date: Fri, 24 Sep 2004 13:32:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113259.5022F101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2B9421DF
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:34:04 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000407
======================================================================
Reported By:                ronis
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     407
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               slackware-10.0
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-27-2004 05:30 CEST
Last Modified:              09-24-2004 13:32 CEST
======================================================================
Summary:                    toplevel.config.in seems to be missing (and not built) in alsa-driver
Description: 
I died in cvscompile today basically because toplevel.config.in wasn't
found.  Everything worked yesterday.

I'm downloading sources via cvs.
======================================================================

----------------------------------------------------------------------
 ronis - 07-28-2004 18:15 CEST 
----------------------------------------------------------------------
I've looked into this a bit more.  The problem is that toplevel.config.in
is being 
created as empty, basically because mod-deps is failing:

make toplevel.config.in
gcc utils/mod-deps.c -o utils/mod-deps
utils/mod-deps --basedir /usr/src/alsa/alsa-driver/alsa-kernel --hiddendir
/usr/src/alsa/alsa-driver --makeconf > toplevel.config.in
Menu consistency error
make: *** [toplevel.config.in] Error 1

I did reconfigure my linux source tree yesterday (and changed the sound
modules selected in fact).  Could this be the problem?

edited on: 07-28-04 18:15

----------------------------------------------------------------------
 ronis - 07-28-2004 22:31 CEST 
----------------------------------------------------------------------
OK I think I've figured this out.  The problem seems to have gone away.  

I hadn't done a make install in alsa-lib while I was testing out the
atiixp-modem driver (which doesn't work, but that's a story for another
report).  When I tried to go back to my original configuration (i.e., just
atiixp) I ran into the problem I reported.  Seems that a cvs update
changed something critical in alsa-lib; however when I finally got around
to installing there, the subsequent cvscompile in alsa-driver worked
fine.

I guess this is resolved, although perhaps the doc's could be modified to
mention that the order of compiling/installing things in different parts
of the poject is important.  It makes a lot of sense, but hindsite usually
works that way.

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:46 CEST 
----------------------------------------------------------------------
There was a bug in the config generator (regarding the comment directive
in Kconfig).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 05:30 ronis          New Bug                                      
07-27-04 05:30 ronis          Distribution              => slackware-10.0  
07-27-04 05:30 ronis          Kernel Version            => 2.6.7           
07-27-04 18:07 ronis          Bugnote Added: 0001477                       
07-28-04 18:15 ronis          Bugnote Edited: 0001477                      
07-28-04 22:31 ronis          Bugnote Added: 0001482                       
07-30-04 16:46 tiwai          Bugnote Added: 0001488                       
07-30-04 16:46 tiwai          Resolution               open => fixed       
07-30-04 16:46 tiwai          Status                   assigned => resolved
09-24-04 13:32 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
