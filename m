From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/47] ASoC: cs42xx8: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:23 +0200
Message-ID: <1433146266-1599-4-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 43FFD2604F4
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:13 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to codec->dapm
with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs42xx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 670ebfe..e1d4686 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -380,7 +380,7 @@ EXPORT_SYMBOL_GPL(cs42xx8_regmap_config);
 static int cs42xx8_codec_probe(struct snd_soc_codec *codec)
 {
 	struct cs42xx8_priv *cs42xx8 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	switch (cs42xx8->drvdata->num_adcs) {
 	case 3:
-- 
2.1.4
