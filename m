From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/4] ASoC: twl6040: Shift 2 identifies the
	HS output in out_drv_event
Date: Wed, 28 Sep 2011 14:16:32 +0300
Message-ID: <1317208593-21142-4-git-send-email-peter.ujfalusi@ti.com>
References: <1317208593-21142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F885103892
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 13:17:10 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id zs8so13315770bkb.27
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2011 04:17:09 -0700 (PDT)
In-Reply-To: <1317208593-21142-1-git-send-email-peter.ujfalusi@ti.com>
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

None of the driver handled by out_drv_event have it's power
bit shifted by 3.
Remove the case for shift 3, and also add comment for the cases.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4aa7d69..c2b5829 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -563,14 +563,13 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 	struct delayed_work *work;
 
 	switch (w->shift) {
-	case 2:
-	case 3:
+	case 2: /* Headset output driver */
 		out = &priv->headset;
 		out->left_step = priv->hs_left_step;
 		out->right_step = priv->hs_right_step;
 		out->step_delay = 5;	/* 5 ms between volume ramp steps */
 		break;
-	case 4:
+	case 4: /* Handsfree output driver */
 		out = &priv->handsfree;
 		out->left_step = priv->hf_left_step;
 		out->right_step = priv->hf_right_step;
-- 
1.7.6.1
