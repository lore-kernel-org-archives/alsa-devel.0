From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/10] ASoC: core: Change
	SOC_SINGLE/DOUBLE_VALUE representation
Date: Wed,  5 Oct 2011 10:29:22 +0300
Message-ID: <1317799768-15683-5-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 05AB0103A02
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:47 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so1834491bkb.12
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:46 -0700 (PDT)
In-Reply-To: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SOC_SINGLE/DOUBLE_VALUE is used for mixer controls, where the
bits are within one register.

Assign .rreg to be the same as .reg for these types.

With this change we can tell if the mixer in question:
is mono:
mc->reg == mc->rreg && mc->shift == mc->rshift

is stereo, within single register:
mc->reg == mc->rreg && mc->shift != mc->rshift

is stereo, in two registers:
mc->reg != mc->rreg

The patch provide a small inline function to query, if the mixer
is stereo, or mono.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9d0524a..9753cbe 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -30,8 +30,9 @@
  */
 #define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-	.max = xmax, .platform_max = xmax, .invert = xinvert})
+	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
+	.rshift = shift_right, .max = xmax, .platform_max = xmax, \
+	.invert = xinvert})
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
 	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert)
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
@@ -946,6 +947,18 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->dapm_list);
 }
 
+static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
+{
+	if (mc->reg == mc->rreg && mc->shift == mc->rshift)
+		return 0;
+	/*
+	 * mc->reg == mc->rreg && mc->shift != mc->rshift, or
+	 * mc->reg != mc->rreg means that the control is
+	 * stereo (bits in one register or in two registers)
+	 */
+	return 1;
+}
+
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
-- 
1.7.7
