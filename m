From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001286]: SB PCI 512: Rear channels are
	inverted
Date: Sat, 15 Jul 2006 12:12:27 +0200
Message-ID: <e52008135e2e12d292d20b8e7d79ce3e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9F49169
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 12:12:27 +0200 (MEST)
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
Last Modified:              07-15-2006 12:12 CEST
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

----------------------------------------------------------------------
 roothorick - 07-28-05 04:28 
----------------------------------------------------------------------
forgot lspci -v stuffs.

0000:01:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 08)
        Subsystem: Creative Labs CT4790 SoundBlaster PCI512
        Flags: bus master, medium devsel, latency 32, IRQ 17
        I/O ports at d000 [size=32]
        Capabilities: [dc] Power Management version 1

0000:01:08.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400 [size=8]
        Capabilities: [dc] Power Management version 1

----------------------------------------------------------------------
 halfgaar - 07-15-06 12:12 
----------------------------------------------------------------------
My SBLive has the same behaviour. My SBlive is:

01:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 32, IRQ 20
        I/O ports at cc00 [size=32]
        Capabilities: [dc] Power Management version 1

But, the original OSS EMU10k1 docs said that it was the fronts which were
inverted, not the rear. When you have only 4 channels, it doesn't matter
much which one you invert back. But when you've got more (I don't know if
there are emu10k1's who have), the channels are still out of phase.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-28-05 04:27 roothorick     New Issue                                    
07-28-05 04:28 roothorick     Note Added: 0005576                          
07-15-06 12:05 halfgaar       Issue Monitored: halfgaar                    
07-15-06 12:12 halfgaar       Note Added: 0011020                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
