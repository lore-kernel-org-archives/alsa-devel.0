From: JongHo Kim <furmuwon@gmail.com>
Subject: Re: [PATCH] ASoC: Added the condition for the
	channels_min of cpu_dai
Date: Thu, 2 May 2013 18:10:53 +0900
Message-ID: <CANXQt8YW5+Vc8kWuwABjDGSrnWuCmSJuLTaaBdFrsYn65PLs3g@mail.gmail.com>
References: <CANXQt8bj5ZB9aSd5jNC34TYeg4SnGz9h00JJQBS0vHQdEW5LRA@mail.gmail.com>
 <20130430184226.GG26160@sirena.org.uk>
 <CANXQt8Z+4GqnGcxfs8rqPXAZu4WYiVqjV=J9REMhwic_K6CaSA@mail.gmail.com>
 <20130502074449.GA28791@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 870A72602C7
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 11:10:54 +0200 (CEST)
Received: by mail-lb0-f178.google.com with SMTP id x10so310557lbi.37
 for <alsa-devel@alsa-project.org>; Thu, 02 May 2013 02:10:54 -0700 (PDT)
In-Reply-To: <20130502074449.GA28791@sirena.org.uk>
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
index 73bb8ee..a9fddf0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2011,9 +2011,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int
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
