From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001330]: alsa-driver fails "make install"
Date: Tue, 13 Dec 2005 13:30:08 +0100
Message-ID: <b4d42e625b5c182d33218e160fba4e77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8F48B1C8
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 13:30:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1330> 
======================================================================
Reported By:                jcdutton
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1330
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-13-2005 00:07 CEST
Last Modified:              12-13-2005 13:30 CET
======================================================================
Summary:                    alsa-driver fails "make install"
Description: 
See output below.
Does anyone have a clew how to fix this?


alsa-driver # make install
find /lib/modules/2.6.13-rc5/kernel/sound -name 'snd*.*o' | xargs rm -f
make[1]: Entering directory `/u/alsacvs/alsa-driver/acore'
make[1]: *** No rule to make target `modules_install'.  Stop.
make[1]: Leaving directory `/u/alsacvs/alsa-driver/acore'
make: *** [install-modules] Error 1



======================================================================

----------------------------------------------------------------------
 perex - 08-13-05 13:47 
----------------------------------------------------------------------
Fixed correctly in CVS.

----------------------------------------------------------------------
 jcdutton - 12-13-05 13:30 
----------------------------------------------------------------------
Fixed in alsa-driver 1.0.10

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 00:07 jcdutton       New Issue                                    
08-13-05 00:26 jcdutton       File Added: make-it-work.diff.txt                 
  
08-13-05 00:27 jcdutton       Note Added: 0005792                          
08-13-05 13:47 perex          Status                   assigned => resolved
08-13-05 13:47 perex          Resolution               open => fixed       
08-13-05 13:47 perex          Note Added: 0005803                          
12-13-05 13:30 jcdutton       Status                   resolved => closed  
12-13-05 13:30 jcdutton       Note Added: 0007012                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
