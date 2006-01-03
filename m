From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001668]: speaker-test.c should include <byteswap.h> while building on be machines
Date: Tue, 3 Jan 2006 18:31:06 +0100
Message-ID: <641ac3746daf00349139f65dc156ebd6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D80FB16D
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2006 18:31:06 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1668> 
======================================================================
Reported By:                Flameeyes
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - utils
Issue ID:                   1668
Category:                   speakertest
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-22-2005 01:54 CET
Last Modified:              01-03-2006 18:31 CET
======================================================================
Summary:                    speaker-test.c should include <byteswap.h> while
building on be machines
Description: 
The attached patch adds inclusion of byteswap.h header when building on big
endian machines (such as PPC), or it fails with undefined references to
bswap_* functions (they are defines, not functions).

======================================================================

----------------------------------------------------------------------
 Flameeyes - 01-03-06 09:11 
----------------------------------------------------------------------
This is fixed in 1.0.11_rc2, feel free to close.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 01:54 Flameeyes      New Issue                                    
12-22-05 01:54 Flameeyes      File Added: alsa-utils-1.0.11_rc1-bigendian.patch 
                  
01-03-06 09:11 Flameeyes      Note Added: 0007398                          
01-03-06 18:31 rlrevell       Status                   new => resolved     
01-03-06 18:31 rlrevell       Resolution               open => fixed       
01-03-06 18:31 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
