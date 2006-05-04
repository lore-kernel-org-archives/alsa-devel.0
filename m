From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002096]: Audio Players uses 100% CPU
Date: Thu, 4 May 2006 19:08:07 +0200
Message-ID: <50f10678e3d8fac91b80b130ad7e814e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31E1D239
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 19:08:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2096> 
======================================================================
Reported By:                ksc91u
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2096
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-03-2006 12:27 CEST
Last Modified:              05-04-2006 19:08 CEST
======================================================================
Summary:                    Audio Players uses 100% CPU
Description: 
MB: Asus K8N4-E BIOS 1006

I use xmms or VLC to play internet stream.
And after a period of time...the player get 100% of my CPU,and the sound
become shatter.
I can not even switch to console to kill it.
The only way is to disconnect my network,let the player stop player,and
kill it.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-04-06 12:45 
----------------------------------------------------------------------
Yes, that's the right one.

Could you check whether the errors happen also with plughw PCM?
For overriding everthing, add
   pcm.!default "plughw"
in ~/.asoundrc.

----------------------------------------------------------------------
 ksc91u - 05-04-06 19:08 
----------------------------------------------------------------------
after pcm.!default "plughw"

VLC : Play fine,but GUI become blank and not able to close after a while.
Can only killall vlc.

XMMS : Can not use AO=ALSA .mixer not working when use esd

Mplayer : ao=alsa block when initializing device.mixer ok with ao=esd

Thanks for your help :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-03-06 12:27 ksc91u         New Issue                                    
05-03-06 12:27 ksc91u         File Added: lspci.txt                        
05-03-06 19:25 tiwai          Note Added: 0009600                          
05-04-06 05:15 ksc91u         Note Added: 0009606                          
05-04-06 05:15 ksc91u         File Added: dmesg                            
05-04-06 07:18 ksc91u         Note Edited: 0009606                         
05-04-06 08:14 ksc91u         Note Edited: 0009606                         
05-04-06 11:41 tiwai          Note Added: 0009610                          
05-04-06 12:22 ksc91u         Note Added: 0009615                          
05-04-06 12:45 tiwai          Note Added: 0009616                          
05-04-06 19:08 ksc91u         Note Added: 0009619                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
