From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002087]: Audio still broken for Asus A8V-MX
Date: Tue, 2 May 2006 17:57:46 +0200
Message-ID: <12c353e988a36d3c5428145d980ca894@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 641D219F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 17:57:46 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2087> 
======================================================================
Reported By:                myxie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2087
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-30-2006 23:33 CEST
Last Modified:              05-02-2006 17:57 CEST
======================================================================
Summary:                    Audio still broken for Asus A8V-MX
Description: 
The patches integrated (see issue 0001622) into the latest release of ALSA
make the on-board audio more usuable, but there are still significant
issues.

Playing an audio file results in a freeze for 10 seconds, followed by a
write error and then the audio continues normally. I noticed a second
write error later on in the stream.

I am happy to try patches, turn on debugging flags etc. Let me know.

======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 17:57 
----------------------------------------------------------------------
It's likely an irq problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-30-06 23:33 myxie          New Issue                                    
04-30-06 23:33 myxie          Distribution              => Debian          
04-30-06 23:33 myxie          Kernel Version            => 2.6.16          
05-02-06 17:57 tiwai          Note Added: 0009562                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
