From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/14] ASoC: wm9705: Use table based control
	setup
Date: Thu, 30 Oct 2014 21:01:04 +0100
Message-ID: <1414699271-22797-8-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E03F261518
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:19 +0100 (CET)
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
 sound/soc/codecs/wm9705.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 355b28d..1650195 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -347,9 +347,6 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto reset_err;
 
-	snd_soc_add_codec_controls(codec, wm9705_snd_ac97_controls,
-				ARRAY_SIZE(wm9705_snd_ac97_controls));
-
 	return 0;
 
 reset_err:
@@ -374,6 +371,9 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9705_reg,
+
+	.controls = wm9705_snd_ac97_controls,
+	.num_controls = ARRAY_SIZE(wm9705_snd_ac97_controls),
 	.dapm_widgets = wm9705_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm9705_dapm_widgets),
 	.dapm_routes = wm9705_audio_map,
-- 
1.8.0
