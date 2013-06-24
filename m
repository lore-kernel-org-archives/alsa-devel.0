From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: twl6040: Drop using
	devm_request_threaded_irq()
Date: Mon, 24 Jun 2013 15:42:03 +0200
Message-ID: <1372081326-6917-2-git-send-email-peter.ujfalusi@ti.com>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E1A26501A
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 15:42:11 +0200 (CEST)
In-Reply-To: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

We need to free the irq at twl6040_remove() which is called when the machine
driver has been removed (the card has been removed).
If we fail to do that, next time when the machine driver is loaded the
codec's probe will fail since the irq has been already requested.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9b9a6e5..c2f2fdb 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1143,7 +1143,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 	mutex_init(&priv->mutex);
 
-	ret = devm_request_threaded_irq(codec->dev, priv->plug_irq, NULL,
+	ret = request_threaded_irq(priv->plug_irq, NULL,
 					twl6040_audio_handler, IRQF_NO_SUSPEND,
 					"twl6040_irq_plug", codec);
 	if (ret) {
@@ -1159,6 +1159,9 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 static int twl6040_remove(struct snd_soc_codec *codec)
 {
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+
+	free_irq(priv->plug_irq, codec);
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
-- 
1.8.2.1
