From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001172]: speaker-test:option -p and -f ignored
Date: Thu, 23 Jun 2005 12:41:10 +0200
Message-ID: <dbb16f44999b06504f86f7a4161501d2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4DA7E21A
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2005 12:41:10 +0200 (MEST)
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


The following issue has been REOPENED.
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
Status:                     feedback
======================================================================
Date Submitted:             06-08-2005 15:40 CEST
Last Modified:              06-23-2005 12:41 CEST
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

----------------------------------------------------------------------
 norbert - 06-23-05 12:41 
----------------------------------------------------------------------
man speaker-test:

... To send a nice low 75Hz tone to the Woofer and then exit without
touch&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8208;
       ing any other speakers:

                speaker-test -Dplug:surround51 -c6 -s1 -f75

They forgot -t2 in USAGE EXAMPLES and I felt into this trap by not reading
carefully...


> -p option acceps the value between 1000 and 1000000. 100 is too small.

could be added to man-page, couldn't it?
norbert

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
06-23-05 12:41 norbert        Status                   resolved => feedback
06-23-05 12:41 norbert        Resolution               not an issue => reopened
06-23-05 12:41 norbert        Note Added: 0005181                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
