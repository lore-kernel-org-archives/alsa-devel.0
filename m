From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/17] ASoC: twl6040: Use chip defaults in the
	initial reg_cache
Date: Thu, 15 Sep 2011 15:39:28 +0300
Message-ID: <1316090379-30760-7-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 624CF103B89
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:26 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id zs8so4241332bkb.27
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:25 -0700 (PDT)
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

Reset the twl6040_reg array to hold the chip default values.
The only changed values were for the microphone input selection.
Select no input for the microphones in the twl6040_init_chip function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 8bbd46a..987d9c9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -118,8 +118,8 @@ static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
 	0x4A, /* TWL6040_LPPLLDIV	0x09	*/
 	0x00, /* TWL6040_AMICBCTL	0x0A	*/
 	0x00, /* TWL6040_DMICBCTL	0x0B	*/
-	0x18, /* TWL6040_MICLCTL	0x0C	- No input selected on Left Mic */
-	0x18, /* TWL6040_MICRCTL	0x0D	- No input selected on Right Mic */
+	0x00, /* TWL6040_MICLCTL	0x0C	*/
+	0x00, /* TWL6040_MICRCTL	0x0D	*/
 	0x00, /* TWL6040_MICGAIN	0x0E	*/
 	0x1B, /* TWL6040_LINEGAIN	0x0F	*/
 	0x00, /* TWL6040_HSLCTL		0x10	*/
@@ -265,6 +265,10 @@ static void twl6040_init_chip(struct snd_soc_codec *codec)
 	val = twl6040_get_revid(twl6040);
 	twl6040_write_reg_cache(codec, TWL6040_REG_ASICREV, val);
 
+	/* Change chip defaults */
+	/* No imput selected for microphone amplifiers */
+	twl6040_write_reg_cache(codec, TWL6040_REG_MICLCTL, 0x18);
+	twl6040_write_reg_cache(codec, TWL6040_REG_MICRCTL, 0x18);
 }
 
 static void twl6040_restore_regs(struct snd_soc_codec *codec)
-- 
1.7.6.1
