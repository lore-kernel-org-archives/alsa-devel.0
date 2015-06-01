From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/47] ASoC: wm5110: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:28 +0200
Message-ID: <1433146266-1599-9-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 1729626056A
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:16 +0200 (CEST)
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

While we are at it also remove the duplicated initialization of
priv->core.arizona->dapm.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm5110.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fbaeddb..6796000 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1598,10 +1598,11 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	priv->core.arizona->dapm = &codec->dapm;
+	priv->core.arizona->dapm = dapm;
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
@@ -1611,9 +1612,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		return ret;
 
-	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
-
-	priv->core.arizona->dapm = &codec->dapm;
+	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
 	return 0;
 }
-- 
2.1.4
