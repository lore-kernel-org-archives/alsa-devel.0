From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001930]: Can`t get timidity woking in soft synth mode
Date: Fri, 19 May 2006 11:06:21 +0200
Message-ID: <881fba4e6d16a94417c499f82904bed7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A17EA1A3
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2006 11:06:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1930> 
======================================================================
Reported By:                drolyk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1930
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-15-2006 23:41 CET
Last Modified:              05-19-2006 11:06 CEST
======================================================================
Summary:                    Can`t get timidity woking in soft synth mode
Description: 
Can`t get timidity woking in "soft synth mode".
======================================================================

----------------------------------------------------------------------
 Raymond - 04-26-06 13:48 
----------------------------------------------------------------------
If you has only one card intel8x0 or hda-intel, you need to modprobe
snd-seq since SND_INTEL8X0 or SND_HDA_INTEL is not depend on
SND_MPU401_UART or SND_RAWMIDI in Kconfig

lsmod

snd-pcm-oss            36160   0  (autoclean)
snd-mixer-oss          16216   0  (autoclean) [snd-pcm-oss]
snd-intel8x0           24956   0
snd-ac97-codec         91072   0  [snd-intel8x0]
snd-pcm                76124   0  [snd-pcm-oss snd-intel8x0
snd-ac97-codec]
snd-timer              19016   0  [snd-pcm]
snd                    51808   0  [snd-pcm-oss snd-mixer-oss snd-intel8x0
snd-ac97-codec snd-pcm snd-timer]
soundcore               6468   4  [snd]
snd-page-alloc          7648   0  [snd-mixer-oss snd-intel8x0 snd-pcm
snd-timer snd]

----------------------------------------------------------------------
 Raymond - 05-19-06 11:06 
----------------------------------------------------------------------
If drolyk can load snd-mpu401, your motherboard must has an onboard superio
chip for midi. (most likely PNP is also enabled when there is no extra
option passed to drivers)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 23:41 drolyk         New Issue                                    
03-15-06 23:41 drolyk         Distribution              => Debian          
03-15-06 23:41 drolyk         Kernel Version            => 2.6.15.6        
03-19-06 23:55 fdoffizi01     Note Added: 0008700                          
03-20-06 01:28 rlrevell       Note Added: 0008702                          
03-20-06 01:42 fdoffizi01     Note Added: 0008703                          
03-20-06 03:24 rlrevell       Note Added: 0008706                          
03-20-06 06:08 drolyk         Note Added: 0008709                          
03-20-06 06:22 rlrevell       Note Added: 0008710                          
03-20-06 07:19 Raymond        Note Added: 0008711                          
03-20-06 12:55 fdoffizi01     Note Added: 0008718                          
03-20-06 15:50 fdoffizi01     Issue Monitored: fdoffizi01                    
03-20-06 22:19 drolyk         Note Added: 0008726                          
03-20-06 22:21 drolyk         Note Edited: 0008726                         
03-20-06 22:36 fdoffizi01     Note Added: 0008727                          
03-20-06 23:29 rlrevell       Note Added: 0008729                          
03-20-06 23:40 fdoffizi01     Note Added: 0008730                          
03-20-06 23:54 rlrevell       Note Added: 0008731                          
03-21-06 00:14 fdoffizi01     Note Added: 0008732                          
03-21-06 08:46 Raymond        Note Added: 0008739                          
03-21-06 09:00 Raymond        Note Edited: 0008739                         
03-21-06 10:58 fdoffizi01     Note Added: 0008741                          
04-15-06 10:49 Raymond        Note Added: 0009293                          
04-19-06 10:05 Raymond        Note Deleted: 0009293                        
04-19-06 10:08 Raymond        Note Added: 0009350                          
04-19-06 16:56 fdoffizi01     Note Added: 0009351                          
04-20-06 14:37 tiwai          Note Added: 0009374                          
04-26-06 13:48 Raymond        Note Added: 0009508                          
05-19-06 11:06 Raymond        Note Added: 0009876                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
