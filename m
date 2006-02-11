From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001839]: make error (create_workqueue(name,0)??)
Date: Sat, 11 Feb 2006 05:54:05 +0100
Message-ID: <76c5b036f95f25e3ecff23f1474ea302@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9898917C
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2006 05:54:05 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1839> 
======================================================================
Reported By:                czy32
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1839
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-11-2006 05:54 CET
Last Modified:              02-11-2006 05:54 CET
======================================================================
Summary:                    make error (create_workqueue(name,0)??)
Description: 
  CC [M]  /home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.o
In file included from
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.c:77:
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.inc:494:32: macro
"create_workqueue" passed 2 arguments, but takes just 1
In file included from
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.c:77:
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.inc: In function
`snd_compat_create_workqueue2':
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.inc:494: error:
`create_workqueue' undeclared (first use in this function)
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.inc:494: error: (Each
undeclared identifier is reported only once
/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.inc:494: error: for each
function it appears in.)
make[4]: *** [/home/czy/tmp/alsa/alsa-driver-1.0.10/acore/misc.o]
&#38169;&#35823; 1
make[3]: *** [/home/czy/tmp/alsa/alsa-driver-1.0.10/acore]
&#38169;&#35823; 2
make[2]: *** [_module_/home/czy/tmp/alsa/alsa-driver-1.0.10]
&#38169;&#35823; 2
make[1]: *** [modules] &#38169;&#35823; 2
make[1]: Leaving directory `/usr/src/linux-2.6.9'
make: *** [compile] &#38169;&#35823; 2

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 05:54 czy32          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
