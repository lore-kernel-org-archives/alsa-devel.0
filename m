From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/7] topology: ABI - Define new types for
	physical DAI
Date: Wed, 16 Nov 2016 14:42:25 +0800
Message-ID: <bec6886f01b2d8c05a1a66cdb4dc24295cbc80a9.1479277829.git.mengdong.lin@linux.intel.com>
References: <cover.1479277829.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4388B266C3D
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 07:40:39 +0100 (CET)
In-Reply-To: <cover.1479277829.git.mengdong.lin@linux.intel.com>
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

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Define the type and ABI struct for physical DAIs (e.g. backend DAIs).
They are new to ABI and so no backward compatibility risk.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index e14843b..1232f1e 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -102,7 +102,8 @@
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
 #define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
 #define SND_SOC_TPLG_TYPE_PDATA		11
-#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
+#define SND_SOC_TPLG_TYPE_DAI		12
+#define SND_SOC_TPLG_TYPE_MAX		SND_SOC_TPLG_TYPE_DAI
 
 /* vendor block IDs - please add new vendor types to end */
 #define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
@@ -121,6 +122,11 @@
 #define SND_SOC_TPLG_TUPLE_TYPE_WORD	4
 #define SND_SOC_TPLG_TUPLE_TYPE_SHORT	5
 
+/* DAI flags */
+#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES         (1 << 0)
+#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
+#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -510,4 +516,27 @@ struct snd_soc_tplg_link_config {
 	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
+
+/*
+ * Describes SW/FW specific features of physical DAI.
+ * It can be used to configure backend DAIs for DPCM.
+ *
+ * File block representation for physical DAI :-
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_hdr           |  1  |
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_dai           |  N  |
+ * +-----------------------------------+-----+
+ */
+struct snd_soc_tplg_dai {
+	__le32 size;            /* in bytes of this structure */
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* name - used to match */
+	__le32 dai_id;          /* unique ID - used to match */
+	__le32 playback;        /* supports playback mode */
+	__le32 capture;         /* supports capture mode */
+	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
+	__le32 flag_mask;       /* bitmask of flags to configure */
+	__le32 flags;           /* SND_SOC_TPLG_DAI_FLGBIT_* */
+	struct snd_soc_tplg_private priv;
+} __attribute__((packed));
 #endif
-- 
2.5.0
