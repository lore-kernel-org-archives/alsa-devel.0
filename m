From: Ryo Kodama <ryo.kodama.vz@renesas.com>
Subject: [PATCH] ASoC: ak4613: Improve counting DAI number
Date: Wed, 7 Jun 2017 14:39:00 +0900
Message-ID: <1496813940-6053-1-git-send-email-ryo.kodama.vz@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com
 [210.160.252.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 68AA826681D
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 07:42:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>
List-Id: alsa-devel@alsa-project.org

Add the startup function to count DAI instead of hw_params.
This change matches the number of opened DAIs.
If this change isn't applied, you may get unexpected error due to
mismatching of count. Since the excution number of hw_params and
shutdown may be different, the mismatching happens.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
---
 sound/soc/codecs/ak4613.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 9d2be7c..512a1e7 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -254,6 +254,17 @@ static void ak4613_dai_shutdown(struct snd_pcm_substream *substream,
 	mutex_unlock(&priv->lock);
 }
 
+static int ak4613_dai_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->cnt++;
+
+	return 0;
+}
+
 static int ak4613_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -358,7 +369,6 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	if ((priv->iface == NULL) ||
 	    (priv->iface == iface)) {
 		priv->iface = iface;
-		priv->cnt++;
 		ret = 0;
 	}
 	mutex_unlock(&priv->lock);
@@ -407,6 +417,7 @@ static int ak4613_set_bias_level(struct snd_soc_codec *codec,
 }
 
 static const struct snd_soc_dai_ops ak4613_dai_ops = {
+	.startup	= ak4613_dai_startup,
 	.shutdown	= ak4613_dai_shutdown,
 	.set_fmt	= ak4613_dai_set_fmt,
 	.hw_params	= ak4613_dai_hw_params,
-- 
1.9.1
