From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs35l33: Remove setting dapm->bias_level
 in cs35l33_set_bias_level
Date: Tue, 28 Jun 2016 18:36:59 +0800
Message-ID: <1467110219.1638.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B371267E6B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 12:37:05 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id c74so1470928pfb.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 03:37:05 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

This is done by ASoC core now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l33.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 90dc743..622a111 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -365,7 +365,6 @@ static int cs35l33_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
 	unsigned int val;
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct cs35l33_private *priv = snd_soc_codec_get_drvdata(codec);
 
 	switch (level) {
@@ -392,8 +391,6 @@ static int cs35l33_set_bias_level(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	dapm->bias_level = level;
-
 	return 0;
 }
 
-- 
2.5.0
