From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002205]: Everything seems ok,
	but there's no sound
Date: Wed, 5 Jul 2006 15:23:59 +0200
Message-ID: <4725d996f8a394cfb6aa69aae289aef2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A433256
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Jul 2006 15:23:59 +0200 (MEST)
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
Last Modified:              07-05-2006 15:23 CEST
======================================================================
Summary:                    Everything seems ok, but there's no sound
Description: 
After loading snd-hda-intel modul, there's no sound on my acer travelmate
3012 laptop. 
OS is debian sid, kernel 2.6.16.20 SMP, alsa version 1.0.11.

======================================================================

----------------------------------------------------------------------
 rematch - 07-04-06 21:19 
----------------------------------------------------------------------
no.
when i try to use aplay:

ALSA lib pcm_direct.c:819:(snd_pcm_direct_initialize_slave)
snd_pcm_hw_params_any failed
ALSA lib pcm_dmix.c:874:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:533: audio open error: Invalid argument

----------------------------------------------------------------------
 tiwai - 07-05-06 15:23 
----------------------------------------------------------------------
Something is wrong in your configuration.  If you have any /etc/asound.conf
or ~/.asoundrc, remove it first.
Also, make sure that you have no duplicated libasound.so, e.g. /lib and
/usr/lib.

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
07-04-06 21:19 rematch        Note Added: 0010828                          
07-05-06 15:23 tiwai          Note Added: 0010839                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
