From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000952]: System freeze at end of MIDI playback
Date: Sun, 23 Apr 2006 07:57:14 +0200
Message-ID: <063a30a697e31eb9738da813c234e9ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7069E17E
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 07:57:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952> 
======================================================================
Reported By:                skunk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   952
Category:                   PCI - emu10k1
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.8-2-k7
======================================================================
Date Submitted:             03-01-2005 06:28 CET
Last Modified:              04-23-2006 07:57 CEST
======================================================================
Summary:                    System freeze at end of MIDI playback
Description: 
Hardware: Sound Blaster Live! Value
Software: sfxload (for patch loading) and drvmidi (playback)

I often play a list of MIDI files. On a number of occasions---either at
the end of a MIDI song, or when I hit STOP---the computer has frozen hard.
The recurrence is rare enough to make this more an annoyance than a
showstopper, but then, I haven't been too keen on ferreting out this bug.

I am reporting this against ALSA from the 2.6.8 kernel, as that is what
I'm using now (Debian official package) but the same problem arose with
alsa-driver 1.0.8 (as compiled by me) on 2.4.29.

I could probably rig up something to start/stop MIDI playback repeatedly,
with a debug-compiled driver, but is there any way to get useful debugging
output when the bug takes the whole system down?
======================================================================

----------------------------------------------------------------------
 skunk - 09-19-05 10:19 
----------------------------------------------------------------------
I haven't been playing MIDI files much lately, so I haven't encountered
this bug again.

----------------------------------------------------------------------
 skunk - 04-23-06 07:57 
----------------------------------------------------------------------
This bug is back with a vengeance.

I am now running Ubuntu Dapper (kernel 2.6.15) on amd64. I'm using the
same Sound Blaster Live! Value board as before, in conjunction with
asfxload, aplaymidi, and (x)playmidi.

Complete system freezes are frequent with MIDI playback. Usually it's at
the end of a song, although on one occasion it happened in the middle.
(The active instruments all held the note they were on---kind of a creepy
effect, IMO.)

I do notice that crashes are less frequent when I play midi through the
AWE32 interface (using playmidi -a) rather than straight ALSA with
aplaymidi. But, as I found out a few minutes ago, they still crop up from
time to time.

Is there a document somewhere detailing how I can get a useful trace on a
crashed kernel, that might help the ALSA developers track down the
problem? This bug is not terribly difficult to reproduce, and I really
would like to be able to play MIDI files without worrying about it....

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-05 06:28 skunk          New Issue                                    
03-01-05 06:28 skunk          Distribution              => Debian testing  
03-01-05 06:28 skunk          Kernel Version            => 2.6.8-2-k7      
09-19-05 10:10 jdthood        Note Added: 0006287                          
09-19-05 10:19 skunk          Note Added: 0006290                          
04-23-06 07:57 skunk          Note Added: 0009441                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
