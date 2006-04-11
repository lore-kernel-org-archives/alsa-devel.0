From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001990]: aplay/arecord cannot play/capture A_LAW
Date: Tue, 11 Apr 2006 07:46:04 +0200
Message-ID: <9f1905c4fbc8c28f23d0417f3f97b861@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 06337156
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 07:46:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1990> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1990
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-01-2006 04:26 CEST
Last Modified:              04-11-2006 07:46 CEST
======================================================================
Summary:                    aplay/arecord cannot play/capture A_LAW
Description: 
aplay/arecord can play MU_LAW and the sound card support MU_LAW and A_LAW

arecord -D hw:0,0 -f MU_LAW -t au -c 1 -r 8000 test.au

aplay -D hw:0,0 test.au


Try to use -t raw but the quality of A_LAW is very bad when compare with
MU_LAW

arecord -D hw:0,0 -f A_LAW -t raw -c 1 -r 8000 test.raw

aplay -D hw:0,0 test.raw


======================================================================

----------------------------------------------------------------------
 tiwai - 04-10-06 16:52 
----------------------------------------------------------------------
The OSS emulation doesn't support alaw format conversion, too.  It's the
same behavior as OSS/Free.

----------------------------------------------------------------------
 Raymond - 04-11-06 07:46 
----------------------------------------------------------------------
cat test.raw > /dev/dsp

vortex: pcm_hwparams Playback channels = 1 format =1 rate = 8000


cat test.raw > /dev/audio

vortex: pcm_hwparams Playback channels = 1 format =20 rate = 8000

It seem that /dev/audio support mu-law only

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-06 04:26 Raymond        New Issue                                    
04-03-06 07:16 Raymond        Note Added: 0009085                          
04-03-06 07:36 Raymond        Note Added: 0009086                          
04-07-06 19:32 tiwai          Note Added: 0009152                          
04-08-06 07:47 Raymond        Note Added: 0009171                          
04-10-06 16:52 tiwai          Note Added: 0009199                          
04-11-06 07:46 Raymond        Note Added: 0009229                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
