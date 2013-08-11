From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: cs4271: Convert to table based
	control init
Date: Sun, 11 Aug 2013 13:16:16 +0100
Message-ID: <1376223377-23047-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 41C14264FEB
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 14:16:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/cs4271.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 03036b3..65ad56c 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -576,8 +576,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 				   CS4271_MODE2_MUTECAEQUB,
 				   CS4271_MODE2_MUTECAEQUB);
 
-	return snd_soc_add_codec_controls(codec, cs4271_snd_controls,
-		ARRAY_SIZE(cs4271_snd_controls));
+	return 0;
 }
 
 static int cs4271_remove(struct snd_soc_codec *codec)
@@ -596,6 +595,9 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
 	.remove			= cs4271_remove,
 	.suspend		= cs4271_soc_suspend,
 	.resume			= cs4271_soc_resume,
+
+	.controls		= cs4271_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs4271_snd_controls),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.8.4.rc1
