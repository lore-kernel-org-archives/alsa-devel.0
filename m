From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000350]: Alsa Installation probleme
Date: Fri, 24 Sep 2004 13:31:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113146.695639074@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C3EEE288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:31:46 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000350
======================================================================
Reported By:                miro911
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     350
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-29-2004 18:27 CEST
Last Modified:              09-24-2004 13:31 CEST
======================================================================
Summary:                    Alsa Installation probleme
Description: 
hi everbody.Hi have try to install the news version of alsa on mandarake
10.0 and i have a probleme during the configure sripts some one cane help
my ??

error:[mathieu@mathieu alsa]$ ./configure
checking for gcc... no
checking for cc... no
checking for cc... no
checking for cl... no
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details.

Into Config.log:
## --------- ##
## Platform. ##
## --------- ##

hostname = mathieu
uname -m = i686
uname -r = 2.6.3-7mdksmp
uname -s = Linux
uname -v = https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 SMP Wed Mar 17 14:24:28 CET 2004

/usr/bin/uname -p = unknown
/bin/uname -X     = unknown

/bin/arch              = i686
/usr/bin/arch -k       = unknown
/usr/convex/getsysinfo = unknown
hostinfo               = unknown
/bin/machine           = unknown
/usr/bin/oslevel       = unknown
/bin/universe          = unknown

PATH: /usr/bin
PATH: /bin
PATH: /usr/bin
PATH: /usr/local/bin
PATH: /usr/X11R6/bin/
PATH: /usr/games
PATH: /home/mathieu/bin


## ----------- ##
## Core tests. ##
## ----------- ##

configure:1309: checking for gcc
configure:1338: result: no
configure:1389: checking for cc
configure:1418: result: no
configure:1431: checking for cc
configure:1477: result: no
configure:1530: checking for cl
configure:1559: result: no
configure:1573: error: no acceptable C compiler found in $PATH
See `config.log' for more details.


======================================================================

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:15 CEST 
----------------------------------------------------------------------
Apparently, you didn't install the gcc?
Then it's not a BUG of ALSA.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-29-04 18:27 miro911        New Bug                                      
07-16-04 12:15 tiwai          Bugnote Added: 0001448                       
07-16-04 12:15 tiwai          Resolution               open => not a bug   
07-16-04 12:15 tiwai          Status                   assigned => resolved
09-24-04 13:31 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
