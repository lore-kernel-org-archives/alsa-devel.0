From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 24/29] ASoC: wm8997: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:30 +0100
Message-ID: <1421141255-21477-24-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 97E58261A5F
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:28:09 +0100 (CET)
In-Reply-To: <1421141255-21477-1-git-send-email-lars@metafoo.de>
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

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 7e8bfe2..0760ede 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -84,7 +84,7 @@ static const struct reg_default wm8997_sysclk_reva_patch[] = {
 static int wm8997_sysclk_ev(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 	struct regmap *regmap = arizona->regmap;
 	const struct reg_default *patch = NULL;
-- 
1.8.0
