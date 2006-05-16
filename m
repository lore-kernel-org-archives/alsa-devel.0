From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002129]: No sound on ASUS A6R laptop (atiixp, AD1986)
Date: Tue, 16 May 2006 23:16:58 +0200
Message-ID: <67cc895a419434dca6fae22f6cf01ebc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5968722D
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 23:16:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2129> 
======================================================================
Reported By:                bjorn_mm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2129
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux
Kernel Version:             2.6.12-9
======================================================================
Date Submitted:             05-16-2006 23:16 CEST
Last Modified:              05-16-2006 23:16 CEST
======================================================================
Summary:                    No sound on ASUS A6R laptop (atiixp, AD1986)
Description: 
Greetings,

I have installed alsa-driver-1.0.11 on my laptop (ASUS A6R), but the
soundcard is not producing any sound through the speakers, even though it
is unmuted and recognized in alsamixer as ATI IXP using the AD1986 sound
chip.

The system is using Ubuntu Linux 5.10.x, kernel 2.6.12-9-386. 

I have tried loading the atiixp module using model=asus, model=asus-eapd,
model=laptop and model=laptop-eapd, but none helped.

Here's a link to the laptop specifications @ ASUS:
http://www.asus.com.tw/products4.aspx?modelmenu=2&model=665&l1=5&l2=24&l3=134
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-16-06 23:16 bjorn_mm       New Issue                                    
05-16-06 23:16 bjorn_mm       Distribution              => Ubuntu Linux    
05-16-06 23:16 bjorn_mm       Kernel Version            => 2.6.12-9        
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
