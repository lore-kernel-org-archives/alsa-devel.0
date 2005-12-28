From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001690]: Build warnings
Date: Wed, 28 Dec 2005 22:05:14 +0100
Message-ID: <12b879c55d7b1e9daa426d1742de8163@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC3EA190
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 22:05:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1690> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1690
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-28-2005 22:04 CET
Last Modified:              12-28-2005 22:05 CET
======================================================================
Summary:                    Build warnings
Description: 
$ grep arnin *.build | grep -v 'differ in signedness' | grep -v 'unused
parameter'|grep -v 'could not be resolved' | grep -v 'remember to run'
alsa-driver_1.0.10+1.0.11rc1-1~1_i386.build:Warning: Unknown default
encoding for vi, get it from debian/po/vi.po: UTF-8
alsa-driver_1.0.10+1.0.11rc1-1~1_i386.build:Warning:Outdated PO file:
debian/po/ca.po, running
alsa-driver_1.0.10+1.0.11rc1-1~1_i386.build:Warning: Unknown default
encoding for vi, get it from debian/po/vi.po: UTF-8
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:dpkg-source: warning: ignoring
deletion of file config.guess
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:dpkg-source: warning: ignoring
deletion of file config.sub
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:simple_none.c:1273: warning:
'type' may be used uninitialized in this function
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:pcm_route.c:348: warning: 'src'
may be used uninitialized in this function
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:seq.c:4438: warning: assignment
from incompatible pointer type
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:206: warning: unused
variable 's'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:214: warning: unused
variable 's'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:231: warning: unused
variable 'changed'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:230: warning: unused
variable 's'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:239: warning: unused
variable 's'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:247: warning: unused
variable 's'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:255: warning: unused
variable 's'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:312: warning: unused
variable 'count'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:54: warning: 'to_user'
defined but not used
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:sbase.c:63: warning: 'from_user'
defined but not used
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:/home/jdthood/src/pkg-alsa/svn-pkg-alsa/trunk/build-area/alsa-lib-1.0.10+1.0.11rc1/include/global.h:131:
Warning: Member snd_user_file(const char *file, char **result) of group
Global is not documented.
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:/home/jdthood/src/pkg-alsa/svn-pkg-alsa/trunk/build-area/alsa-lib-1.0.10+1.0.11rc1/include/global.h:131:
Warning: Member snd_user_file(const char *file, char **result) of group
Global is not documented.
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:libtool: install: warning:
relinking `smixer-sbase.la'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:libtool: install: warning:
relinking `smixer-ac97.la'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:libtool: install: warning:
relinking `smixer-hda.la'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:libtool: install: warning:
relinking `smixer-sbase.la'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:libtool: install: warning:
relinking `smixer-ac97.la'
alsa-lib_1.0.10+1.0.11rc1-1~1_i386.build:libtool: install: warning:
relinking `smixer-hda.la'
alsa-utils_1.0.10+1.0.11rc1-1~1_i386.build:dpkg-source: warning: ignoring
deletion of file config.guess
alsa-utils_1.0.10+1.0.11rc1-1~1_i386.build:dpkg-source: warning: ignoring
deletion of file config.sub

======================================================================

----------------------------------------------------------------------
 jdthood - 12-28-05 22:05 
----------------------------------------------------------------------
duplicate

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 22:04 jdthood        New Issue                                    
12-28-05 22:05 jdthood        Status                   new => closed       
12-28-05 22:05 jdthood        Note Added: 0007184                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
