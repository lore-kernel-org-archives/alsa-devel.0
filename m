From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000612]: Emu10k1's bass output sounds horrible
Date: Thu, 28 Oct 2004 23:54:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <9a26c2311257d96e3a1423d9c1f6c89b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 729AD29B
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2004 23:54:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=612> 
======================================================================
Reported By:                james
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   612
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               debian
Kernel Version:             2.6.7
======================================================================
Date Submitted:             10-28-2004 04:03 CEST
Last Modified:              10-28-2004 23:54 CEST
======================================================================
Summary:                    Emu10k1's bass output sounds horrible
Description: 
I have a stereo (nothing special) speaker and speakers hooked up to my
computer.  The bass output sounds terrible.  it's distorted and sounds
terrible at low volumes.  With oss, the bass is crystal clear.  i have to
reduce the bass volume to 38 for it to sound respectible.  And at that
level, the high notes are much louder and noticable than the bass ones.

i think there is a 12db boost applied to the speakers by the AC'97 mixer. 
 It would be nice if there was a way to disable this.

i have the sb live value with digital output.  i'm not using digital
output, so it's switched off.

0000:00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

======================================================================

----------------------------------------------------------------------
 pzad - 10-28-04 11:03 
----------------------------------------------------------------------
Bass and treble DSP code is same in OSS and ALSA.

Try to lower "Wave" volume - otherways there will be clipping on bass. 
When you set "PCM" to 75 % this is 0 db.

----------------------------------------------------------------------
 james - 10-28-04 23:54 
----------------------------------------------------------------------
what should the wave volume be set to?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-04 04:03 james          New Issue                                    
10-28-04 04:03 james          Distribution              => debian          
10-28-04 04:03 james          Kernel Version            => 2.6.7           
10-28-04 07:28 james          Issue Monitored: james                       
10-28-04 11:03 pzad           Note Added: 0002285                          
10-28-04 23:54 james          Note Added: 0002287                          
======================================================================




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
