From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000279]: Cannot enable rear line-in
Date: Tue, 28 Feb 2006 06:25:23 +0100
Message-ID: <b62b23afa5dd512c48c8caab39293d77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39F601A3
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 06:25:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=279> 
======================================================================
Reported By:                atiixp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   279
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux i386 testing
Kernel Version:             2.6.6
======================================================================
Date Submitted:             05-17-2004 00:24 CEST
Last Modified:              02-28-2006 06:25 CET
======================================================================
Summary:                    Cannot enable rear line-in
Description: 
ALSA version: the one included in linux 2.6.6

Intro: I use the atiixp driver on a Shuttle ST62K, 
which has two line-ins, one in the front, and one 
in the rear. The one in the front works fine, but 
I can't get the rear line-in to work.

The setup: a TV-card's line-out is connected to 
line-in. Xawtv is running, and the speakers are on.
The alsamixer is configured to a minimal working 
state: 'Master' is set to 71% and 'Line' is set to
71%. When the front line-in is used, this setup 
produces sound. When I move the cable from the 
front line-in to the rear, sound stops.


I have tried changing things in the mixer, for 
example:

- set capture switch
- raise capture volume
- choose the line-in as the capture source
- turn off 'Line-In As Surround'

and then, as a desperate measure:

- raise everything to max, and shifting around 
  capture source and muting.

In the "detailed information" you fill the following
three sections:
  1. Motherboard manual text
  2. output of 'amixer scontents'
  3. output of 'lsmod'

======================================================================

----------------------------------------------------------------------
 jdthood - 08-30-05 12:19 
----------------------------------------------------------------------
Is this bug fixed now?

----------------------------------------------------------------------
 jimt - 02-28-06 06:25 
----------------------------------------------------------------------
With Alsa 1.0.10 I am still unable to use the rear panel line in, after
trying all of the alternative inputs (aux, video, Mic2).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-17-04 00:24 atiixp         New Issue                                    
05-17-04 00:24 atiixp         Distribution              => Debian GNU/Linux i386
testing
05-17-04 00:24 atiixp         Kernel Version            => 2.6.6           
05-17-04 00:27 atiixp         Issue Monitored: atiixp                      
05-17-04 15:02 tiwai          Note Added: 0001129                          
05-17-04 16:27 atiixp         Note Added: 0001133                          
05-17-04 16:28 atiixp         File Added: atiixp.tgz                       
05-25-04 14:26 tiwai          Note Added: 0001210                          
05-26-04 00:37 atiixp         Note Added: 0001241                          
05-26-04 00:38 atiixp         Note Edited: 0001241                         
05-26-04 13:37 tiwai          Note Added: 0001252                          
08-30-05 12:19 jdthood        Note Added: 0005970                          
02-28-06 06:25 jimt           Note Added: 0008240                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
