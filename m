From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: Fix return value of
	ak4641_pcm_set_dai_fmt()
Date: Fri, 30 Dec 2011 23:34:54 +0800
Message-ID: <1325259294.4755.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 02C812435E
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:35:06 +0100 (CET)
Received: by yhjj56 with SMTP id j56so8332781yhj.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:35:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We can't just pass back the return value of snd_soc_update_bits() as it
will be 1 if a bit changed rather than zero.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4641.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 266ebea..c4d165a 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -339,6 +339,7 @@ static int ak4641_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u8 btif;
+	int ret;
 
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -358,7 +359,11 @@ static int ak4641_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	return snd_soc_update_bits(codec, AK4641_BTIF, (0x3 << 5), btif);
+	ret = snd_soc_update_bits(codec, AK4641_BTIF, (0x3 << 5), btif);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int ak4641_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
-- 
1.7.5.4
