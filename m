From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: twl6040: Read the TRIM values from
	the chip
Date: Thu, 15 Sep 2011 15:45:15 +0300
Message-ID: <1316090718-30822-2-git-send-email-peter.ujfalusi@ti.com>
References: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BCE5103850
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:45:47 +0200 (CEST)
Received: by mail-bw0-f49.google.com with SMTP id t2so3644998bka.22
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:45:46 -0700 (PDT)
In-Reply-To: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
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

Update the reg_cache with values from chip regarding to TRIM.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 063defc..638954c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -279,9 +279,16 @@ static void twl6040_init_chip(struct snd_soc_codec *codec)
 	struct twl6040 *twl6040 = codec->control_data;
 	u8 val;
 
+	/* Update reg_cache: ASICREV, and TRIM values */
 	val = twl6040_get_revid(twl6040);
 	twl6040_write_reg_cache(codec, TWL6040_REG_ASICREV, val);
 
+	twl6040_read_reg_volatile(codec, TWL6040_REG_TRIM1);
+	twl6040_read_reg_volatile(codec, TWL6040_REG_TRIM2);
+	twl6040_read_reg_volatile(codec, TWL6040_REG_TRIM3);
+	twl6040_read_reg_volatile(codec, TWL6040_REG_HSOTRIM);
+	twl6040_read_reg_volatile(codec, TWL6040_REG_HFOTRIM);
+
 	/* Change chip defaults */
 	/* No imput selected for microphone amplifiers */
 	twl6040_write_reg_cache(codec, TWL6040_REG_MICLCTL, 0x18);
-- 
1.7.6.1
