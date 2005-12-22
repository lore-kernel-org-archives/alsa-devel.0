From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001669]: ppc/tumbler.patch does not apply on 1.0.11rc1 drivers
Date: Thu, 22 Dec 2005 02:16:02 +0100
Message-ID: <a120381a10b9c6c248b9fbb526e66408@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 344EE1B9
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 02:16:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1669> 
======================================================================
Reported By:                Flameeyes
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1669
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.15_rc5
======================================================================
Date Submitted:             12-22-2005 02:16 CET
Last Modified:              12-22-2005 02:16 CET
======================================================================
Summary:                    ppc/tumbler.patch does not apply on 1.0.11rc1
drivers
Description: 
The ppc/tumbler.patch fails to apply on 1.0.11rc1 drivers on PPC.
Attached there's a patch that fixes the patch, allowing alsa-driver to
build on PPC.

(it still does not load on 2.6.15 for now).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 02:16 Flameeyes      New Issue                                    
12-22-05 02:16 Flameeyes      File Added: alsa-driver-1.0.11_rc1-ppc.patch      
             
12-22-05 02:16 Flameeyes      Distribution              => Gentoo Linux    
12-22-05 02:16 Flameeyes      Kernel Version            => 2.6.15_rc5      
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
