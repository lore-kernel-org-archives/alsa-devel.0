From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001248]: Sampling rate not correct - reports 44100 but works at 48000
Date: Sun, 10 Jul 2005 05:25:25 +0200
Message-ID: <6027f39d6f5d102584fcc79ea9628234@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4B66163
	for <alsa-devel@alsa-project.org>; Sun, 10 Jul 2005 05:25:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1248> 
======================================================================
Reported By:                steve
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   1248
Category:                   USB - usb-usx2y
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-10-2005 05:25 CEST
Last Modified:              07-10-2005 05:25 CEST
======================================================================
Summary:                    Sampling rate not correct - reports 44100 but works
at 48000
Description: 
Often, when recording with jackd and ardour, after specifying a sampling
rate of 44100 and receiving no complaint from jackd I find the US-122 has
actually been working at 48000.

Also, trying to play a 44100 WAV file via beep-media-player I find the
output pitch-shifted and suspect that again the US-122 is working at
48000.  Resampling the file in software to 48000 causes it to play at the
correct pitch.

I have checked the outpout from dmesg and can see no error messages about
being unable to set the sample rate so I'm puzzled.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-10-05 05:25 steve          New Issue                                    
07-10-05 05:25 steve          Distribution              => Debian          
07-10-05 05:25 steve          Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
