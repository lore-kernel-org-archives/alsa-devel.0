From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000349]: can't play MIDI through ALSA / MPU-401 but non-ALSA "midiplayer" to MIDI device works
Date: Sat, 3 Sep 2005 03:42:35 +0200
Message-ID: <6f4fe9847bf1b49ba47acec9dedcb2ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B7BD16A
	for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2005 03:42:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=349> 
======================================================================
Reported By:                amarsh04
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   349
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Debian
Kernel Version:             2.6.5-1 (problem also showed with 2.4.24)
======================================================================
Date Submitted:             06-29-2004 07:58 CEST
Last Modified:              09-03-2005 03:42 CEST
======================================================================
Summary:                    can't play MIDI through ALSA / MPU-401 but non-ALSA
"midiplayer" to MIDI device works
Description: 
With ISA SB16 PNP, aplaymidi -l reports:
Port    Client name                      Port name
 64:0    Sound Blaster 16 MIDI - Rawmidi  Sound Blaster 16 MIDI
 65:0    OPL3 FM synth                    OPL3 FM Port

Neither 
aplaymidi -p 64:0 myfile.mid
nor 
aplaymidi -p 65:0 myfile.mid 
work, but the non-ALSA "midiplayer" works playing directly to the MIDI
device:

playmidi -v -D0 myfile.mid


======================================================================

----------------------------------------------------------------------
 tiwai - 09-02-05 19:53 
----------------------------------------------------------------------
Do you want to play via an external MIDI device or with OPL3 FM synth?

----------------------------------------------------------------------
 amarsh04 - 09-03-05 03:42 
----------------------------------------------------------------------
I just want to be able to play MIDI files through the OPL3 FM synth - I
have no external MIDI hardware.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-04 07:58 amarsh04       New Issue                                    
06-29-04 07:58 amarsh04       Distribution              => Debian          
06-29-04 07:58 amarsh04       Kernel Version            => 2.6.5-1 (problem also
showed with 2.4.24)
04-07-05 20:57 jdthood        Note Added: 0004365                          
04-10-05 07:54 amarsh04       Note Added: 0004434                          
04-10-05 09:53 jdthood        Status                   new => acknowledged 
04-12-05 16:38 tiwai          Note Added: 0004450                          
08-29-05 06:23 amarsh04       Note Added: 0005964                          
08-29-05 06:25 amarsh04       Note Edited: 0005964                         
09-02-05 19:53 tiwai          Note Added: 0006018                          
09-03-05 03:42 amarsh04       Note Added: 0006029                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
