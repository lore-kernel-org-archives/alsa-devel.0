From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/47] ASoC: wm5102: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:27 +0200
Message-ID: <1433146266-1599-8-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id B03A3260525
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:15 +0200 (CEST)
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
 sound/soc/codecs/wm5102.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 0c6d1bc..f11523f 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1827,6 +1827,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 
 static int wm5102_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -1837,9 +1838,9 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
 
-	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
+	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
-	priv->core.arizona->dapm = &codec->dapm;
+	priv->core.arizona->dapm = dapm;
 
 	return 0;
 }
-- 
2.1.4
