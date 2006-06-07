From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002192]: Very annoying acute sound
	recorded from line-in with M5455 chip
Date: Thu, 8 Jun 2006 00:20:26 +0200
Message-ID: <f7f8234f949d241e39351e3adba48189@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3167160
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 00:20:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2192> 
======================================================================
Reported By:                ccasteyde
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2192
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.1
Kernel Version:             2.6.17-rc6
======================================================================
Date Submitted:             06-07-2006 20:42 CEST
Last Modified:              06-08-2006 00:20 CEST
======================================================================
Summary:                    Very annoying acute sound recorded from line-in with
M5455 chip
Description: 
I'm using an ULi integrated sound chip, which reports as a M5455 device,
and which works very nice with the intel8x0 driver for playback, but
recording sound from line-in input gives corrupted sound with a very acute
background sound, except when source gives silence.
I have another motherboard (very older, and still with intel8x0 compatible
chip), and it gives the same result.
======================================================================

----------------------------------------------------------------------
 ccasteyde - 06-08-06 00:05 
----------------------------------------------------------------------
Hmm. Not so simple. I just noticed that mencoder doesn't use the audiorate
option when I use ALSA device. It always use 48000Hz for audio sampling,
and therefore I couldn't see the problem if there was any.

I have no idea how to test ALSA recording with 44100Hz with the programs I
use, sorry. If you have any idea, I could do the test.

----------------------------------------------------------------------
 rlrevell - 06-08-06 00:20 
----------------------------------------------------------------------
arecord -f cd file.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 20:42 ccasteyde      New Issue                                    
06-07-06 20:42 ccasteyde      File Added: record000.wav.mp3                    
06-07-06 20:42 ccasteyde      Distribution              => Slackware 10.1  
06-07-06 20:42 ccasteyde      Kernel Version            => 2.6.17-rc6      
06-07-06 21:16 ccasteyde      Note Added: 0010091                          
06-07-06 21:24 rlrevell       Note Added: 0010092                          
06-07-06 22:03 ccasteyde      Note Added: 0010093                          
06-07-06 22:30 rlrevell       Note Added: 0010095                          
06-07-06 23:49 ccasteyde      Note Added: 0010097                          
06-08-06 00:05 ccasteyde      Note Added: 0010098                          
06-08-06 00:20 rlrevell       Note Added: 0010101                          
======================================================================
