From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001808]: Line 6 Toneport UX1 driver
Date: Wed, 10 May 2006 10:49:20 +0200
Message-ID: <35c1747e61b99a7fdc79f5665c0122a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0405D155
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 10:49:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1808> 
======================================================================
Reported By:                daste
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1808
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-02-2006 00:49 CET
Last Modified:              05-10-2006 10:49 CEST
======================================================================
Summary:                    Line 6 Toneport UX1 driver
Description: 
I recently bought a Line 6 Toneport UX1 USB sound card, but I can't use it
under Linux, since it's not supported by ALSA.
So I'd like to ask you what can I do: altough I'm quite capable of
programming in C, I never developed any kind of driver either for Linux or
any other OS.
I thought that maybe it was my turn to learn, so I wrote an e-mail to Line
6 asking them if they had plans on a Linux driver for such soundcard, or
otherwise, if they would have sent me infos, so that I could have tried to
spend some time trying to develop a driver. They haven't answered yet.
I do want to use that unbelivable sound card under Linux, so I think I'm
going to code, but I don't know where to start: can you give me any
suggestions?
And since I think I have to do some reverse engineering on Microsoft
Windows drivers, can you give some other advice on such topic too?
Otherwise, I'd like to ask you whether you're already developing a
solution for such a problem or not. Thanks in advance.
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-10-06 03:12 
----------------------------------------------------------------------
.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,

Are you sure the device supports exactly those formats?  If the file you
are trying to play back does not match a supported format you must use
plughw:x or you will get an error.

----------------------------------------------------------------------
 daste - 05-10-06 10:49 
----------------------------------------------------------------------
The source files I uploaded are outdated. Actually the card supports
44.1/48 kHz, 16/24 bits, but however if you are using 44.1 kHz 16-bits for
playback, for example, you can only use the same format for capture.
So I asked on alsa-dev ML (without any response) whether I should only
support 48 kHz, 24-bits capture/playback and let ALSA do the work of
conversion, or support all rates.
However I decided to do like the Windows' driver do: 48kHz, 24-bits only.
.formats          = SNDRV_PCM_FMTBIT_S24_3LE,
.rates            = SNDRV_PCM_RATE_48000,
The problem is that when using aplay, also with plughw:x, that error is
returned to me. So I am asking if it could be that my version of ALSA
still does not support S24_3LE 48 kHz stereo conversion from other formats
(S16_LE 44.1 kHz stereo in particular), or maybe I did something wrong
inside the driver!
48kHz 24-bits stereo playback works!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 00:49 daste          New Issue                                    
02-02-06 01:31 rlrevell       Note Added: 0007866                          
02-02-06 08:58 Clemens LadischNote Added: 0007870                          
02-02-06 12:47 daste          File Added: lsusb                            
02-02-06 12:47 daste          Note Added: 0007875                          
02-02-06 16:29 daste          Issue Monitored: daste                       
02-03-06 08:37 Clemens LadischNote Added: 0007892                          
02-03-06 08:37 Clemens LadischAssigned To               => Clemens Ladisch 
02-03-06 08:37 Clemens LadischReproducibility          N/A => always       
02-03-06 08:37 Clemens LadischStatus                   new => assigned     
02-03-06 10:57 daste          Note Added: 0007895                          
03-03-06 10:46 daste          Note Added: 0008339                          
03-26-06 00:33 suamor         Note Added: 0008955                          
03-26-06 09:23 daste          Note Added: 0008966                          
04-19-06 19:16 daste          File Added: line6_tp_ux1.c                    
04-19-06 19:17 daste          File Added: line6_tp_ux1.h                    
04-19-06 19:21 daste          Note Added: 0009353                          
04-20-06 13:19 tiwai          Note Added: 0009372                          
05-10-06 02:58 daste          Note Added: 0009698                          
05-10-06 03:12 rlrevell       Note Added: 0009699                          
05-10-06 10:49 daste          Note Added: 0009706                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
