From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000957]: When it can't find the kernel source, 1.0.8rc2's configure script complains about an "Unsupported soundcard"
Date: Thu, 16 Jun 2005 14:37:02 +0200
Message-ID: <d03dbb331295564b045cc09ce99b4358@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A7DF191
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2005 14:37:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=957> 
======================================================================
Reported By:                olivierg
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   957
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-02-2005 18:32 CET
Last Modified:              06-16-2005 14:37 CEST
======================================================================
Summary:                    When it can't find the kernel source, 1.0.8rc2's
configure script complains about an "Unsupported soundcard"
Description: 
Hi,

I downloaded alsa-driver-1.0.8rc2, and, as explained in the soundcard
Matrix for my Soundblaster 16, I ran :

./configure --with-cards=sb16 --with-sequencer=yes

Which resulted in :

checking for which soundcards to compile driver for... 
configure: error: Unsupported soundcard sb16

I then tried with 1.0.8 : same thing

But, with 0.9.8, I got a meaningful message : 

Please, install the package with full kernel sources for your
distribution
or use --with-kernel=dir option to specify another directory with kernel
sources (default is /usr/src/linux).

So, I assumed that 1.0.8rc2 was breaking for the same reason, and tried
passing the actual location of my kernel source :

./configure --with-cards=sb16 --with-sequencer=yes
--with-kernel=/usr/src/linux-2.4.25_orpheus.1.3

Which just worked fine.

Please fix 1.0.8rc2's configure script so that it prints meaningful
messages as 0.9.8.

Cheers
======================================================================

----------------------------------------------------------------------
 perex - 06-06-05 10:45 
----------------------------------------------------------------------
Does this problem exist also in 1.0.9a?

----------------------------------------------------------------------
 perex - 06-16-05 14:37 
----------------------------------------------------------------------
No response from user.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 18:32 olivierg       New Issue                                    
06-06-05 10:45 perex          Note Added: 0004898                          
06-16-05 14:37 perex          Status                   assigned => resolved
06-16-05 14:37 perex          Resolution               open => fixed       
06-16-05 14:37 perex          Note Added: 0005053                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
