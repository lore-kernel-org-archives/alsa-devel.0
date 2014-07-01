From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 2/3] ASoC: wm8350: Remove unused variable
Date: Tue,  1 Jul 2014 09:59:32 +0530
Message-ID: <1404188973-1857-2-git-send-email-sachin.kamat@samsung.com>
References: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 23C012625D7
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 06:33:08 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id kq14so9836655pab.6
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 21:33:07 -0700 (PDT)
In-Reply-To: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

'irq' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/wm8350.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 392285edb595..d9e634c55e81 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1341,21 +1341,18 @@ int wm8350_hp_jack_detect(struct snd_soc_codec *codec, enum wm8350_jack which,
 {
 	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
 	struct wm8350 *wm8350 = priv->wm8350;
-	int irq;
 	int ena;
 
 	switch (which) {
 	case WM8350_JDL:
 		priv->hpl.jack = jack;
 		priv->hpl.report = report;
-		irq = WM8350_IRQ_CODEC_JCK_DET_L;
 		ena = WM8350_JDL_ENA;
 		break;
 
 	case WM8350_JDR:
 		priv->hpr.jack = jack;
 		priv->hpr.report = report;
-		irq = WM8350_IRQ_CODEC_JCK_DET_R;
 		ena = WM8350_JDR_ENA;
 		break;
 
-- 
1.7.9.5
