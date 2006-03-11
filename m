From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001908]: Stereo channels swapped using Midiman Audiophile 24/96
Date: Sat, 11 Mar 2006 10:24:13 +0100
Message-ID: <7a5a0d12cba92a54513508677ff11a18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6EE26195
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 10:24:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1908> 
======================================================================
Reported By:                sebastian_ml
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1908
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-11-2006 09:34 CET
Last Modified:              03-11-2006 10:24 CET
======================================================================
Summary:                    Stereo channels swapped using Midiman Audiophile
24/96
Description: 
Hi all,

the stereo channels (L/R) are swapped. Say you patch PCM0 to HW Out 0 and
do the same with PCM1 and HW Out 1 then the channel order is wrong.
For now I use the Digital Mixer to make it right.

I discovered this by accident when I had both my mp3 player and my 2496
connected to the same amp playing the same song. They sounded different. I
swapped L/R and all was fine.

When booting Windows the L/R order is accurate.

I'll upload some pictures of envy24control in a few.

Thanks

Sebastian
======================================================================

----------------------------------------------------------------------
 sebastian_ml - 03-11-06 10:24 
----------------------------------------------------------------------
The first attachment is a picture of the Patchbay. Patching PCM Out 1 to
H/W Out 1 (L) and doing the same with PCM Out 2 and H/W Out 2 (R) results
in L and R being swapped.

To "fix" this I patch Digital Mix 1 to H/W Out 1 (L) and Digital Mix 2 to
H/W Out 2 (R) and then I set the Monitor Mixer like shown in the second
attachment.

The correct way to use the Monitor Mixer would be the one shown in
attachment 3. But then L/R is swapped.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 09:34 sebastian_ml   New Issue                                    
03-11-06 09:34 sebastian_ml   Distribution              => Gentoo          
03-11-06 09:34 sebastian_ml   Kernel Version            => 2.6.15.6        
03-11-06 10:17 sebastian_ml   File Added: patchbay-pcm.png                    
03-11-06 10:24 sebastian_ml   Note Added: 0008415                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
