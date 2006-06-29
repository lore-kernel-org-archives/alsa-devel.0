From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002246]: hpi56301.c
Date: Thu, 29 Jun 2006 16:59:09 +0200
Message-ID: <0508917b17b95c5c6b24e022ebcea06f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 124A629C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 16:59:10 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2246> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2246
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-29-2006 11:04 CEST
Last Modified:              06-29-2006 16:59 CEST
======================================================================
Summary:                    hpi56301.c
Description: 
change <dpi56301.h> and <boot4ka.h> to "boot4ka.h" and "boot4ka.h" 

#include "hpi56301.h"
#include <dpi56301.h>

...

#ifndef __linux__
#pragma hdrstop			// allow headers above here to be precompiled
#endif
#include <boot4ka.h>


======================================================================

----------------------------------------------------------------------
 rlrevell - 06-29-06 16:59 
----------------------------------------------------------------------
Please post a PATCH.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 11:04 Raymond        New Issue                                    
06-29-06 16:59 rlrevell       Note Added: 0010666                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
