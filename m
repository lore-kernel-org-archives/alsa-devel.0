From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 resend 3/3] ASoC: core: Fix check before setting default I/O up try regmap
Date: Tue, 11 Mar 2014 12:43:22 +0800
Message-ID: <1394513002-21946-4-git-send-email-Li.Xiubo@freescale.com>
References: <1394513002-21946-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394513002-21946-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: lars@metafoo.de, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Since the CODEC driver could specify its own I/O(read and write)
while registering the CODEC for some reason, maybe the MFDs is
used, etc.

So just do check it, if they are not specified by CODEC driver
then try to set up the default regmap I/O if regmap is used.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

This patch has nothing changed.



 sound/soc/soc-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index acef9bd..e692e98 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1137,9 +1137,15 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
-	/* Set the default I/O up try regmap */
-	if (dev_get_regmap(codec->dev, NULL))
-		snd_soc_codec_set_cache_io(codec, NULL);
+	if (!codec->write && dev_get_regmap(codec->dev, NULL)) {
+		/* Set the default I/O up try regmap */
+		ret = snd_soc_codec_set_cache_io(codec, NULL);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to set cache I/O: %d\n", ret);
+			goto err_probe;
+		}
+	}
 
 	if (driver->probe) {
 		ret = driver->probe(codec);
-- 
1.8.4
