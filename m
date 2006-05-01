From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002089]: Audio capture does not work
Date: Mon, 1 May 2006 16:42:54 +0200
Message-ID: <9e3c3372757cef43a174b1687e31ad4f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B765716A
	for <alsa-devel@alsa-project.org>; Mon,  1 May 2006 16:42:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2089> 
======================================================================
Reported By:                stepasha
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2089
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper Drake
Kernel Version:             Linux version 2.6.15-21-386
======================================================================
Date Submitted:             05-01-2006 16:42 CEST
Last Modified:              05-01-2006 16:42 CEST
======================================================================
Summary:                    Audio capture does not work
Description: 
Audio capture for the Intel ICH6 audio controller (Realtek ALC260 mixer)
does not work in Dapper Drake (nor in Breezy from my testing).

My applications have no problems sharing sound, but I have come across the
following symptoms:

1.  I can record using several programs including sound-recorder, but only
silence is recorded.
2.  Audacity gives me no option to choose my capture device (mic, etc.)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-01-06 16:42 stepasha       New Issue                                    
05-01-06 16:42 stepasha       File Added: dmesg.txt                        
05-01-06 16:42 stepasha       Distribution              => Ubuntu Dapper Drake
05-01-06 16:42 stepasha       Kernel Version            => Linux version
2.6.15-21-386
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
