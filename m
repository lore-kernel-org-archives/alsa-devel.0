From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 2/5] ASoC: sn95031: fix the DMIC path routing
Date: Tue, 15 Feb 2011 18:28:52 +0530
Message-ID: <1297774735-32184-3-git-send-email-vinod.koul@intel.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC40103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:50:08 +0100 (CET)
In-Reply-To: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch makes the DMIC dynamically connect to TX Mux, earlier code had
erroneously made this as static path

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |   48 ++++++++++++++++++++++----------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 9c3db0d..5eb39c7 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -602,30 +602,30 @@ static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	{ "Txpath2 Capture Route", "ADC Right", "ADC Right"},
 	{ "Txpath3 Capture Route", "ADC Right", "ADC Right"},
 	{ "Txpath4 Capture Route", "ADC Right", "ADC Right"},
-	{ "Txpath1 Capture Route", NULL, "DMIC1"},
-	{ "Txpath2 Capture Route", NULL, "DMIC1"},
-	{ "Txpath3 Capture Route", NULL, "DMIC1"},
-	{ "Txpath4 Capture Route", NULL, "DMIC1"},
-	{ "Txpath1 Capture Route", NULL, "DMIC2"},
-	{ "Txpath2 Capture Route", NULL, "DMIC2"},
-	{ "Txpath3 Capture Route", NULL, "DMIC2"},
-	{ "Txpath4 Capture Route", NULL, "DMIC2"},
-	{ "Txpath1 Capture Route", NULL, "DMIC3"},
-	{ "Txpath2 Capture Route", NULL, "DMIC3"},
-	{ "Txpath3 Capture Route", NULL, "DMIC3"},
-	{ "Txpath4 Capture Route", NULL, "DMIC3"},
-	{ "Txpath1 Capture Route", NULL, "DMIC4"},
-	{ "Txpath2 Capture Route", NULL, "DMIC4"},
-	{ "Txpath3 Capture Route", NULL, "DMIC4"},
-	{ "Txpath4 Capture Route", NULL, "DMIC4"},
-	{ "Txpath1 Capture Route", NULL, "DMIC5"},
-	{ "Txpath2 Capture Route", NULL, "DMIC5"},
-	{ "Txpath3 Capture Route", NULL, "DMIC5"},
-	{ "Txpath4 Capture Route", NULL, "DMIC5"},
-	{ "Txpath1 Capture Route", NULL, "DMIC6"},
-	{ "Txpath2 Capture Route", NULL, "DMIC6"},
-	{ "Txpath3 Capture Route", NULL, "DMIC6"},
-	{ "Txpath4 Capture Route", NULL, "DMIC6"},
+	{ "Txpath1 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath2 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath3 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath4 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath1 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath2 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath3 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath4 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath1 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath2 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath3 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath4 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath1 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath2 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath3 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath4 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath1 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath2 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath3 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath4 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath1 Capture Route", "DMIC6", "DMIC6"},
+	{ "Txpath2 Capture Route", "DMIC6", "DMIC6"},
+	{ "Txpath3 Capture Route", "DMIC6", "DMIC6"},
+	{ "Txpath4 Capture Route", "DMIC6", "DMIC6"},
 
 	/* tx path */
 	{ "TX1 Enable", NULL, "Txpath1 Capture Route"},
-- 
1.7.2.3
