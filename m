From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000371]: dmix does not work with snd-cs46xx driver
Date: Sun, 26 Mar 2006 03:06:08 +0200
Message-ID: <bcdc680c61255014785de34562be9155@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5458A1CC
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 03:06:08 +0200 (MEST)
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
Last Modified:              03-26-2006 03:06 CEST
======================================================================
Summary:                    dmix does not work with snd-cs46xx driver
Description: 
When trying to use dmix with the snd-cs46xx driver, no output is produced.
======================================================================

----------------------------------------------------------------------
 fmoraes - 03-25-06 02:17 
----------------------------------------------------------------------
Is this a compile time only option? If so, then it is of no use. This is a
legitimate dmix or cs46xx driver bug unless there is a real reason why
this is happening.

----------------------------------------------------------------------
 Raymond - 03-26-06 03:06 
----------------------------------------------------------------------
CS46XX.conf assume hardware mixing for playback and dsnoop for capture

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/conf/cards/CS46xx.conf?r1=1.4&r2=1.5

But CS46XX_NEW_DSP is not enabled by default 

remove your .asoundrc and change CS46XX.conf to use dmix similart to
ICH.conf

http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-lib/src/conf/cards/ICH.conf?rev=1.12

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
03-25-06 02:17 fmoraes        Note Added: 0008940                          
03-26-06 03:06 Raymond        Note Added: 0008964                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
