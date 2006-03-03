From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001887]: Can't record anything from MIC with Acer 1641 (ALC260)
Date: Fri, 3 Mar 2006 01:53:48 +0100
Message-ID: <7e4a0f321a8de6513e40e73a9dae3605@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2A3F1AA
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 01:53:48 +0100 (MET)
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
Last Modified:              03-03-2006 01:53 CET
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
 grattemedi - 03-03-06 01:44 
----------------------------------------------------------------------
I'm so sorry to have disturb you for such a thing.Finally it was the space
with the capture highlighted that resolved the problem. Eventough, the
command
 "amixer set Capture unmute" does nothing, but the "toggle" as the same
effect than space in alsamixer. I'm sorry, i didn't see this option in
alsamixer.

The record in 44100 Hz works very good and quality is perfect, but rec
with no option like you said cause a bad quality sound as it's in 8kHz.

Thank you very much for your patience.

----------------------------------------------------------------------
 jwoithe - 03-03-06 01:53 
----------------------------------------------------------------------
grattemedi: Glad to have helped and to hear that things are now working for
you.  It's good to get another acknowledgement that the revised driver
works on your laptop.

The bad sound quality when using rec without options is actually due to
two things.  One is certainly the 8 kHz sampling rate, as you say.  The
other possibly more significant issue is the 8 bit recording.  8 bit audio
sounds terrible regardless of the sampling frequency.

Anyway, it's good to hear that this issue is sorted.  It can be closed.

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
03-02-06 11:25 cartman        Issue Monitored: cartman                     
03-02-06 17:10 grattemedi     Note Added: 0008321                          
03-02-06 17:11 grattemedi     File Added: test.wav                         
03-02-06 17:13 grattemedi     Note Edited: 0008321                         
03-02-06 17:13 grattemedi     Note Edited: 0008321                         
03-02-06 18:21 grattemedi     Note Added: 0008325                          
03-03-06 00:02 jwoithe        Note Added: 0008328                          
03-03-06 01:44 grattemedi     Note Added: 0008330                          
03-03-06 01:53 jwoithe        Note Added: 0008331                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
