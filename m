From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000979]: Feature Request : Bass redirection on emu10k1 cards
Date: Thu, 10 Mar 2005 19:40:07 +0100
Message-ID: <803bd48b18bfe0d19c5f02148038146b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 41A631A6
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 19:40:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=979> 
======================================================================
Reported By:                Casper
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   979
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10-gentoo-r4
======================================================================
Date Submitted:             03-10-2005 19:40 CET
Last Modified:              03-10-2005 19:40 CET
======================================================================
Summary:                    Feature Request : Bass redirection on emu10k1 cards
Description: 
The goal of this feature is to generate a LFE channel from a stereo source
by removing low frequencies of this source and sending them to the LFE
output. I think this can be made by the DSP.

I own a Creative SB Audigy, and a home-made 5.1 sound system with only
amplifiers and no filters. So when I listen to music, all my speakers
works fine with channel mirroring, but the LFE output is not filtered and
the sound is awful. And when I use mplayer to play music with the option
"-af sub" which generates a LFE channel, the low frequencies are already
present on the others speakers and then bass are too loud.

Is this possible to add this feature ?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-05 19:40 Casper         New Issue                                    
03-10-05 19:40 Casper         Distribution              => Gentoo          
03-10-05 19:40 Casper         Kernel Version            => 2.6.10-gentoo-r4
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
