From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000694]: USB Audio Card Giving Errors
Date: Wed, 14 Sep 2005 16:06:49 +0200
Message-ID: <69aaa6bea7b76e683bef2b6a273bbe73@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 048321A3
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:06:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=694> 
======================================================================
Reported By:                dave-lew99
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   694
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-01-2004 00:08 CET
Last Modified:              09-14-2005 16:06 CEST
======================================================================
Summary:                    USB Audio Card Giving Errors
Description: 
When booting system with Creative MP3+ USB audio card, errors such as
snd_usb_audio: Unknown symbol usb_kill_urb 
snd_usb_lib: unsupported module, tainting kernel are given, these also
show up in dmesg. 

The onboard sound on my laptop works fine (Intel AC '97). The USB card is
detected by Yast in the hardware section but refuses to show up as an
audio card in either alsaconf or the sound section of Yast
======================================================================

----------------------------------------------------------------------
 dave-lew99 - 12-01-04 12:43 
----------------------------------------------------------------------
Well im using whatever the defualt kernel for suse 9.1 is (i dont know how
to find out what this is) and alsa drivers and lib's (everything
basically) version 1.0.7. 

I updated alsa to this version in an attempt get this working. Everything
else was what came with the distro

----------------------------------------------------------------------
 jdthood - 09-14-05 16:06 
----------------------------------------------------------------------
Apparently a local problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 00:08 dave-lew99     New Issue                                    
12-01-04 00:13 rlrevell       Note Added: 0002663                          
12-01-04 12:43 dave-lew99     Note Added: 0002664                          
09-14-05 16:06 jdthood        Status                   assigned => closed  
09-14-05 16:06 jdthood        Note Added: 0006173                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
