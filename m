From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000694]: USB Audio Card Giving Errors
Date: Wed, 1 Dec 2004 12:43:49 +0100
Message-ID: <dc706c038f05d05694dd176bd4347d9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7A37B2B9
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2004 12:43:49 +0100 (MET)
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
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-01-2004 00:08 CET
Last Modified:              12-01-2004 12:43 CET
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
 rlrevell - 12-01-04 00:13 
----------------------------------------------------------------------
Sounds like your modules and your kernel do not match.  Did you install
modules separately from the kernel?  Make sure your install is correct.

----------------------------------------------------------------------
 dave-lew99 - 12-01-04 12:43 
----------------------------------------------------------------------
Well im using whatever the defualt kernel for suse 9.1 is (i dont know how
to find out what this is) and alsa drivers and lib's (everything
basically) version 1.0.7. 

I updated alsa to this version in an attempt get this working. Everything
else was what came with the distro

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 00:08 dave-lew99     New Issue                                    
12-01-04 00:13 rlrevell       Note Added: 0002663                          
12-01-04 12:43 dave-lew99     Note Added: 0002664                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
