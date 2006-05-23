From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002151]: Card: HDA ULI M5461
Date: Tue, 23 May 2006 16:15:33 +0200
Message-ID: <20060523141533.7088C175@alsa.jcu.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7088C175
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 16:15:33 +0200 (MEST)
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

Analog Devices AD1986A (HDA ULI M5461) on ASUS P4RD1-MX mixer works incorrectly
Message-ID: <31d7f0993b0b69930492a3bead81e742@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2151> 
======================================================================
Reported By:                shadoweel
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2151
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.12 + alsa 1.0.11
======================================================================
Date Submitted:             05-23-2006 16:15 CEST
Last Modified:              05-23-2006 16:15 CEST
======================================================================
Summary:                    Card: HDA ULI M5461                          
Analog Devices AD1986A (HDA ULI M5461) on ASUS P4RD1-MX mixer works incorrectly
Description: 
Hangs for an hour with stock Ubuntu 2.6.12 kernel on azx_get_response
timeout floods
-No sound
-Similar to #2099

Loads with stock ubuntu kernel 2.6.12 +
realtek-linux-audiopack-3.5-6.tar.bz2 following
https://wiki.ubuntu.com/HdaIntelSoundHowto?highlight=%28sound%29
-Sound, but distorted and very low volume
-Only PCM slider in mixer, it works

Loads with stock ubuntu kernel 2.6.12 + stock alsa 1.0.11
(drivers,libs,oss,plugins,utils)
-Clean sound at very high volume (which distorts at peaks)
-Opening / touching the mixer immediately turns sound off (similar to
#2103)
-No master slider (only headphones/front)

I have tried many models, without success. I have a AC'97 front panel with
line out and mic. When the front panel works (with some models), I onlt
get sound from the right speaker. The back panel has three jacks.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 16:15 shadoweel      New Issue                                    
05-23-06 16:15 shadoweel      Distribution              => Ubuntu          
05-23-06 16:15 shadoweel      Kernel Version            => 2.6.12 + alsa 1.0.11
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
