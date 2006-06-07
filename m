From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000952]: System freeze at end of MIDI
	playback
Date: Wed, 7 Jun 2006 18:09:39 +0200
Message-ID: <089d120c6a4e8334f7434015ad4cbf55@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D8D5169
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 18:09:39 +0200 (MEST)
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
Last Modified:              06-07-2006 18:09 CEST
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

----------------------------------------------------------------------
 pen - 06-07-06 18:09 
----------------------------------------------------------------------
Having the same issue here (it seemed to be triggered by The GIMP - recent
CVS builds have a MIDI controller, and the freezes stopped when I disabled
it)

Kernel - 2.6.15-23-k7 (Ubuntu Dapper)
ALSA - 1.0.10-4ubuntu4
Sound Card - Creative Sound Blaster Live! 5.1 Digital

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-05 06:28 skunk          New Issue                                    
03-01-05 06:28 skunk          Distribution              => Debian testing  
03-01-05 06:28 skunk          Kernel Version            => 2.6.8-2-k7      
09-19-05 10:10 jdthood        Note Added: 0006287                          
09-19-05 10:19 skunk          Note Added: 0006290                          
04-23-06 07:57 skunk          Note Added: 0009441                          
06-07-06 18:09 pen            Note Added: 0010085                          
======================================================================
