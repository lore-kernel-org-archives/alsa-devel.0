From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001004]: Doesn't accept all sample rates, when capturing sound in S16_LE or S16_BE format.
Date: Mon, 21 Mar 2005 19:26:40 +0100
Message-ID: <a42ac8568f71490eb15b2a8a5d2fd0d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8FE5B279
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2005 19:26:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1004> 
======================================================================
Reported By:                hyp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1004
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.4.29
======================================================================
Date Submitted:             03-21-2005 19:26 CET
Last Modified:              03-21-2005 19:26 CET
======================================================================
Summary:                    Doesn't accept all sample rates, when capturing
sound in S16_LE or S16_BE format.
Description: 
When I request to capture sound with: 8000Hz, S16 LE, stereo the ioctl
returns me that the accepted values are the same as requested. But the
whole read()-ed data is captured with 44100 or 48000Hz (I don't know 
the right value, I guess it by ear), independendly from the requested
sample rate.

I tried to capture sound via sox's recorder. For example with command:
# rec -c 1 -d /dev/dsp0 -f s -r 8000 p.snd
When I started to play this file, I noticed that the file is captured 
with 44100 or 48000Hz sample rate, but in the .snd header are written
that the file is recorder with 8000Hz sample rate (as I have requested 
it). If I set the sample rate to 48000 and play the tune, it sounds 
good. Also this problem can be seen with my own oss recorder.

When I'm using anouther sound card, for example Creative Ensoniq 1371
or Creative EMU10K1 everything is good!

best regards.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-05 19:26 hyp            New Issue                                    
03-21-05 19:26 hyp            Distribution              => Slackware       
03-21-05 19:26 hyp            Kernel Version            => 2.4.29          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
