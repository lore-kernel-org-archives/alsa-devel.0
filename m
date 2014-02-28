From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 3/3] ASoC: core: Fix check before setting default I/O up try regmap
Date: Fri, 28 Feb 2014 17:04:27 +0800
Message-ID: <1393578267-18255-4-git-send-email-Li.Xiubo@freescale.com>
References: <1393578267-18255-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393578267-18255-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Same with 'ASoC: core: Fix check before defaulting to regmap':

(Check if the chip has provided a write operation (which is mandatory for
I/O) rather than looking for control data as some of the MFDs use a global
for this. Also skip the attempt if there's no regmap available by device
in case things get confused by the attempt to default.)

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6880fad..a14155b 100644
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
