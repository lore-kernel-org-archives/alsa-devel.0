From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000753]: Setting of hw params rate and channels in c++ interface on development seems to use old parameter setting functions.
Date: Wed, 22 Mar 2006 06:22:09 +0100
Message-ID: <df8bb17fb8476de19145eee54128fae9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DAE9E192
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 06:22:09 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=753> 
======================================================================
Reported By:                fredy
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   753
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-28-2004 23:28 CET
Last Modified:              03-22-2006 06:22 CET
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
 perex - 05-30-05 13:21 
----------------------------------------------------------------------
It appears like a linking problem. What does this command says?

nm <your_c++_apps> | grep set_rate

It should be something like:

         U snd_pcm_hw_params_set_rate_near@@ALSA_0.9.0rc4

----------------------------------------------------------------------
 rlrevell - 03-22-06 06:22 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 23:28 fredy          New Issue                                    
03-16-05 22:27 jdthood        Note Added: 0003968                          
05-30-05 13:07 perex          Category                 ordinary pcm => pcm -
digital audio
05-30-05 13:21 perex          Note Added: 0004808                          
03-22-06 06:22 rlrevell       Status                   new => closed       
03-22-06 06:22 rlrevell       Note Added: 0008845                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
