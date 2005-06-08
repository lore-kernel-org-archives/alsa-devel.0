From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001172]: speaker-test:option -p and -f ignored
Date: Wed, 8 Jun 2005 15:40:29 +0200
Message-ID: <94b2d68e1a040692364c67b0f6631af2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5745D1F2
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 15:40:29 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1172> 
======================================================================
Reported By:                norbert
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1172
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-08-2005 15:40 CEST
Last Modified:              06-08-2005 15:40 CEST
======================================================================
Summary:                    speaker-test:option -p and -f ignored
Description: 
speaker-test: options -p and -f are ignored

> speaker-test -c6 -p100 -f200 -Dsurround51

speaker-test 0.0.8

Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 6 to 5461
Period size range from 3 to 2730
Periods = 4
Buffer time size 2525
To choose buffer_size = 5460
To choose period_size = 1365
was set period_size = 1365
was set buffer_size = 5460
 0 - Front Left
 4 - Center

(sorry for choosing category aplay, but no speaker-test found)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 15:40 norbert        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
