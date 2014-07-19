From: Killer{R} <support@killprog.com>
Subject: mpd + emu 0404 USB automatic sample rate
Date: Sun, 20 Jul 2014 00:50:33 +0300
Message-ID: <42535576562.20140720005033@killprog.com>
Reply-To: Killer{R} <support@killprog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.z8.ru (smtp.z8.ru [80.93.62.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 173E8261B1B
 for <alsa-devel@alsa-project.org>; Sat, 19 Jul 2014 23:50:58 +0200 (CEST)
Received: from [212.98.162.147] (helo=kllr)
 by smtp.z8.ru with esmtpa (Exim 4.71 (FreeBSD))
 (envelope-from <support@killprog.com>) id 1X8cWW-000GYs-9x
 for alsa-devel@alsa-project.org; Sun, 20 Jul 2014 01:50:32 +0400
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

Hello alsa-devel,

  I'm trying to build bit-perfect music playback box using Olinuxino board
  and EMU 0404 USB sound card running MPD. I have wide collection of lossless
  songs with different sampling rates - from 44100 to 192000. I set MPD config
  to play sound via correct alsa device and it works, however whenever I start
  play song with different sampling rate - MPD (or ALSA?) 'forgets' to switch
  sampling rate frequency and I hear buzzing sound instead of music. If I run
  alsamixer and manually switch there sampling rate - it plays OK until I
  select song with again different sampling rate.
  It seems I'm not first with such a problem, here is same complain
  with a workadound: http://murga-linux.com/puppy/viewtopic.php?p=745547#745547

  Currently I'm running sunxi Linux kernel: 3.4.90, but same bug reproduced when I
  used Raspberry PI with kernel 3.6.11
  ALSA's version: cat /proc/asound/version
  Advanced Linux Sound Architecture Driver Version 1.0.25.
  Seems I was able to fix this on my system, but not sure if this fix is
  correct, here is diff:

--- quirks.c   Fri Jul 18 01:20:16 2014
+++ quirks.c   Sun Jul 20 00:20:49 2014
@@ -723,7 +723,8 @@ static void set_format_emu_quirk(struct
         * by playback substream
         */
        if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-               if (subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].interface != -1)
+               if (subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].interface != -1 &&
+                       subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].running)
                        return;
        }  
  
  
  

-- 
Best regards,
 Killer{R}                          mailto:support@killprog.com
