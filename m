From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001269]: Recursive error on make
Date: Wed, 20 Jul 2005 16:31:48 +0200
Message-ID: <99a5a90eb958b65d77c9d586fe2c2587@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C73191DC
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2005 16:31:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1269> 
======================================================================
Reported By:                tnethaji
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1269
Category:                   alsaconf
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-20-2005 16:31 CEST
Last Modified:              07-20-2005 16:31 CEST
======================================================================
Summary:                    Recursive error on make
Description: 
I have a turtle beach montego II sound card. I downloaded the au8830
driver, lib and utils. version 1.0.9
The driver and lib get installed without problem.

When I install the utils, make fails, with message 'recurssive errors'

I tired to run aclocal to write out new aclocal.m4, but the error was 
this version requires 
AM_CONFIG_HEADER and not AC_CONFIG_HEADER
AM_GNU_GETTEXT_VERSION
AM_GNU_GETTEXT
not found in lib.



======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-20-05 16:31 tnethaji       New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
