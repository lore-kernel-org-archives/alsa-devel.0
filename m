From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000665]: Build failure in /usr/src/alsa/alsa-driver/acore/init.c
Date: Tue, 23 Nov 2004 18:27:55 +0100
Message-ID: <61e6b7b671982834554f5417bbe5083b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 218FD2C1
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2004 18:27:56 +0100 (MET)
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


A NOTE has been added to this issue.
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
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-22-2004 19:31 CET
Last Modified:              11-23-2004 18:27 CET
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
 ronis - 11-23-04 18:20 
----------------------------------------------------------------------
Yes.   Basically, the first think I do is to run "cvs -z3 update -dP" from
the directory
above all my alsa-* directories.  

On the other hand, I don't actually do anything in the kernel tree.  My
build-script
works in 

DIRS=( lib driver oss tools utils )   (alsa- is prepeded to each entry)
FLAGS=( "--with-debug=no --with-gnu-ld"
"--with-cards=atiixp,atiixp-modem --with-sequencer=yes" 
"--disable-alsatest --with-gnu-ld" 
"--disable-alsatest --with-gnu-ld" 
"--disable-alsatest --with-gnu-ld" )

(the FLAGS are what I configure with in each,  and then run make)

----------------------------------------------------------------------
 tiwai - 11-23-04 18:27 
----------------------------------------------------------------------
Hmm, it works fine on my system.  At least there should be no rejected
files.  So, I suspect that your tree is somehow broken.

Try once cvs clean checkout.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-04 19:31 ronis          New Issue                                    
11-23-04 15:59 tiwai          Note Added: 0002517                          
11-23-04 16:52 ronis          Note Added: 0002523                          
11-23-04 17:44 tiwai          Note Added: 0002524                          
11-23-04 18:20 ronis          Note Added: 0002525                          
11-23-04 18:27 tiwai          Note Added: 0002526                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
