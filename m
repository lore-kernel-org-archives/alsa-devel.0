From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 01/10] ASoC: twl6040: Lower the power on
	gain values at startup
Date: Thu, 22 Sep 2011 11:05:45 +0300
Message-ID: <1316678754-11935-2-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 138FF103B08
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:31 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so2937968bkb.32
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:18 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The default gains on outputs/inputs are set to 0dB.
This is fixing the pop noise issue at the first playback, which
caused by the wrong starting point of the ramp code.
The ramp code for the outputs expects the gains to be in
their lowest configuration in order to be effective.
After the playback stops, the ramp code takes care of
ramping down the gains to their minimum.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 81645c6..0694d65 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -269,6 +269,17 @@ static void twl6040_init_chip(struct snd_soc_codec *codec)
 	/* No imput selected for microphone amplifiers */
 	twl6040_write_reg_cache(codec, TWL6040_REG_MICLCTL, 0x18);
 	twl6040_write_reg_cache(codec, TWL6040_REG_MICRCTL, 0x18);
+
+	/*
+	 * We need to lower the default gain values, so the ramp code
+	 * can work correctly for the first playback.
+	 * This reduces the pop noise heard at the first playback.
+	 */
+	twl6040_write_reg_cache(codec, TWL6040_REG_HSGAIN, 0xff);
+	twl6040_write_reg_cache(codec, TWL6040_REG_EARCTL, 0x1e);
+	twl6040_write_reg_cache(codec, TWL6040_REG_HFLGAIN, 0x1d);
+	twl6040_write_reg_cache(codec, TWL6040_REG_HFRGAIN, 0x1d);
+	twl6040_write_reg_cache(codec, TWL6040_REG_LINEGAIN, 0);
 }
 
 static void twl6040_restore_regs(struct snd_soc_codec *codec)
-- 
1.7.6.1
