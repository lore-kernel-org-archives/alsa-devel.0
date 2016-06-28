From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: Remove setting
	dapm->bias_level in cs35l33_set_bias_level" to the asoc tree
Date: Tue, 28 Jun 2016 20:56:20 +0100
Message-ID: <E1bHz7M-0005Xg-TX@debutante>
References: <1467110219.1638.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4EEA2673A7
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 21:56:31 +0200 (CEST)
In-Reply-To: <1467110219.1638.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l33: Remove setting dapm->bias_level in cs35l33_set_bias_level

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 262329fccad4914dbf4b49634cbe140dfb353c25 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 28 Jun 2016 18:36:59 +0800
Subject: [PATCH] ASoC: cs35l33: Remove setting dapm->bias_level in
 cs35l33_set_bias_level

This is done by ASoC core now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 90dc743a8378..622a1111b21c 100644
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
2.8.1
