From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 06/11] ASoC: topology: ABI - Define DAI
	physical PCM data formats
Date: Fri,  9 Sep 2016 19:46:13 +0800
Message-ID: <cf3caa969a0294d57d9f9e7697cbdfd49c999dc4.1473420558.git.mengdong.lin@linux.intel.com>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D96726646C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2016 13:40:04 +0200 (CEST)
In-Reply-To: <cover.1473420558.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Define DAI physical PCM data formats for user space, so users can specify
the formats of backends by topology (e.g. the DAI format to set on backend
link init).

The kernel will also refer to these formats.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..534aae2 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -15,6 +15,7 @@
 
 
 #include <linux/list.h>
+#include <sound/asoc.h>
 
 struct snd_pcm_substream;
 struct snd_soc_dapm_widget;
@@ -26,13 +27,13 @@ struct snd_compr_stream;
  * Describes the physical PCM data formating and clocking. Add new formats
  * to the end.
  */
-#define SND_SOC_DAIFMT_I2S		1 /* I2S mode */
-#define SND_SOC_DAIFMT_RIGHT_J		2 /* Right Justified mode */
-#define SND_SOC_DAIFMT_LEFT_J		3 /* Left Justified mode */
-#define SND_SOC_DAIFMT_DSP_A		4 /* L data MSB after FRM LRC */
-#define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
-#define SND_SOC_DAIFMT_AC97		6 /* AC97 */
-#define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
+#define SND_SOC_DAIFMT_I2S		SND_SOC_DAI_FORMAT_I2S
+#define SND_SOC_DAIFMT_RIGHT_J		SND_SOC_DAI_FORMAT_RIGHT_J
+#define SND_SOC_DAIFMT_LEFT_J		SND_SOC_DAI_FORMAT_LEFT_J
+#define SND_SOC_DAIFMT_DSP_A		SND_SOC_DAI_FORMAT_DSP_A
+#define SND_SOC_DAIFMT_DSP_B		SND_SOC_DAI_FORMAT_DSP_B
+#define SND_SOC_DAIFMT_AC97		SND_SOC_DAI_FORMAT_AC97
+#define SND_SOC_DAIFMT_PDM		SND_SOC_DAI_FORMAT_PDM
 
 /* left and right justified also known as MSB and LSB respectively */
 #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 1d4c3b9..3256dd4 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -137,6 +137,21 @@
 #define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 0)
 #define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 << 1)
 
+/* DAI physical PCM data formats.
+ * Add new formats to the end of the list.
+ */
+#define SND_SOC_DAI_FORMAT_I2S          1 /* I2S mode */
+#define SND_SOC_DAI_FORMAT_RIGHT_J      2 /* Right Justified mode */
+#define SND_SOC_DAI_FORMAT_LEFT_J       3 /* Left Justified mode */
+#define SND_SOC_DAI_FORMAT_DSP_A        4 /* L data MSB after FRM LRC */
+#define SND_SOC_DAI_FORMAT_DSP_B        5 /* L data MSB during FRM LRC */
+#define SND_SOC_DAI_FORMAT_AC97         6 /* AC97 */
+#define SND_SOC_DAI_FORMAT_PDM          7 /* Pulse density modulation */
+
+/* left and right justified also known as MSB and LSB respectively */
+#define SND_SOC_DAI_FORMAT_MSB          SND_SOC_DAI_FORMAT_LEFT_J
+#define SND_SOC_DAI_FORMAT_LSB          SND_SOC_DAI_FORMAT_RIGHT_J
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
-- 
2.5.0
