From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH] ASoC: dwc: debug message correction.
Date: Tue, 11 Jun 2013 09:29:07 +0530
Message-ID: <1370923148-19398-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
 [207.126.144.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D9033261A15
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 05:59:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, Rajeev Kumar <rajeevk-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

From: Rajeev Kumar <rajeevk-dlh.kumar@st.com>

Debug message correction.

Signed-off-by: Rajeev Kumar <rajeevk-dlh.kumar@st.com>
---
 sound/soc/dwc/designware_i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index deb30d5..deb975e 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -392,7 +392,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (cap & DWC_I2S_PLAY) {
-		dev_dbg(&pdev->dev, " SPEAr: play supported\n");
+		dev_dbg(&pdev->dev, " designware: play supported\n");
 		dw_i2s_dai->playback.channels_min = MIN_CHANNEL_NUM;
 		dw_i2s_dai->playback.channels_max = pdata->channel;
 		dw_i2s_dai->playback.formats = pdata->snd_fmts;
@@ -400,7 +400,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (cap & DWC_I2S_RECORD) {
-		dev_dbg(&pdev->dev, "SPEAr: record supported\n");
+		dev_dbg(&pdev->dev, "designware: record supported\n");
 		dw_i2s_dai->capture.channels_min = MIN_CHANNEL_NUM;
 		dw_i2s_dai->capture.channels_max = pdata->channel;
 		dw_i2s_dai->capture.formats = pdata->snd_fmts;
-- 
1.6.0.2
