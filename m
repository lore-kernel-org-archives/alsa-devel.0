From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000622]: snd-ens1371 hisses and garbled sound
Date: Tue, 2 Nov 2004 21:27:20 +0100
Message-ID: <6c75c1927a80ff8faa8efe1703b5d2bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D12BD1ED
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2004 21:27:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=622> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   622
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-01-2004 11:29 CET
Last Modified:              11-02-2004 21:27 CET
======================================================================
Summary:                    snd-ens1371 hisses and garbled sound
Description: 
Please see Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=239575:

    http://bugs.debian.org/239575

The submitter writes in part:

------------------------------------------------------
Before installing [Debian] sarge I happily used the ALSA sound system on a
2.4.20 [kernel] with my SB PCI 128 soundcard. With the 2.4.24 kernel [...]
the following problems occur:
After initilization of the snd-ens1371 module a loud hiss comes out of the
speakers. The artsd fails and displays a message that it will use the null
output device. All ALSA or arts enabled apps either crash, remain in a
infinite loop  initializing or start with sound disabled.
------------------------------------------------------

Another person adds:

------------------------------------------------------
Sound system is working rather properly but I get continual hisses out of
my soundcard, some sound is coming out as well but is completely garbled.
------------------------------------------------------

Any idea what might be wrong?
======================================================================

----------------------------------------------------------------------
 jdthood - 11-02-04 21:27 
----------------------------------------------------------------------
One of the submitters added the following information.
------------------------------------------------------
[Using alsa-lib 1.0.6]

Actually, I found a workaround to my problem under:
http://www.mail-archive.com/gentoo-user@gentoo.org/msg39015.html

It reads:
> I upgraded to KDE 3.2 (also had an upgrade to alsa-driver .9.8) and
afterward 
> had bad sound.  (I have a Creative PCI 128 card, or something like that,
that 
> linux identifies as an Ensoniq 5880, for which alsa uses the ens1371
card 
> drivers, whatever)
> 
> If I turned up the volume (on the speaker) I got  a lot of hiss and
static on 
> the left channel.  Even when I turned the volume in kmix all the way
down       
> (should be just silence) I would get hiss, static and whatever was
playing 
> (like a song on xmms) 
> 
> After trying a lot of complex things, the solution was pretty simple,
click 
> the little Advanced box in kmix, and uncheck the button for IEC958.
> 

That's what I did and it solved also my problem, though I would be 
pretty happy to have some explanations on the why. I tried also with 
alsamixer and (M)ute on IEC958 works as well, and the setup did survive 
an "alsactl store/restore" cycle. So it looks good for me.

So, for me, the severity can be reduced. I do still think that the 
problem needs to be fixed (for new users), or at least documented.

Cheers, Eric

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-04 11:29 jdthood        New Issue                                    
11-02-04 21:27 jdthood        Note Added: 0002299                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
