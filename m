From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/10] ASoC: twl6040: correct loop counters for
	HS/HF ramp code
Date: Mon, 26 Sep 2011 16:26:29 +0300
Message-ID: <1317043593-27202-7-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id C2FB7243C7
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:55 +0200 (CEST)
Received: by gyg8 with SMTP id 8so4600056gyg.20
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:54 -0700 (PDT)
In-Reply-To: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
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

4 bit resolution means 16 steps -> for loop till >=15 (HS)
5 bit resolution means 32 steps -> for loop till >=31 (HF)

In case of the Handsfree we have 0x1e, 0x1f as invalid values.
In case of HF we can limit the loop for 0x1d (29).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 156ebf7..5a33fe1 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -497,7 +497,7 @@ static void twl6040_pga_hs_work(struct work_struct *work)
 		return;
 
 	/* HS PGA volumes have 4 bits of resolution to ramp */
-	for (i = 0; i <= 16; i++) {
+	for (i = 0; i <= 15; i++) {
 		headset_complete = twl6040_hs_ramp_step(codec,
 						headset->left_step,
 						headset->right_step);
@@ -539,8 +539,11 @@ static void twl6040_pga_hf_work(struct work_struct *work)
 	if (handsfree->ramp == TWL6040_RAMP_NONE)
 		return;
 
-	/* HF PGA volumes have 5 bits of resolution to ramp */
-	for (i = 0; i <= 32; i++) {
+	/*
+	 * HF PGA volumes have 5 bits of resolution to ramp, but 0x1e, 0x1f are
+	 * invalid values, loop till 0x1d
+	 */
+	for (i = 0; i <= 29; i++) {
 		handsfree_complete = twl6040_hf_ramp_step(codec,
 						handsfree->left_step,
 						handsfree->right_step);
-- 
1.7.6.1
