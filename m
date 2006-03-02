From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001887]: Can't record anything from MIC with Acer 1641 (ALC260)
Date: Thu, 2 Mar 2006 01:38:47 +0100
Message-ID: <17b5ddfea44c7b091d8690428a9ac6fb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F29A1D0
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 01:38:47 +0100 (MET)
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
Last Modified:              03-02-2006 01:38 CET
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
 grattemedi - 03-02-06 01:19 
----------------------------------------------------------------------
I 've tried two software : first i've tried with the shell command :
   rec test.wav    (i have also tried the --volume=100 option)
and play test.wav to hear it.There 's no error but when i tape play
test.wav, there is no sound at all : "total silence".
Indeed i use "Input Source" and not "Input Source 1".
Secondly i tried with a kde software KRec with no success : "total
silence" when i play what i've recorded.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
