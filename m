From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Remove unnecessary debugging
	info
Date: Wed,  3 Nov 2010 16:50:36 +0000
Message-ID: <1288803036-26982-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA4E724436
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 17:50:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

No need to print the register-value pair again, as we've already hooked
snd_soc_write() for that matter.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d214f02..8785a0c 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -50,8 +50,6 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 		return 0;
 	}
 
-	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
-
 	ret = codec->hw_write(codec->control_data, data, 2);
 	if (ret == 2)
 		return 0;
@@ -126,8 +124,6 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 		return 0;
 	}
 
-	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
-
 	ret = codec->hw_write(codec->control_data, data, 2);
 	if (ret == 2)
 		return 0;
@@ -186,8 +182,6 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 		return 0;
 	}
 
-	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
-
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
@@ -260,8 +254,6 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 		return 0;
 	}
 
-	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
-
 	if (codec->hw_write(codec->control_data, data, 3) == 3)
 		return 0;
 	else
@@ -455,8 +447,6 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 		return 0;
 	}
 
-	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
-
 	ret = codec->hw_write(codec->control_data, data, 3);
 	if (ret == 3)
 		return 0;
@@ -568,8 +558,6 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 		return 0;
 	}
 
-	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
-
 	ret = codec->hw_write(codec->control_data, data, 4);
 	if (ret == 4)
 		return 0;
-- 
1.7.3.2
