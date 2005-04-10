From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000349]: can't play MIDI through ALSA / MPU-401 but non-ALSA "midiplayer" to MIDI device works
Date: Sun, 10 Apr 2005 07:54:15 +0200
Message-ID: <d8afeb118f3bd716f369a83a7342306b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EDA0327D
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2005 07:54:15 +0200 (MEST)
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
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.5-1 (problem also showed with 2.4.24)
======================================================================
Date Submitted:             06-29-2004 07:58 CEST
Last Modified:              04-10-2005 07:54 CEST
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
 jdthood - 04-07-05 20:57 
----------------------------------------------------------------------
Submitter: Have you ever made any progress on this issue?

----------------------------------------------------------------------
 amarsh04 - 04-10-05 07:54 
----------------------------------------------------------------------
No progress unfortunately. In the meantime have updated to kernel 2.6.11
and found the alsa - udev incompatibility, so removed udev. My hardware
has been also updated, to Pentium 233MMX.

Is there any kind of diagnostic to tell if the MIDI data is actually being
received by the sound card?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-04 07:58 amarsh04       New Issue                                    
06-29-04 07:58 amarsh04       Distribution              => Debian          
06-29-04 07:58 amarsh04       Kernel Version            => 2.6.5-1 (problem also
showed with 2.4.24)
04-07-05 20:57 jdthood        Note Added: 0004365                          
04-10-05 07:54 amarsh04       Note Added: 0004434                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
