From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002151]: Card: HDA ULI M5461
Date: Sat, 3 Jun 2006 18:51:20 +0200
Message-ID: <20060603165120.04D19169@alsa.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04D19169
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jun 2006 18:51:20 +0200 (MEST)
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

Analog Devices AD1986A (HDA ULI M5461) on ASUS P4RD1-MX mixer works incorrectly
Message-ID: <9b892ed609a0d4fb455d52c37816be15@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


A NOTE has been added to this issue.
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
Last Modified:              06-03-2006 18:51 CEST
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

----------------------------------------------------------------------
 shadoweel - 06-03-06 18:51 
----------------------------------------------------------------------
Loads with stock ubuntu kernel 2.6.15
-Sound with a very loud high pitch noise
-Opening / touching the mixer immediately turns sound off (similar to
#2103)
-No master slider (only headphones/front)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 16:15 shadoweel      New Issue                                    
05-23-06 16:15 shadoweel      Distribution              => Ubuntu          
05-23-06 16:15 shadoweel      Kernel Version            => 2.6.12 + alsa 1.0.11
05-23-06 16:17 shadoweel      Issue Monitored: shadoweel                    
06-03-06 18:51 shadoweel      Note Added: 0010063                          
======================================================================
