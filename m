From: mengdong.lin@linux.intel.com
Subject: [PATCH 04/13] topology: ABI - Define DAI physical PCM
	data formats
Date: Sun,  6 Nov 2016 13:12:57 +0800
Message-ID: <5559750bbfc427ccce88183623c36f331fe02e75.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D3726648B
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:11:28 +0100 (CET)
In-Reply-To: <cover.1478407716.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Define DAI physical PCM data formats for user space, so users can specify
the formats of backends by topology (e.g. the DAI format to set on backend
link init).

The kernel will also refer to these formats.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 1f2c230..d55ce8c 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -115,6 +115,21 @@
 #define SND_SOC_TPLG_TUPLE_TYPE_WORD	4
 #define SND_SOC_TPLG_TUPLE_TYPE_SHORT	5
 
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
 /* DAI link flags */
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES         (1 << 0)
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
-- 
2.7.4
