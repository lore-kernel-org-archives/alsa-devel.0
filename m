From: JongHo Kim <furmuwon@gmail.com>
Subject: [PATCH] ASoC: Added the condition for the channels_min
	of cpu_dai
Date: Tue, 30 Apr 2013 15:31:16 +0900
Message-ID: <CANXQt8bj5ZB9aSd5jNC34TYeg4SnGz9h00JJQBS0vHQdEW5LRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E343264F26
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 08:31:16 +0200 (CEST)
Received: by mail-wi0-f178.google.com with SMTP id hm14so146538wib.17
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 23:31:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Only playback device, the pcm substream for capture does not need to be
generated. If codec dai driver has both playback.channels_min and
capture.channels_min, and cpu dai driver has only playback.channels_min,
soc_new_pcm() will make the pcm substream for capture although
DataIN is not connected.
So added the condition for the channels_min of cpu_dai in soc_new_pcm().

Signed-off-by: JongHo Kim <furmuwon@gmail.com>
---
 sound/soc/soc-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index cf191e6..c405e39 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2018,9 +2018,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int
num)
                if (cpu_dai->driver->capture.channels_min)
                        capture = 1;
        } else {
-               if (codec_dai->driver->playback.channels_min)
+               if (codec_dai->driver->playback.channels_min &&
+                   cpu_dai->driver->playback.channels_min)
                        playback = 1;
-               if (codec_dai->driver->capture.channels_min)
+               if (codec_dai->driver->capture.channels_min &&
+                   cpu_dai->driver->capture.channels_min)
                        capture = 1;
        }

-- 
1.8.1.1
