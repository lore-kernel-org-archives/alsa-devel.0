From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001167]: Can't capture anymore
Date: Wed, 8 Jun 2005 01:57:51 +0200
Message-ID: <abaf2b184d1237bbce7bb6bca7b58df4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F3091DF
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 01:57:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1167> 
======================================================================
Reported By:                Skinkie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1167
Category:                   PCI - via82xx
Reproducibility:            unable to duplicate
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11-r10
======================================================================
Date Submitted:             06-08-2005 01:57 CEST
Last Modified:              06-08-2005 01:57 CEST
======================================================================
Summary:                    Can't capture anymore
Description: 
Afther upgrading my system audio worked perfectly, my only concern was the
alsamixer F4 bug, which also crashed the program.

I upgraded tot 1.0.9a and then hell came loose recording was impossible
from /dev/sound/dsp or natively via the alsa drivers. The strangest thing
happened too, because I removed (unmerged) all previous drivers including
previous libraries and headers and then installed 1.0.9a again.

Still I can't record. Audacity's recorder bar stays blinking at the same
position and ices (a production thing I'm using everyday with this laptop)
results in an pcm error too.

I must mention all 'normal' sound is working. But even downgrading(!) to
in kernel versions don't fix my issues. So I'm wondering what I have
broken.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 01:57 Skinkie        New Issue                                    
06-08-05 01:57 Skinkie        Distribution              => Gentoo          
06-08-05 01:57 Skinkie        Kernel Version            => 2.6.11-r10      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
