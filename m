From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002274]: "checking for versioned symbols"
	error in ./configure
Date: Tue, 11 Jul 2006 22:23:32 +0200
Message-ID: <3b338ca0babf744895e19ce5696e8f0b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0F8E24F
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 22:23:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2274> 
======================================================================
Reported By:                joeljkp
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2274
Category:                   0_general
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-11-2006 22:12 CEST
Last Modified:              07-11-2006 22:23 CEST
======================================================================
Summary:                    "checking for versioned symbols" error in
./configure
Description: 
I get the following when I run ./configure:

checking for versioned symbols... ./configure: line 19347: test: "1:
integer expression expected
./configure: line 19350: test: "1: integer expression expected

This is caused by my libtool VERSION string:
VERSION="1.5.22 Debian 1.5.22-2"

The test in configure.in can't currently deal with the quotes.
======================================================================

----------------------------------------------------------------------
 joeljkp - 07-11-06 22:20 
----------------------------------------------------------------------
Proposed patch attached.

----------------------------------------------------------------------
 joeljkp - 07-11-06 22:23 
----------------------------------------------------------------------
Note that the patch works even when no quotes are present:

VERSION="1.5.22 Debian 1.5.22-2"
VERSION=1.5.22 Debian 1.5.22-2
VERSION=1.5.22

all product the right output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-06 22:12 joeljkp        New Issue                                    
07-11-06 22:20 joeljkp        File Added: bug2274.patch                    
07-11-06 22:20 joeljkp        Note Added: 0010980                          
07-11-06 22:23 joeljkp        Note Added: 0010981                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
