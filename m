From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001887]: Can't record anything from MIC with Acer 1641 (ALC260)
Date: Thu, 2 Mar 2006 08:30:20 +0100
Message-ID: <8b01b4bcedb2913926a59e455c9e9355@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D539D1CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 08:30:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1887> 
======================================================================
Reported By:                grattemedi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1887
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.2
Kernel Version:             2.6.15.4
======================================================================
Date Submitted:             03-01-2006 22:35 CET
Last Modified:              03-02-2006 08:30 CET
======================================================================
Summary:                    Can't record anything from MIC with Acer 1641
(ALC260)
Description: 
With the new hda drivers in CVS, the speakers and jack output works very
good.
But I can't record anything from the external mic or from the mic input.
I followed jwoithe advises : To record from the internal mic or the
external mic jack, you need to:

 * select the "mic" as the input source (displayed in "Playback" view)
 * in the "Mic Jack Mode" control, select "Mic bias 80pc"
 * in "Capture" view, unmute "Capture" channel (NOT "Capture 1") and
   turn its volume up.
Even after doing that, I can't record sound.
Nevertheless, when I unmute the "mic" channel in the alsamixer "playback",
i can hear sound from the mic but i cannot record it.
======================================================================

----------------------------------------------------------------------
 jwoithe - 03-02-06 01:38 
----------------------------------------------------------------------
Interesting.  I'll have to ponder this.  Perhaps in the meantime one of the
other 16xx owners (for whom recording works) can chime in and provide a
suggestion.  Did I perhaps forget a step in the process as reproduced by
grattemedi in the initial bug report?

The "Capture" volume is also turned up I assume?  It really sounds as if
the capture channel is muted, but you said it was definitely unmuted in
alsamixer.

It would be good to know whether the recorded file consisted entirely of
zeros or whether it has low-level noise (perhaps too low to be heard when
played back).  Could you check this using hexdump or something?  If not,
could you put it up on the web somewhere so I can grab it?

Since you can hear the mic when you turn up the "mic" control we at least
know that the jack itself is working and that it is definitely in the
"mic" jack (as opposed to the "line in" jack which this laptop also
apparently has).

----------------------------------------------------------------------
 er-ku - 03-02-06 08:30 
----------------------------------------------------------------------
The other 16xx owner uses Gnome and Gnome recorder. As I said in the
mailing list, recording worked for me, but its quality was pretty poor (i
think, it was even worse than the quality of mic playback).

grattemedi, if you unmute the "Capture" and "Capture 1" gains, and set
them to max, then mark both for capture, set "Mic" as the input source for
both channels, and then try to record something, do you hear at least the
hiss? When I did that, I could hear a lot of noise in that case (when
recording from the internal mic, at least).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-06 22:35 grattemedi     New Issue                                    
03-01-06 22:35 grattemedi     Distribution              => Slackware 10.2  
03-01-06 22:35 grattemedi     Kernel Version            => 2.6.15.4        
03-01-06 22:36 grattemedi     Issue Monitored: grattemedi                    
03-01-06 22:37 grattemedi     Issue End Monitor: grattemedi                    
03-02-06 00:53 jwoithe        Note Added: 0008289                          
03-02-06 01:19 grattemedi     Note Added: 0008290                          
03-02-06 01:38 jwoithe        Note Added: 0008291                          
03-02-06 08:30 er-ku          Note Added: 0008294                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
