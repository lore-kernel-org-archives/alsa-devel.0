From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001598]: TeamSpeak works with kernel mode OSS emulation but not with AOSS wrapper
Date: Mon, 3 Apr 2006 03:04:43 +0200
Message-ID: <ebdcf1c6877d25e49c4563d499eb55b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D0751AA
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 03:04:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1598> 
======================================================================
Reported By:                kyromaster
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1598
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-25-2005 14:10 CET
Last Modified:              04-03-2006 03:04 CEST
======================================================================
Summary:                    TeamSpeak works with kernel mode OSS emulation but
not with AOSS wrapper
Description: 
At first this is a device independant issue. I looked at some forums and
tested it on several sound devices.
TeamSpeak works fine with the kernel OSS emulation on my system. But when
I use the AOSS wrapper to run it beside games which use ALSA (which is the
most common use of TeamSpeak) sound recording/output doesn´t work any
more. There´s a "test mode" in TS where you can hear yourself, when I
enable it I can´t hear anything.
Please fix this as it´s very important for all Linux gamers.
======================================================================

----------------------------------------------------------------------
 divinehawk - 04-03-06 03:04 
----------------------------------------------------------------------
The current DEBUG output I get with alsa-oss 1.0.11_rc3 and TeamSpeak is"

Opened PCM dsp0 for stream 0 (result = -2)
Opened PCM default for stream 0 (result = 0)
Opened PCM default for stream 1 (result = 0)
open("/dev/dsp", 2, -1210431528) -> 19
ioctl(19, SNDCTL_DSP_RESET)
ioctl(19, SNDCTL_DSP_SETDUPLEX)
ioctl(19, SNDCTL_DSP_GETCAPS, 0xb4aff158) -> [13056]
ioctl(19, SNDCTL_DSP_SETFRAGMENT, 0xb4aff15c[3000c])
dsp ioctl error = -22
close(19) -> 0

To fix/workaround this, I applied the following patch:

--- pcm.c       2005-09-01 13:32:52.000000000 -0400
+++ /root/alsa-oss-1.0.11rc3/alsa/pcm.c 2006-04-02 20:57:29.233826670
-0400
@@ -262,7 +262,7 @@
                        err = snd_pcm_hw_params_set_access(pcm, hw,
SND_PCM_ACCESS_RW_INTERLEAVED);
                        if (err < 0)
                                return err;
-                       periods_min = 2;
+                       periods_min = 16;
                        err = snd_pcm_hw_params_set_periods_min(pcm, hw,
&periods_min, 0);
                        if (err < 0)
                                return err;

I am not sure why it works... but hopefully it may lead to a real fix,
rather than a workaround.

----------------------------------------------------------------------
 divinehawk - 04-03-06 03:04 
----------------------------------------------------------------------
The current DEBUG output I get with alsa-oss 1.0.11_rc3 and TeamSpeak is"

Opened PCM dsp0 for stream 0 (result = -2)
Opened PCM default for stream 0 (result = 0)
Opened PCM default for stream 1 (result = 0)
open("/dev/dsp", 2, -1210431528) -> 19
ioctl(19, SNDCTL_DSP_RESET)
ioctl(19, SNDCTL_DSP_SETDUPLEX)
ioctl(19, SNDCTL_DSP_GETCAPS, 0xb4aff158) -> [13056]
ioctl(19, SNDCTL_DSP_SETFRAGMENT, 0xb4aff15c[3000c])
dsp ioctl error = -22
close(19) -> 0

To fix/workaround this, I applied the following patch:

--- pcm.c       2005-09-01 13:32:52.000000000 -0400
+++ /root/alsa-oss-1.0.11rc3/alsa/pcm.c 2006-04-02 20:57:29.233826670
-0400
@@ -262,7 +262,7 @@
                        err = snd_pcm_hw_params_set_access(pcm, hw,
SND_PCM_ACCESS_RW_INTERLEAVED);
                        if (err < 0)
                                return err;
-                       periods_min = 2;
+                       periods_min = 16;
                        err = snd_pcm_hw_params_set_periods_min(pcm, hw,
&periods_min, 0);
                        if (err < 0)
                                return err;

I am not sure why it works... but hopefully it may lead to a real fix,
rather than a workaround.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-25-05 14:10 kyromaster     New Issue                                    
04-03-06 03:04 divinehawk     Note Added: 0009080                          
04-03-06 03:04 divinehawk     Note Added: 0009081                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
