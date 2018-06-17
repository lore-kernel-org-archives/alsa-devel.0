From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ASoC: codecs: PCM1789: unconditionally flush work
Date: Sun, 17 Jun 2018 15:45:29 +0200
Message-ID: <20180617134532.1070-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Agner <stefan@agner.ch>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Work is guaranteed to be initialized on exit. Drop the unnecessary
if statement and always call flush_work.

This fixes a warning seen with clang:
sound/soc/codecs/pcm1789.c:265:13: warning: address of 'priv->work' will
      always evaluate to 'true' [-Wpointer-bool-conversion]
        if (&priv->work)
        ~~   ~~~~~~^~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/codecs/pcm1789.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
index 21f15219b3ad..8df6447c76a6 100644
--- a/sound/soc/codecs/pcm1789.c
+++ b/sound/soc/codecs/pcm1789.c
@@ -262,8 +262,7 @@ int pcm1789_common_exit(struct device *dev)
 {
 	struct pcm1789_private *priv = dev_get_drvdata(dev);
 
-	if (&priv->work)
-		flush_work(&priv->work);
+	flush_work(&priv->work);
 
 	return 0;
 }
-- 
2.17.1
