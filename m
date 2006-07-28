From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002261]: No sound with hda-intel ALC883
Date: Fri, 28 Jul 2006 19:53:53 +0200
Message-ID: <329f50f7550a3ee01b09c145cc5c92cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CEE2C16D
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 19:53:53 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2261> 
======================================================================
Reported By:                lodp2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2261
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Dapper
Kernel Version:             2.6.15-25
======================================================================
Date Submitted:             07-06-2006 22:14 CEST
Last Modified:              07-28-2006 19:53 CEST
======================================================================
Summary:                    No sound with hda-intel ALC883
Description: 
I'm getting no sound on internal speakers, headphone and line jacks on my
Acer Aspire 1652 Z, which has a HDA-Intel card (Realtek ALC883 (ALC882?)
chip). What DOES work is recording, both internal mic and external. I
tried all model options I found for ALC883 in ALSA-Configuration.txt
(3stack-dig, 6stck-dig, auto, no option).

I frequently checked the settings in alsamixer (using alsamixergui), tried
muting/unmuting IEC958, Front, Line. Always tested using aplay *.wav.

I would have tried the latest HG version, but I ran into problems getting
it installed: I did a "./hgcompile --with-cards=hda-intel" and "sudo make
install", which both went through fine -- only "cat /proc/asound/version"
still tells me I've got version 1.0.12rc1, compiled two days ago. I would
appreciate any pointers, as I'm relatively new to this whole business..
======================================================================

----------------------------------------------------------------------
 arpac - 07-28-06 19:14 
----------------------------------------------------------------------
still no change with the last hg (4hours ago, modif by tiwai) :(

----------------------------------------------------------------------
 pwaller - 07-28-06 19:53 
----------------------------------------------------------------------
How can one tell when tiwai makes changes and it's worth checking to see
whether the latest build works?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-06 22:14 lodp2          New Issue                                    
07-06-06 22:14 lodp2          Distribution              => Kubuntu Dapper  
07-06-06 22:14 lodp2          Kernel Version            => 2.6.15-25       
07-06-06 22:24 lodp2          Issue Monitored: lodp2                       
07-10-06 15:01 arpac          Issue Monitored: arpac                       
07-10-06 15:02 arpac          Note Added: 0010961                          
07-10-06 15:03 arpac          Note Edited: 0010961                         
07-10-06 15:04 arpac          Note Edited: 0010961                         
07-10-06 15:04 arpac          Note Edited: 0010961                         
07-20-06 17:28 arpac          Note Added: 0011133                          
07-25-06 01:03 lodp2          Note Added: 0011219                          
07-25-06 01:13 rlrevell       Note Added: 0011220                          
07-25-06 13:08 arpac          Note Added: 0011226                          
07-25-06 17:13 axj            Note Added: 0011229                          
07-27-06 23:50 pwaller        Note Added: 0011281                          
07-28-06 13:09 pwaller        Issue Monitored: pwaller                     
07-28-06 19:14 arpac          Note Added: 0011286                          
07-28-06 19:53 pwaller        Note Added: 0011287                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
