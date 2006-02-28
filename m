From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001740]: No sound on ACER laptop with ALC260
Date: Wed, 1 Mar 2006 00:51:31 +0100
Message-ID: <8fdc92f871d8f994a2b4ee85a6f78251@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 30C241C0
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:51:31 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001618.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1740> 
======================================================================
Reported By:                Nicolas_Raoul
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1740
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora, Ubuntu, SUSE
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-11-2006 22:40 CET
Last Modified:              03-01-2006 00:51 CET
======================================================================
Summary:                    No sound on ACER laptop with ALC260
Description: 
Hello all,

I have no sound on my ACER Aspire 1640 laptop, Intel HDA, ALC260, all
unmuted, latest everything, tried on:
- SUSE
- Kubuntu
- Ubuntu 2005.10
- Ubuntu 2006.04-flight1
- Fedora
So far, I have never seen any unsilent ALC260 on ACER (please confirm or
infirm). This has lead me to suspect there may be a problem within ALSA.

Yesterday I started modifying the ALSA source code to try and fix it.
Especially, I edited patch_realtek.c. One hour ago, I finally managed to
get some sound out of the headphones :-)

If you have some informations or questions, my contact ids are on
http://nrw.free.fr . Documentation from ACER would be particulary
helpful.

Have a good day,
Nicolas Raoul.

PS: This issue looks somehow similar to those ones:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001517
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001618
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001736.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
duplicate of        0001618 No Sound on Acer with Intel ICH6 HDA an...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 22:40 Nicolas_Raoul  New Issue                                    
01-11-06 22:40 Nicolas_Raoul  Distribution              => Fedora, Ubuntu, SUSE
01-11-06 22:40 Nicolas_Raoul  Kernel Version            => 2.6.15          
03-01-06 00:50 rlrevell       Relationship added       duplicate of 0001517
03-01-06 00:51 rlrevell       Relationship added       duplicate of 0001618
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
