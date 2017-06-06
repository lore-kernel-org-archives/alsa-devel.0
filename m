From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/3] topology: Add support for new widget types
Date: Tue,  6 Jun 2017 15:42:56 +0100
Message-ID: <1496760178-6028-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 67F5F2664EB
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 16:43:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add topology support for new DSP widget types. This allows the new
widgets to be added to the driver and firmware DAPM graphs.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/asoc.h | 9 ++++++++-
 src/topology/dapm.c  | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 082c5429..14ba30ff 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -70,7 +70,14 @@
 #define SND_SOC_TPLG_DAPM_DAI_IN	13
 #define SND_SOC_TPLG_DAPM_DAI_OUT	14
 #define SND_SOC_TPLG_DAPM_DAI_LINK	15
-#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DAI_LINK
+#define SND_SOC_TPLG_DAPM_BUFFER	16
+#define SND_SOC_TPLG_DAPM_PIPELINE	17
+#define SND_SOC_TPLG_DAPM_EFFECT	18
+#define SND_SOC_TPLG_DAPM_SIGGEN	19
+#define SND_SOC_TPLG_DAPM_SRC		20
+#define SND_SOC_TPLG_DAPM_ASRC		21
+#define SND_SOC_TPLG_DAPM_CODEC		22
+#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_CODEC
 
 /* Header magic number and string sizes */
 #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 6af750b9..23908821 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -38,6 +38,13 @@ static const struct map_elem widget_map[] = {
 	{"dai_in", SND_SOC_TPLG_DAPM_DAI_IN},
 	{"dai_out", SND_SOC_TPLG_DAPM_DAI_OUT},
 	{"dai_link", SND_SOC_TPLG_DAPM_DAI_LINK},
+	{"buffer", SND_SOC_TPLG_DAPM_BUFFER},
+	{"pipeline", SND_SOC_TPLG_DAPM_PIPELINE},
+	{"effect", SND_SOC_TPLG_DAPM_EFFECT},
+	{"siggen", SND_SOC_TPLG_DAPM_SIGGEN},
+	{"src", SND_SOC_TPLG_DAPM_SRC},
+	{"asrc", SND_SOC_TPLG_DAPM_ASRC},
+	{"codec", SND_SOC_TPLG_DAPM_CODEC},
 };
 
 static int lookup_widget(const char *w)
-- 
2.11.0
