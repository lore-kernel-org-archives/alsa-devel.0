From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002009]: No pcm when running mythtv, sox, aplay but /dev/pcm present, oss emulation modules loaded
Date: Fri, 7 Apr 2006 04:15:16 +0200
Message-ID: <bc8e8b2eba74b0718365d12d05eff9c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28C8D154
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 04:15:17 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2009> 
======================================================================
Reported By:                chadady
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2009
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE
Kernel Version:             Linux 2.6.17-rc1
======================================================================
Date Submitted:             04-07-2006 04:15 CEST
Last Modified:              04-07-2006 04:15 CEST
======================================================================
Summary:                    No pcm when running mythtv, sox, aplay but /dev/pcm
present, oss emulation modules loaded
Description: 
I have a Sound Blaster PCI512, sound works great for TvTime and XINE.  Have
been trying to get MythTV up and running and it has worked 'fine' up to
1.0.11rc2 (stock kernel 2.6.16.1) in that pcm delivered mono sound, left
speaker only.  On 2.6.16.1 the command 'sox -w -r 44000 -t ossdsp /dev/dsp
-t ossdsp /dev/dsp' provided nice sound, both speakers.  For 1.0.11rc4 the
same command gives "sox: Failed reading /dev/dsp: Unable to set the sample
size to 16", and Myth gives "NVR: AudioInit(): /dev/dsp : error setting
audio input device to 48000kHz/16bits/2channels NVR: Could not detect
audio blocksize NVR: Cannot open DSP '/dev/dsp', exiting"
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 04:15 chadady        New Issue                                    
04-07-06 04:15 chadady        File Added: .config                          
04-07-06 04:15 chadady        Distribution              => SuSE            
04-07-06 04:15 chadady        Kernel Version            => Linux 2.6.17-rc1
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
