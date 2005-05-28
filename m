From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001094]: nforce4 - optical spdif out not working
Date: Sat, 28 May 2005 09:55:52 +0200
Message-ID: <3a017d6d8e55fa4dfca318afeedad1a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44DF6220
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 09:55:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1094> 
======================================================================
Reported By:                eklarson
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1094
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14_FC3
======================================================================
Date Submitted:             05-07-2005 11:36 CEST
Last Modified:              05-28-2005 09:55 CEST
======================================================================
Summary:                    nforce4 - optical spdif out not working
Description: 
A 48K PCM optical signal is getting sent out to my receiver, however I
can't get anything to play.  I saw in the "intel8x0.c" that there is no
NFORCE4 callouts.  Does the code fully support the nforce4 yet?
======================================================================

----------------------------------------------------------------------
 gergap - 05-09-05 09:56 
----------------------------------------------------------------------
I've the same problem with
INTEL865G ICH-5 (AOpen XC Cube)
SuSE 9.2, kernel 2.6.8-24.14
ALSA 1.0.7rc1

I also compiled the newer version ALSA 1.0.8 but also didn't work.
I can activate IEC958 in the mixer and the light of the optical out goes
on,
but I can't hear anything when connected to my receiver.

I can retest it when the problem is solved to verify it.

----------------------------------------------------------------------
 jaskjok - 05-28-05 09:55 
----------------------------------------------------------------------
I have exactly same problem, although I am trying to use coaxial digital
sound. My  amplifier notices digital signal, there just is no sound. Also
light on optical out goes on when I change mixer settings for IEC958. I
can test both coaxial/optical outs if someone tries to fix the problem.

Analog sound works fine.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 11:36 eklarson       New Issue                                    
05-07-05 11:36 eklarson       Distribution              => Fedora Core 3   
05-07-05 11:36 eklarson       Kernel Version            => 2.6.11-1.14_FC3 
05-07-05 11:41 eklarson       Note Added: 0004604                          
05-07-05 23:44 eklarson       Note Edited: 0004604                         
05-09-05 09:56 gergap         Note Added: 0004622                          
05-28-05 09:55 jaskjok        Note Added: 0004760                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
