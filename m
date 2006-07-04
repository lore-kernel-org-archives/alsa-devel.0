From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002205]: Everything seems ok,
	but there's no sound
Date: Tue, 4 Jul 2006 19:56:45 +0200
Message-ID: <07f2b6c2c616ee3483d88f88a881949e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74A1B229
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 19:56:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2205> 
======================================================================
Reported By:                rematch
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2205
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-13-2006 11:31 CEST
Last Modified:              07-04-2006 19:56 CEST
======================================================================
Summary:                    Everything seems ok, but there's no sound
Description: 
After loading snd-hda-intel modul, there's no sound on my acer travelmate
3012 laptop. 
OS is debian sid, kernel 2.6.16.20 SMP, alsa version 1.0.11.

======================================================================

----------------------------------------------------------------------
 rematch - 07-04-06 19:49 
----------------------------------------------------------------------
i've tried many version of hg, but there's no effect. i compiled the latest
version today but:

chaka:~% xmms mp3/BabaYetu.mp3
** WARNING **: SNDCTL_DSP_SETFMT ioctl failed: Invalid argument
** WARNING **: SNDCTL_DSP_SPEED ioctl failed: Invalid argument

and no effect. any idea or should i buy another laptop?

----------------------------------------------------------------------
 rlrevell - 07-04-06 19:56 
----------------------------------------------------------------------
Does it work if you use an app that supports ALSA natively?

For example does "aplay file.wav" work?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-06 11:31 rematch        New Issue                                    
06-13-06 11:48 rematch        Issue Monitored: rematch                     
06-27-06 09:04 rematch        Note Added: 0010570                          
06-27-06 12:16 tiwai          Note Added: 0010583                          
06-27-06 12:24 rematch        Note Added: 0010584                          
06-28-06 09:25 rematch        Note Added: 0010611                          
07-04-06 19:49 rematch        Note Added: 0010826                          
07-04-06 19:56 rlrevell       Note Added: 0010827                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
