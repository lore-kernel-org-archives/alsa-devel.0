From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000665]: Build failure in /usr/src/alsa/alsa-driver/acore/init.c
Date: Mon, 27 Dec 2004 15:48:26 +0100
Message-ID: <cb85b005bd18b6f0760317c9e31c229b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A9557244
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:48:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=665> 
======================================================================
Reported By:                ronis
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   665
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-22-2004 19:31 CET
Last Modified:              12-27-2004 15:48 CET
======================================================================
Summary:                    Build failure in
/usr/src/alsa/alsa-driver/acore/init.c
Description: 
There's an unterminated #ifdef in init.c.  (PM_CONFIG or  more likely
CONFIG_PCI).  Here's the log:

  CC [M]  /usr/src/alsa/alsa-driver/acore/init.o
/usr/src/alsa/alsa-driver/acore/init.c:680:1: unterminated #ifdef
make[4]: *** [/usr/src/alsa/alsa-driver/acore/init.o] Error 1
make[3]: *** [/usr/src/alsa/alsa-driver/acore] Error 2
make[2]: *** [_module_/usr/src/alsa/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.9'
make: *** [compile] Error 2

Adding an extra #endif at the end of the file fixes things, although, I'm
not 100% sure that this is the right place  top put things.

(BTW, I'm now running 2.6.9 but didn't have a chance to midify my
profile)


======================================================================

----------------------------------------------------------------------
 ronis - 11-23-04 22:15 
----------------------------------------------------------------------
OK I moved all the alsa-* directories out of the way, did cvs -z3 update
-dP, followed by my usual build script.   The build now completes fully
and there are no
rejected patch files.   Better yet, the driver works.

As you thought, my CVS tree must have been corrupted somehow.

I guess this can be closed.

Thanks for your help.

----------------------------------------------------------------------
 tiwai - 11-24-04 12:19 
----------------------------------------------------------------------
Ok, closed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-04 19:31 ronis          New Issue                                    
11-23-04 15:59 tiwai          Note Added: 0002517                          
11-23-04 16:52 ronis          Note Added: 0002523                          
11-23-04 17:44 tiwai          Note Added: 0002524                          
11-23-04 18:20 ronis          Note Added: 0002525                          
11-23-04 18:27 tiwai          Note Added: 0002526                          
11-23-04 22:15 ronis          Note Added: 0002535                          
11-24-04 12:19 tiwai          Status                   assigned => resolved
11-24-04 12:19 tiwai          Resolution               open => not an issue
11-24-04 12:19 tiwai          Note Added: 0002548                          
12-27-04 15:48 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
