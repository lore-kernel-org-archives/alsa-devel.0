From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/5] ASoC: twl6040: Convert PLUGINT to
	no-suspend irq
Date: Fri, 11 Jan 2013 17:00:59 +0100
Message-ID: <1357920063-15141-2-git-send-email-peter.ujfalusi@ti.com>
References: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 39822264FFB
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:09 +0100 (CET)
In-Reply-To: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Convert headset PLUGINT interrupt to NO_SUSPEND type in order to
allow handling of insertion/removal events while device is suspended.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 3fc3fc6..ef31ace 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1174,7 +1174,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	mutex_init(&priv->mutex);
 
 	ret = request_threaded_irq(priv->plug_irq, NULL, twl6040_audio_handler,
-				   0, "twl6040_irq_plug", codec);
+				   IRQF_NO_SUSPEND, "twl6040_irq_plug", codec);
 	if (ret) {
 		dev_err(codec->dev, "PLUG IRQ request failed: %d\n", ret);
 		goto plugirq_err;
-- 
1.8.1
