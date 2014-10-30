From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/14] ASoC: stac9766: Use table based control
	setup
Date: Thu, 30 Oct 2014 21:01:02 +0100
Message-ID: <1414699271-22797-6-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A1F5260824
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:18 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/stac9766.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index e88d9ac..6c62d29 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -342,9 +342,6 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 		goto codec_err;
 	}
 
-	snd_soc_add_codec_controls(codec, stac9766_snd_ac97_controls,
-			     ARRAY_SIZE(stac9766_snd_ac97_controls));
-
 	return 0;
 
 codec_err:
@@ -359,6 +356,8 @@ static int stac9766_codec_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
+	.controls = stac9766_snd_ac97_controls,
+	.num_controls = ARRAY_SIZE(stac9766_snd_ac97_controls),
 	.write = stac9766_ac97_write,
 	.read = stac9766_ac97_read,
 	.set_bias_level = stac9766_set_bias_level,
-- 
1.8.0
