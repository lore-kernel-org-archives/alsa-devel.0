From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000753]: Setting of hw params rate and channels in c++ interface on development seems to use old parameter setting functions.
Date: Wed, 16 Mar 2005 22:27:57 +0100
Message-ID: <995b4aeddeb4b9b9cc47943a4b52b517@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7BB161D2
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 22:27:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=753> 
======================================================================
Reported By:                fredy
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   753
Category:                   ordinary pcm
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-28-2004 23:28 CET
Last Modified:              03-16-2005 22:27 CET
======================================================================
Summary:                    Setting of hw params rate and channels in c++
interface on development seems to use old parameter setting functions.
Description: 
In developing a c++ class for pcm_interface I can't set the rate an
channels. For example setting a rate of 48000 samples/sec leaves the
parameters with odd values.
By debugging I see that while setting access and format uses the regular
pcm_hw_params_... functions, setting rate uses _old_pcm_hw_params and
probably uses different parameters structures. I've searched #defines in
headers that force the use of old functions without finding anthing
related.
The test program pcm works correctly. 
======================================================================

----------------------------------------------------------------------
 jdthood - 03-16-05 22:27 
----------------------------------------------------------------------
Could this possibly be related to http://bugs.debian.org/288652 ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 23:28 fredy          New Issue                                    
03-16-05 22:27 jdthood        Note Added: 0003968                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
