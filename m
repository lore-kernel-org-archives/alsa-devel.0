From: Ross Wille <audio@cornerbrick.com>
Subject: i.MX6 SGTL5000 hangs with EIO error
Date: Thu, 12 May 2016 11:54:48 -0600
Message-ID: <201605121154.48951.audio@cornerbrick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.willeweb.com (willeweb.com [166.70.233.13])
 by alsa0.perex.cz (Postfix) with ESMTP id D6DA126047C
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 19:54:50 +0200 (CEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by mail.willeweb.com (Postfix) with ESMTP id 470331214031
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 11:54:49 -0600 (MDT)
Content-Disposition: inline
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

Hello all,

I am doing an ALSA capture on a Wandboard Quad (i.MX6 quad core with 
SGTL5000 codec chip) from the LINEIN1 jack.  I'm using a 4.6.0-rc3-armv7-x0 
kernel.

Sometimes when the audio glitches (for example, when I plug/unplug the audio 
cable or adjust my signal generator) the snd_pcm_readi() function will 
start returning -5 (EIO).

Once this happens, the only way I've been able to recover is to reboot the 
computer.  Calling snd_pcm_close(), snd_pcm_prepare(), snd_pcm_start(), 
etc. doesn't help.  When in this state, running arecord returns IO errors 
as well.

It's interesting that, on rare occasions, I must do a power cycle in order 
to recover.  When a reboot is not effective I've noticed that the capture 
device doesn't appear in /proc/asound/devices.

I don't believe my specific ALSA settings are important, but I'm calling 
snd_pcm_readi() with ALSA set to a sample rate of 48000, format of S16_LE, 
channels=1, frames per period of 960 (20 mS periods), and 4 periods per 
buffer.

This same problem happens on two different Wandboards, so I don't think it's 
a defective board or chip.  It has happened on older kernels as well.

Any ideas?

Thank you!

Ross Wille
