From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002246]: hpi56301.c
Date: Thu, 29 Jun 2006 17:21:40 +0200
Message-ID: <a4f1428f7d8f00ff3ac55e66d739ccd0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F1FF29A
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 17:21:40 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-29-2006 11:04 CEST
Last Modified:              06-29-2006 17:21 CEST
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
 Raymond - 06-29-06 17:16 
----------------------------------------------------------------------
This patch is similar to the following since this bug re-appear again 

http://hg-mirror.alsa-project.org/alsa-driver?cmd=changeset;node=94a57f17433b;style=gitweb

----------------------------------------------------------------------
 tiwai - 06-29-06 17:21 
----------------------------------------------------------------------
Fixed on HG repo.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 11:04 Raymond        New Issue                                    
06-29-06 16:59 rlrevell       Note Added: 0010666                          
06-29-06 17:16 Raymond        Note Added: 0010668                          
06-29-06 17:21 tiwai          Status                   assigned => resolved
06-29-06 17:21 tiwai          Resolution               open => fixed       
06-29-06 17:21 tiwai          Note Added: 0010669                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
