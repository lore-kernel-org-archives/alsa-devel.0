From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/4] ASoC: twl6040: correct loop counters
	for HS/HF ramp code
Date: Thu, 29 Sep 2011 15:22:35 +0300
Message-ID: <1317298957-30366-3-git-send-email-peter.ujfalusi@ti.com>
References: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 00B02244F4
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 14:22:45 +0200 (CEST)
Received: by mail-bw0-f46.google.com with SMTP id zt4so738487bkb.33
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 05:22:44 -0700 (PDT)
In-Reply-To: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
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

The Headset gain range is 0 - 0xf (4 bit resolution)
The Handsfree gain range is 0 - 0x1d (5 bit resolution,
0x1e, and 0x1f values are invalid)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 91242de..4aa7d69 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -495,8 +495,8 @@ static void twl6040_pga_hs_work(struct work_struct *work)
 	if (headset->ramp == TWL6040_RAMP_NONE)
 		return;
 
-	/* HS PGA volumes have 4 bits of resolution to ramp */
-	for (i = 0; i <= 16; i++) {
+	/* HS PGA gain range: 0x0 - 0xf (0 - 15) */
+	for (i = 0; i < 16; i++) {
 		headset_complete = twl6040_hs_ramp_step(codec,
 						headset->left_step,
 						headset->right_step);
@@ -530,8 +530,9 @@ static void twl6040_pga_hf_work(struct work_struct *work)
 	if (handsfree->ramp == TWL6040_RAMP_NONE)
 		return;
 
-	/* HF PGA volumes have 5 bits of resolution to ramp */
-	for (i = 0; i <= 32; i++) {
+	/*
+	 * HF PGA gain range: 0x00 - 0x1d (0 - 29) */
+	for (i = 0; i < 30; i++) {
 		handsfree_complete = twl6040_hf_ramp_step(codec,
 						handsfree->left_step,
 						handsfree->right_step);
-- 
1.7.6.1
