From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001771]: License on two files lacks GPL version option
Date: Sun, 22 Jan 2006 20:15:07 +0100
Message-ID: <f0d9e2c8ca8cfbdeaa82140dbc0d426e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCAB6144
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 20:15:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1771> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1771
Category:                   aconnect
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-22-2006 20:15 CET
Last Modified:              01-22-2006 20:15 CET
======================================================================
Summary:                    License on two files lacks GPL version option
Description: 
Most alsa-utils source files contain this text:

 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.

However, two files contain this text:

 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation.

The latter text does not grant the user the option of using a later
version of the GPL.

I found the anomalous license statements in:

  ./seq/aconnect/aconnect.c
  ./seq/aseqnet/aseqnet.c

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 20:15 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
