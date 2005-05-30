From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000753]: Setting of hw params rate and channels in c++ interface on development seems to use old parameter setting functions.
Date: Mon, 30 May 2005 13:21:18 +0200
Message-ID: <fd4acdfeaf710dff78d6546b8facfcd0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 936421C7
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 13:21:18 +0200 (MEST)
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
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-28-2004 23:28 CET
Last Modified:              05-30-2005 13:21 CEST
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

----------------------------------------------------------------------
 perex - 05-30-05 13:21 
----------------------------------------------------------------------
It appears like a linking problem. What does this command says?

nm <your_c++_apps> | grep set_rate

It should be something like:

         U snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 23:28 fredy          New Issue                                    
03-16-05 22:27 jdthood        Note Added: 0003968                          
05-30-05 13:07 perex          Category                 ordinary pcm => pcm -
digital audio
05-30-05 13:21 perex          Note Added: 0004808                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
