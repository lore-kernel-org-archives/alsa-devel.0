From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000958]: noisy output on low sample rate files when using dmix
Date: Wed, 2 Mar 2005 22:08:46 +0100
Message-ID: <4fc908e217c4c8ba5b27c052cbe11a5c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BF3CD1DB
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2005 22:08:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=958> 
======================================================================
Reported By:                mtraum
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   958
Category:                   mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-02-2005 21:23 CET
Last Modified:              03-02-2005 22:08 CET
======================================================================
Summary:                    noisy output on low sample rate files when using
dmix
Description: 
When using dmix, I get noise when playing files with low sample rates. The
level of noise increases the lower the sample rate is. This noise does not
exist when playing files without dmix, and I'm playing them with 'aplay'.


Files sampled at 44100 have no noticeable noise (at least for me), so I'm
assumming there's a problem with the resampling algorithm.

Just to be sure, I generated some test tones with sgen
(http://www.comp.leeds.ac.uk/jj/linux/siggen.html). You can clearly hear
the noise on these samles, which I am attaching.
======================================================================

----------------------------------------------------------------------
 hamel_g - 03-02-05 22:08 
----------------------------------------------------------------------
I confirm.
If you use the same sampling rate that the sample, the noise disappears.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 21:23 mtraum         New Issue                                    
03-02-05 21:23 mtraum         File Added: testtones.tar.gz                    
03-02-05 22:08 hamel_g        Note Added: 0003781                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
