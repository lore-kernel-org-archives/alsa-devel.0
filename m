From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001448]: AC3 passthrou on emu10k1 with version 1.0.10rc1 does not work
Date: Sun, 9 Oct 2005 19:33:48 +0200
Message-ID: <657927c179a9efefa834de3ada0822b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D81691A7
	for <alsa-devel@alsa-project.org>; Sun,  9 Oct 2005 19:33:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1448> 
======================================================================
Reported By:                cocobo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1448
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             09-23-2005 20:47 CEST
Last Modified:              10-09-2005 19:33 CEST
======================================================================
Summary:                    AC3 passthrou on emu10k1 with version 1.0.10rc1 does
not work
Description: 
If I run kernel 2.6.14-rc[1-2] (alsa ver 1.0.10rc1) I can't get AC3 s/pdiff
passthrou to work. The external decoder does not switch over to dolby
mode. Kernel 2.6.13 work fine. I have a soundblaster live value soundcard
and use mplayer dev-CVS-050810-20:56-3.4.4 or xine-1.1.0 to play sound.
Ask me for more info if needed.
======================================================================

----------------------------------------------------------------------
 jcdutton - 10-09-05 13:26 
----------------------------------------------------------------------
The version of alsa-driver and alsa-lib should match.
Please refer to the wiki:
http://alsa.opensrc.org/TroubleShooting

It will tell you how to check the alsa-driver and alsa-lib versions.
I see you have alsa-driver version 1.0.10rc1, what about the alsa-lib
version?

----------------------------------------------------------------------
 hugo4711 - 10-09-05 19:33 
----------------------------------------------------------------------
Ok. I have installed alsa-utils and alsa-lib with the corresponding
versions. Now it works. Thank you!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 20:47 cocobo         New Issue                                    
09-23-05 20:47 cocobo         Distribution              => Gentoo          
09-23-05 20:47 cocobo         Kernel Version            => 2.6.14-rc2      
10-05-05 19:05 tiwai          Note Added: 0006440                          
10-09-05 13:16 hugo4711       Note Added: 0006445                          
10-09-05 13:26 jcdutton       Note Added: 0006446                          
10-09-05 19:33 hugo4711       Note Added: 0006447                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
