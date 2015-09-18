From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 3/4] ASoC: si476x: add startup/shutdown to
	powerup/down si476x
Date: Fri, 18 Sep 2015 17:19:34 +0800
Message-ID: <e1e497aaec3c4549f355cad93fb1bf6bc01c0eef.1442566367.git.zidan.wang@freescale.com>
References: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0134.outbound.protection.outlook.com [157.56.110.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 04E1C265B79
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:17:53 +0200 (CEST)
In-Reply-To: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

si476x should be powered up to read/write register, so powerup/down
si476x in startup/shutdown.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/si476x.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index a8402d0..d61a79f 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -208,7 +208,26 @@ out:
 	return err;
 }
 
+static int si476x_codec_startup(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai) {
+	struct si476x_core *core = i2c_mfd_cell_to_core(dai->dev);
+
+	if (!si476x_core_is_powered_up(core))
+		si476x_core_set_power_state(core, SI476X_POWER_UP_FULL);
+	return 0;
+}
+
+static void si476x_codec_shutdown(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai) {
+	struct si476x_core *core = i2c_mfd_cell_to_core(dai->dev);
+
+	if (si476x_core_is_powered_up(core))
+		si476x_core_set_power_state(core, SI476X_POWER_DOWN);
+}
+
 static const struct snd_soc_dai_ops si476x_dai_ops = {
+	.startup        = si476x_codec_startup,
+	.shutdown       = si476x_codec_shutdown,
 	.hw_params	= si476x_codec_hw_params,
 	.set_fmt	= si476x_codec_set_dai_fmt,
 };
-- 
1.9.1
