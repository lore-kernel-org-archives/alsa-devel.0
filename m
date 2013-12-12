From: JongHo Kim <furmuwon@gmail.com>
Subject: ALSA: SNDRV_PCM_STATE_PAUSED
Date: Thu, 12 Dec 2013 15:08:11 +0900
Message-ID: <CANXQt8YqzftRTAUB-ngidxg4PL8gb5JeSL-FGhoKKLvBCEHaVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 94448260786
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 07:08:11 +0100 (CET)
Received: by mail-wg0-f52.google.com with SMTP id x13so7507910wgg.7
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 22:08:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi
I develop ALSA SOC Part and use the tinyalsa library on application space.
We recently used pause ioctl command(SNDRV_PCM_IOCTL_PAUSE)
because the music application was needed to pause and resume feature.
So the music application was achieved to want pause
and resume feature using the SNDRV_PCM_IOCTL_PAUSE.

but I found some problem in alsa kernel framework

The music application process on pause state wake up in 10 seconds
because the wait time is set by 10 seconds in wait_for_avail function.

I realized that if the 'runtime->no_period_wakeup' parameter is true,
the wait_time will be set by the MAX_SCHEDULE_TIMEOUT.

I had searched other kernel source and library source.
I added the SNDRV_PCM_INFO_NO_PERIOD_WAKEUP flag at my snd_pcm_hardware
structure
and added the SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP flag at music
application(use tinyalsa library)

Result was good!
The music application perfectly works the pause and resume feature.

but I have some worries
if DMA or I2S was stop on the running,
I can't more see the 'write error (DMA or IRQ trouble?)' message
and the music application process may be sleep eternally.

I cautiously recommend next code with a solution to the above worries.
-------------------------------------------------------------------------------------
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
old mode 100644
new mode 100755
index 41b3dfe..3284940
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1936,6 +1936,8 @@ static int wait_for_avail(struct snd_pcm_substream
*substream,
                case SNDRV_PCM_STATE_DISCONNECTED:
                        err = -EBADFD;
                        goto _endloop;
+               case SNDRV_PCM_STATE_PAUSED:
+                       continue;
                }
                if (!tout) {
                        snd_printd("%s write error (DMA or IRQ trouble?)\n",
-------------------------------------------------------------------------------------

I tested code. code works good!
but I am concerned about the side effects
please review my idea.
