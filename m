From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002074]: S/PDIF in on Delta 66 doesn't work.
Date: Wed, 26 Apr 2006 02:32:11 +0200
Message-ID: <dd7f9e8c0e8376ba96e7c54d93d5f182@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4437D110
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 02:32:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2074> 
======================================================================
Reported By:                TheMuso
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2074
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux
Kernel Version:             2.6.15-21-686
======================================================================
Date Submitted:             04-26-2006 02:32 CEST
Last Modified:              04-26-2006 02:32 CEST
======================================================================
Summary:                    S/PDIF in on Delta 66 doesn't work.
Description: 
When attempting to either send a sync signal, or an audio signal via S/PDIF
from another card to my Delta 66, no signal is received. A simple test is
to play audio using a card with S/PDIF output, and ensure the audio is
being sent out the S/PDIF port. In envy24control, in the monitor mixer
tab, the S/PDIF inputs can be found by scrolling to the far right. The
metres should be flickering with audio input, but nothing is shown. This
works properly in Windows, so it isn't hardware related. This has been
working in previous versions of alsa, but I can't remember a version
number.

I am running Ubuntu dapper 6.06, with kernel 2.6.15-21-686, and a compiled
copy of alsa-driver 1.0.11.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 02:32 TheMuso        New Issue                                    
04-26-06 02:32 TheMuso        Distribution              => Ubuntu Linux    
04-26-06 02:32 TheMuso        Kernel Version            => 2.6.15-21-686   
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
