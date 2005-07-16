From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001263]: Mixer does not work properly with Delta44 at 96000 Hz sampling rate
Date: Sat, 16 Jul 2005 19:25:41 +0200
Message-ID: <ab277e2afd22d1864790f5152566b3a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D9754198
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 19:25:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1263> 
======================================================================
Reported By:                w3sz
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1263
Category:                   alsamixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-16-2005 19:25 CEST
Last Modified:              07-16-2005 19:25 CEST
======================================================================
Summary:                    Mixer does not work properly with Delta44 at 96000
Hz sampling rate
Description: 
There have been several reports to me, and I have confirmed, that when
alsamixer is used with the MAudio Delta 44 soundcard at 96000 Hz sampling
rate, the sliders used to control adc adc1 adc2 adc3 adc4 do not affect
the input sensitivity of the Delta44.  The sliders appear to move, and
alsamixer saves their new positions, but moving them has NO effect on the
input signal to the Delta44.  

This is a major problem, as those using the Delta44 in certain
applications need maximal dynamic range, and this defect in alsamixer
prevents this.

OSS works fine with the Delta44 with a variety of OS's and has NOT
demonstrated this malfunction on the same hardware, with the same OS that
this ALSA defect appears.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 19:25 w3sz           New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
