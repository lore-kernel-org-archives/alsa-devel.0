From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001887]: Can't record anything from MIC with Acer 1641 (ALC260)
Date: Fri, 3 Mar 2006 02:11:21 +0100
Message-ID: <a4e552697d5e75ffa54fee3379316bd1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0DA801AB
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 02:11:22 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Slackware 10.2
Kernel Version:             2.6.15.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-01-2006 22:35 CET
Last Modified:              03-03-2006 02:11 CET
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
 jwoithe - 03-03-06 01:55 
----------------------------------------------------------------------
grattemedi: no problem; glad to have helped and to hear that things are now
working for you.  It's good to get another acknowledgement that the
revised driver works on your laptop.

The bad sound quality when using rec without options is actually due to
two things.  One is certainly the 8 kHz sampling rate, as you say.  The
other possibly more significant issue is the 8 bit recording.  8 bit audio
sounds terrible regardless of the sampling frequency.

Anyway, it's good to hear that this issue is sorted.  It can be closed.



----------------------------------------------------------------------
 rlrevell - 03-03-06 02:11 
----------------------------------------------------------------------
Not a bug (mixer settings)

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
03-03-06 01:55 jwoithe        Note Edited: 0008331                         
03-03-06 02:11 rlrevell       Status                   assigned => closed  
03-03-06 02:11 rlrevell       Note Added: 0008333                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
