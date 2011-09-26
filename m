From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend 1/4] ASoC: twl6040: Read the TRIM values
	from the chip
Date: Mon, 26 Sep 2011 16:05:56 +0300
Message-ID: <1317042359-27127-2-git-send-email-peter.ujfalusi@ti.com>
References: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 53EFA24394
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:06:22 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id 5so8045944bke.11
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:06:20 -0700 (PDT)
In-Reply-To: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
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
index dabf37b..26c06ff 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -278,9 +278,16 @@ static void twl6040_init_chip(struct snd_soc_codec *codec)
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
