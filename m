From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001286]: SB PCI 512: Rear channels are inverted
Date: Thu, 28 Jul 2005 04:27:11 +0200
Message-ID: <ba0865e3d22991eb721b3d04f154935d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19F131C7
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 04:27:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1286> 
======================================================================
Reported By:                roothorick
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1286
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-28-2005 04:27 CEST
Last Modified:              07-28-2005 04:27 CEST
======================================================================
Summary:                    SB PCI 512: Rear channels are inverted
Description: 
On my SoundBlaster PCI 512 (essentially a cheap SB Live!) the rear channels
are always inverted, even when using real 4-channel and 6-channel apps
such as Unreal Tournament 2004 with custom OpenAL. This causes my speaker
system's subwoofer to not respond correctly when using the front and rear
channels together in any kind of configuration, unless I manually invert
the channels before sending them to the soundcard (impossible for ALSA
apps, as I STILL can't get the LADSPA plug to work and there's no other
way to simply invert the signal).

I also have an nForce 2 onboard chip for which this doesn't happen unless
I enable the "Duplicate Front" switch. For apps with 4 or more real
channels, this chip produces an appropriate signal and I get good bass
from my speaker system (Cambridge SoundWorks FPS1800).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-28-05 04:27 roothorick     New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
