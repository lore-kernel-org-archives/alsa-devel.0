From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000721]: System stops completely when playing audio
Date: Wed, 29 Dec 2004 23:01:21 +0100
Message-ID: <0a104b025eab4373a493e7c4d5654279@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ABB02254
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 23:01:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=721> 
======================================================================
Reported By:                spirou
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   721
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-12-2004 13:58 CET
Last Modified:              12-29-2004 23:01 CET
======================================================================
Summary:                    System stops completely when playing audio
Description: 
I have a Tascam US-428. Wehen I connect to the USB, the driver is loaded,
the USB-LED of the 428 lights up. When I try to play audio (e.g. with
aplay or XMMS), the computer immedeately stops working. All I can do is to
push the reset-button. No log-entrys, nothing.
======================================================================

----------------------------------------------------------------------
 karsten - 12-29-04 20:14 
----------------------------------------------------------------------
both keyboard dead & hangup shutting down after switching us428 off happen
here also sometimes. I think it is ok when I unload the snd-usb-usx2y
module first. ( $/etc/init.d/alsasound stop)

To the silence problem:
There is no alsa-mixer interface yet.
Is us428control activ? Check by pressing "INPUT MONITOR".
If us428control is activ, put the "MASTER" slider to 9 NOT 10.
10 magically equals 0 after us428 having started. (Seams to be some
feedback omitting strategy.) 
If this doesn't help: can you verify that audio is really being played by
watching some transport indicators?
Any difference when you set nrpacks=1 on modprobe snd-usb-usx2y?
$rmmod snd-usb-usx2y
$modprobe snd-usb-usx2y nrpacks=1

----------------------------------------------------------------------
 spirou - 12-29-04 23:01 
----------------------------------------------------------------------
Oh, I see...Control is not active (pressing Input Monitor doesn't do
anything). Eehm...how do I activate this? I couldn't find anything about
it in the docs or I don't know where to search...thx.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-04 13:58 spirou         New Issue                                    
12-12-04 13:58 spirou         Distribution              => Gentoo          
12-12-04 13:58 spirou         Kernel Version            => 2.6.9           
12-12-04 14:20 karsten        Note Added: 0002816                          
12-12-04 14:52 spirou         Note Added: 0002817                          
12-12-04 18:51 karsten        Note Added: 0002818                          
12-29-04 11:15 spirou         Note Added: 0002994                          
12-29-04 20:14 karsten        Note Added: 0003010                          
12-29-04 23:01 spirou         Note Added: 0003013                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
