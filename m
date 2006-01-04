From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001710]: warning: implicit declaration of function &#8216;pm_register&#8217;
Date: Wed, 4 Jan 2006 14:19:41 +0100
Message-ID: <61797931226404d27130cf60c3cb16d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0C33184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 14:19:41 +0100 (MET)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1710> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1710
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-04-2006 14:16 CET
Last Modified:              01-04-2006 14:19 CET
======================================================================
Summary:                    warning: implicit declaration of function
&#8216;pm_register&#8217;
Description: 
  CC [M]  /usr/src/modules/alsa-driver/acore/misc_driver.o
/usr/src/modules/alsa-driver/acore/misc_driver.c: In function
&#8216;register_pnp_pm_callback&#8217;:
/usr/src/modules/alsa-driver/acore/misc_driver.c:687: warning: implicit
declaration of function &#8216;pm_register&#8217;
/usr/src/modules/alsa-driver/acore/misc_driver.c:687: warning: assignment
makes pointer from integer without a cast
/usr/src/modules/alsa-driver/acore/misc_driver.c: In function
&#8216;unregister_pnp_pm_callback&#8217;:
/usr/src/modules/alsa-driver/acore/misc_driver.c:706: warning: implicit
declaration of function &#8216;pm_unregister&#8217;

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 14:16 jdthood        New Issue                                    
01-04-06 14:19 jdthood        Additional Information Updated                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
