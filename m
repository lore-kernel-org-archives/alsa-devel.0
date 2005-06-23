From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001172]: speaker-test:option -p and -f ignored
Date: Thu, 23 Jun 2005 12:12:34 +0200
Message-ID: <c12cf8a32145f33bf61df5f54dd7eabe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53768219
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2005 12:12:35 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1172> 
======================================================================
Reported By:                norbert
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1172
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-08-2005 15:40 CEST
Last Modified:              06-23-2005 12:12 CEST
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

----------------------------------------------------------------------
 tiwai - 06-23-05 12:12 
----------------------------------------------------------------------
-p option acceps the value between 1000 and 1000000.  100 is too small.
-f option specifies the frequency of sine waves.  If you use pink noises,
it doesn't change anything.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 15:40 norbert        New Issue                                    
06-08-05 15:47 perex          Category                 aplay/arecord =>
speakertest
06-23-05 12:12 tiwai          Status                   new => resolved     
06-23-05 12:12 tiwai          Resolution               open => not an issue
06-23-05 12:12 tiwai          Assigned To               => tiwai           
06-23-05 12:12 tiwai          Note Added: 0005178                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
