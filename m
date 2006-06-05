From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002151]: Card: HDA ULI M5461
Date: Mon, 5 Jun 2006 21:59:57 +0200
Message-ID: <20060605195958.43C0D129@alsa.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43C0D129
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jun 2006 21:59:58 +0200 (MEST)
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
Message-ID: <2884d8a053da21b068a1113e55c17802@bugtrack.alsa-project.org>
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
Last Modified:              06-05-2006 21:59 CEST
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

----------------------------------------------------------------------
 gnat - 06-05-06 21:59 
----------------------------------------------------------------------
00:1d.0 Audio device: ALi Corporation High Definition Audio/AC'97 Host
Controller (rev 02)

On an asus board with FC5, no hangs, however I get no sound.


00:1d.0 0403: 10b9:5461 (rev 02)
        Subsystem: 1043:818f
        Flags: bus master, medium devsel, latency 64, IRQ 17
        Memory at bbff8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 16:15 shadoweel      New Issue                                    
05-23-06 16:15 shadoweel      Distribution              => Ubuntu          
05-23-06 16:15 shadoweel      Kernel Version            => 2.6.12 + alsa 1.0.11
05-23-06 16:17 shadoweel      Issue Monitored: shadoweel                    
06-03-06 18:51 shadoweel      Note Added: 0010063                          
06-05-06 21:59 gnat           Note Added: 0010070                          
======================================================================
