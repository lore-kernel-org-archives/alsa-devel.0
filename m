From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Hook up DC servo completion IRQ for
	WM8994 and WM8958
Date: Tue, 12 Jul 2011 16:59:19 +0900
Message-ID: <1310457559-30789-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1310457559-30789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D9AB24474
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 09:59:34 +0200 (CEST)
In-Reply-To: <1310457559-30789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e90ae9d..c49e698 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2972,6 +2972,12 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
+	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
+				 wm_hubs_dcs_done, "DC servo done",
+				 &wm8994->hubs);
+	if (ret == 0)
+		wm8994->hubs.dcs_done_irq = true;
+
 	switch (control->type) {
 	case WM8994:
 		if (wm8994->micdet_irq) {
@@ -3243,6 +3249,8 @@ err_irq:
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT, wm8994);
 	if (wm8994->micdet_irq)
 		free_irq(wm8994->micdet_irq, wm8994);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
+			&wm8994->hubs);
 err:
 	kfree(wm8994);
 	return ret;
@@ -3257,6 +3265,9 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 
 	pm_runtime_disable(codec->dev);
 
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
+			&wm8994->hubs);
+
 	switch (control->type) {
 	case WM8994:
 		if (wm8994->micdet_irq)
-- 
1.7.5.4
