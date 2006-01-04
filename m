From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001711]: warning: &#8216;src&#8217; may be used uninitialized in this function
Date: Wed, 4 Jan 2006 14:18:52 +0100
Message-ID: <cd87a902434b20d758646b2ffc9c329a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E8AC184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 14:18:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1711> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1711
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-04-2006 14:18 CET
Last Modified:              01-04-2006 14:18 CET
======================================================================
Summary:                    warning: &#8216;src&#8217; may be used uninitialized
in this function
Description: 
  CC [M]  /usr/src/modules/alsa-driver/acore/oss/route.o
In file included from /usr/src/modules/alsa-driver/acore/oss/route.c:2:
/usr/src/modules/alsa-driver/include/../alsa-kernel/core/oss/route.c: In
function &#8216;route_to_channel&#8217;:
/usr/src/modules/alsa-driver/include/../alsa-kernel/core/oss/route.c:208:
warning: &#8216;src&#8217; may be used uninitialized in this function
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 14:18 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
