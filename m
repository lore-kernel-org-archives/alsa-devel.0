From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000371]: dmix does not work with snd-cs46xx driver
Date: Fri, 24 Mar 2006 02:54:01 +0100
Message-ID: <546270f6b570928ce0a85141ac75dcfc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D8FA51A7
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 02:54:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=371> 
======================================================================
Reported By:                fmoraes
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   371
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             07-09-2004 15:59 CEST
Last Modified:              03-24-2006 02:54 CET
======================================================================
Summary:                    dmix does not work with snd-cs46xx driver
Description: 
When trying to use dmix with the snd-cs46xx driver, no output is produced.
======================================================================

----------------------------------------------------------------------
 fmoraes - 03-24-06 02:16 
----------------------------------------------------------------------
I was trying to debug the dmix issues where bad resampling was done (zeros
were added at the end of the buffer in some cases), so that's why I tried
on this card.

Is there a reason why it doesn't work on this card?

In any case, I've retested with ALSA 1.0.11rc2 (FC5) and the problem still
persists.

----------------------------------------------------------------------
 Raymond - 03-24-06 02:54 
----------------------------------------------------------------------
Enable CS46XX_NEW_DSP option when you configure the ALSA CS46XX driver to
use hardware mixing

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-04 15:59 fmoraes        New Issue                                    
07-09-04 15:59 fmoraes        Kernel Version            => 2.6.6-1.435.2.3 
07-15-04 14:10 perex          Status                   new => assigned     
07-15-04 14:10 perex          Assigned To               => perex           
03-09-05 03:09 fmoraes        Note Added: 0003823                          
03-09-05 18:37 tiwai          Note Added: 0003830                          
03-10-05 15:03 jdthood        Note Added: 0003857                          
03-11-05 22:14 fmoraes        File Added: .asoundrc                        
03-11-05 22:15 fmoraes        Note Added: 0003894                          
03-22-06 03:42 rlrevell       Note Added: 0008832                          
03-22-06 18:50 tiwai          Note Added: 0008866                          
03-24-06 02:16 fmoraes        Note Added: 0008907                          
03-24-06 02:54 Raymond        Note Added: 0008909                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
