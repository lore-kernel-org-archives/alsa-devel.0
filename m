From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/17] ASoC: twl6040: Lower the initial gains
Date: Thu, 15 Sep 2011 15:39:29 +0300
Message-ID: <1316090379-30760-8-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 89FC1103BA1
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:30 +0200 (CEST)
Received: by bkbzv15 with SMTP id zv15so2710006bkb.4
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:27 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The default gains on outputs/inputs are set to 0dB.
To be able to handle pop noise better, we need to lower
the gains on controls, where it is possible.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 987d9c9..1f6068b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -269,6 +269,13 @@ static void twl6040_init_chip(struct snd_soc_codec *codec)
 	/* No imput selected for microphone amplifiers */
 	twl6040_write_reg_cache(codec, TWL6040_REG_MICLCTL, 0x18);
 	twl6040_write_reg_cache(codec, TWL6040_REG_MICRCTL, 0x18);
+
+	/* Lower the gains */
+	twl6040_write_reg_cache(codec, TWL6040_REG_HSGAIN, 0xff);
+	twl6040_write_reg_cache(codec, TWL6040_REG_EARCTL, 0x1e);
+	twl6040_write_reg_cache(codec, TWL6040_REG_HFLGAIN, 0x1d);
+	twl6040_write_reg_cache(codec, TWL6040_REG_HFRGAIN, 0x1d);
+	twl6040_write_reg_cache(codec, TWL6040_REG_LINEGAIN, 0);
 }
 
 static void twl6040_restore_regs(struct snd_soc_codec *codec)
-- 
1.7.6.1
