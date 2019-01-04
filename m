From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] ASoC: rt274: Variable "buf" in function rt274_jack_detect() could be uninitialized
Date: Fri,  4 Jan 2019 12:27:08 -0800
Message-ID: <20190104202708.14759-1-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In function rt274_jack_detect(), local variable "buf" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used to calculate "hp" and "mic" and
make their value unpredictable while those value are used
in the caller. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index cd048df76232..a2c1a6df8df6 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -353,6 +353,7 @@ static void rt274_index_sync(struct snd_soc_codec *codec)
 static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 {
 	unsigned int buf;
+	int ret = 0;
 
 	*hp = false;
 	*mic = false;
@@ -360,9 +361,15 @@ static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 	if (!rt274->codec)
 		return -EINVAL;
 
-	regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*hp = buf & 0x80000000;
-	regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*mic = buf & 0x80000000;
 
 	pr_debug("*hp = %d *mic = %d\n", *hp, *mic);
-- 
2.17.1
