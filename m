From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001682]: Errors during install
Date: Mon, 26 Dec 2005 21:20:47 +0100
Message-ID: <0e72c890ac12f707528587dbca8fb5af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 59B38153
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2005 21:20:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1682> 
======================================================================
Reported By:                theskuj
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1682
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-26-2005 20:16 CET
Last Modified:              12-26-2005 21:20 CET
======================================================================
Summary:                    Errors during install
Description: 
Errors during 

'./configure --with-cards=indigo --with-sequencer=yes;make;make install'

Not sure what to do... linux newbie...
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-26-05 20:31 
----------------------------------------------------------------------
What error do you get?

----------------------------------------------------------------------
 theskuj - 12-26-05 21:20 
----------------------------------------------------------------------
make -C /usr/src/linux SUBDIRS=/usr/src/alsa/alsa-driver-1.0.10 modules
make[1]: Entering directory `/usr/src/linux'
make[1]: *** No rule to make target `modules'. Stop.
make[1]: Leaving directory `/usr/src/linux'
make: *** [compile] Error 2
rm -f /lib/modules/2.6.11/misc/snd*.*o /lib/modules/2.6.11/misc/persist.o
/lib/m odules/2.6.11/misc/isapnp.o
make[1]: Entering directory `/usr/src/alsa/alsa-driver-1.0.10/acore'
mkdir -p /lib/modules/2.6.11/misc/acore
mkdir: cannot create directory `/lib/modules/2.6.11': Permission denied
make[1]: *** [modules_install] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.10/acore'
make: *** [install-modules] Error 1
skuj@SkujLaptop:/usr/src/alsa/alsa-driver-1.0.10$

***The entire output is under 'steps to reproduce' in the advanced view.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-05 20:16 theskuj        New Issue                                    
12-26-05 20:31 rlrevell       Note Added: 0007161                          
12-26-05 21:20 theskuj        Note Added: 0007162                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
