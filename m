From: Adrian Dinu <adrian.dinu95@gmail.com>
Subject: [PATCH] ASoC: Add space around '='
Date: Sat, 25 Feb 2017 13:23:00 +0200
Message-ID: <1488021780-9424-1-git-send-email-adrian.dinu95@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Adrian Dinu <adrian.dinu95@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Adrian Dinu <adrian.dinu95@gmail.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a110d39..70905bd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3139,7 +3139,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->suspend = component->driver->suspend;
 	component->resume = component->driver->resume;
 	component->pcm_new = component->driver->pcm_new;
-	component->pcm_free= component->driver->pcm_free;
+	component->pcm_free = component->driver->pcm_free;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
-- 
1.9.1
