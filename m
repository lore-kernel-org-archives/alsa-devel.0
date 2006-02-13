From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001689]: Build warnings
Date: Mon, 13 Feb 2006 09:23:14 +0100
Message-ID: <16332ae594688d40abb6313f79598f7f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A76D81BF
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 09:23:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1689> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1689
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-28-2005 22:01 CET
Last Modified:              02-13-2006 09:23 CET
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
 jdthood - 12-28-05 22:04 
----------------------------------------------------------------------
I neglected to remove these Debian-specific warnings:

> alsa-driver_1.0.10+1.0.11rc1-1~1_i386.build:Warning: Unknown default
encoding for vi, get it from debian/po/vi.po: UTF-8
> alsa-driver_1.0.10+1.0.11rc1-1~1_i386.build:Warning:Outdated PO file:
debian/po/ca.po, running
> alsa-driver_1.0.10+1.0.11rc1-1~1_i386.build:Warning: Unknown default
encoding for vi, get it from debian/po/vi.po: UTF-8

----------------------------------------------------------------------
 jdthood - 02-13-06 09:23 
----------------------------------------------------------------------
The build log for 1.0.11rc2 on sparc includes these warnings:

if /bin/sh ../../libtool --tag=CC --mode=compile gcc -m64 -DHAVE_CONFIG_H
-I. -I../../../src/control -I../../include -I../../../include    -g -Wall
-O2 -MT control_ext.lo -MD -MP -MF ".deps/control_ext.Tpo" -c -o
control_ext.lo ../../../src/control/control_ext.c; \
	then mv -f ".deps/control_ext.Tpo" ".deps/control_ext.Plo"; else rm -f
".deps/control_ext.Tpo"; exit 1; fi
 gcc -m64 -DHAVE_CONFIG_H -I. -I../../../src/control -I../../include
-I../../../include -g -Wall -O2 -MT control_ext.lo -MD -MP -MF
.deps/control_ext.Tpo -c ../../../src/control/control_ext.c  -fPIC -DPIC
-o .libs/control_ext.o
../../../src/control/control_ext.c: In function 'snd_ctl_ext_elem_info':
../../../src/control/control_ext.c:144: warning: passing argument 3 of
'ext->callback->get_integer64_info' from incompatible pointer type
../../../src/control/control_ext.c:144: warning: passing argument 4 of
'ext->callback->get_integer64_info' from incompatible pointer type
../../../src/control/control_ext.c:144: warning: passing argument 5 of
'ext->callback->get_integer64_info' from incompatible pointer type
../../../src/control/control_ext.c: In function 'snd_ctl_ext_elem_read':
../../../src/control/control_ext.c:208: warning: passing argument 3 of
'ext->callback->read_integer64' from incompatible pointer type
../../../src/control/control_ext.c: In function 'snd_ctl_ext_elem_write':
../../../src/control/control_ext.c:261: warning: passing argument 3 of
'ext->callback->write_integer64' from incompatible pointer type

if /bin/sh ../../libtool --tag=CC --mode=compile gcc -m64 -DHAVE_CONFIG_H
-I. -I../../../src/pcm -I../../include -I../../../include    -g -Wall -O2
-MT pcm_dmix.lo -MD -MP -MF ".deps/pcm_dmix.Tpo" -c -o pcm_dmix.lo
../../../src/pcm/pcm_dmix.c; \
	then mv -f ".deps/pcm_dmix.Tpo" ".deps/pcm_dmix.Plo"; else rm -f
".deps/pcm_dmix.Tpo"; exit 1; fi
 gcc -m64 -DHAVE_CONFIG_H -I. -I../../../src/pcm -I../../include
-I../../../include -g -Wall -O2 -MT pcm_dmix.lo -MD -MP -MF
.deps/pcm_dmix.Tpo -c ../../../src/pcm/pcm_dmix.c  -fPIC -DPIC -o
.libs/pcm_dmix.o
../../../src/pcm/pcm_dmix.c: In function 'mix_areas':
../../../src/pcm/pcm_dmix.c:232: warning: pointer targets in passing
argument 2 of 'dmix->u.dmix.mix_areas3' differ in signedness
../../../src/pcm/pcm_dmix.c:232: warning: pointer targets in passing
argument 3 of 'dmix->u.dmix.mix_areas3' differ in signedness

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 22:01 jdthood        New Issue                                    
12-28-05 22:04 jdthood        Note Added: 0007183                          
02-13-06 09:23 jdthood        Note Added: 0008042                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
