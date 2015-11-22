From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: snd-fireworks requires larger period sizes than FFADO
Date: Sun, 22 Nov 2015 01:20:47 +0100
Message-ID: <56510A5F.4080004@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 870FC260609
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 01:21:31 +0100 (CET)
Received: from [192.168.0.201] ([37.24.103.185]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Lck9X-1ajqJA0eX9-00k71R for
 <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 01:21:31 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to use an Echo AudioFire 4 with the snd-fireworks driver.
With FFADO the device works reasonably well at a period size of
64 samples (on a PREEMPT_RT kernel), whereas with snd-fireworks the
lowest possible period size seems to be 256 samples.

This is what JACK says when I try to start it with a period size of 128
samples:

configuring for 48000Hz, period = 128 frames (2.7 ms), buffer = 2 periods
ALSA: final selected sample format for capture: 32bit integer little-endian
ALSA: cannot set period size to 128 frames for capture

The lowest achievable analog roundtrip latency seems to be around 19ms
(at 2x256 frames), as opposed to 8.3ms with FFADO (at 2x64). Are there
any known limitations of the snd-fireworks driver in this regard?


Thanks,

Dominic
