From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/5] topology: ABI - Add the types for BE DAI
Date: Mon,  3 Oct 2016 23:03:50 +0800
Message-ID: <943bbdf62e4d0d3f297fa59b9804236c82778185.1475505267.git.mengdong.lin@linux.intel.com>
References: <cover.1475505267.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D144D266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 17:03:12 +0200 (CEST)
In-Reply-To: <cover.1475505267.git.mengdong.lin@linux.intel.com>
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

Define the type and ABI struct for BE (Back End) DAIs. Add the number of
BE DAIs to manifest, and add some reserved fields for future extensions.
Kernel will use this ABI struct to configure existing BE DAIs registered
by driver.

Pump the version number to 5.

Topology kernel driver will check size of ABI objects to detect version
mismatch between user space and kernel.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index abe49c5..2f88e83 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -74,7 +74,7 @@
 #define SND_SOC_TPLG_NUM_TEXTS		16
 
 /* ABI version */
-#define SND_SOC_TPLG_ABI_VERSION	0x4
+#define SND_SOC_TPLG_ABI_VERSION	0x5
 
 /* Max size of TLV data */
 #define SND_SOC_TPLG_TLV_SIZE		32
@@ -96,7 +96,8 @@
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
 #define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
 #define SND_SOC_TPLG_TYPE_PDATA		11
-#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
+#define SND_SOC_TPLG_TYPE_BE_DAI	12
+#define SND_SOC_TPLG_TYPE_MAX		SND_SOC_TPLG_TYPE_BE_DAI
 
 /* vendor block IDs - please add new vendor types to end */
 #define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
@@ -115,6 +116,11 @@
 #define SND_SOC_TPLG_TUPLE_TYPE_WORD	4
 #define SND_SOC_TPLG_TUPLE_TYPE_SHORT	5
 
+/* BE DAI flags */
+#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES         (1 << 0)
+#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
+#define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -276,6 +282,8 @@ struct snd_soc_tplg_manifest {
 	__le32 graph_elems;	/* number of graph elements */
 	__le32 pcm_elems;	/* number of PCM elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
+	__le32 be_dai_elems;	/* number of BE DAI elements */
+	__le32 reserved[20];	/* reserved for new ABI element types */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
@@ -441,4 +449,26 @@ struct snd_soc_tplg_link_config {
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
 	__le32 num_streams;     /* number of streams */
 } __attribute__((packed));
+
+/*
+ * Describes SW/FW specific features of BE DAI.
+ *
+ * File block representation for BE DAI :-
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_hdr           |  1  |
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_be_dai        |  N  |
+ * +-----------------------------------+-----+
+ */
+struct snd_soc_tplg_be_dai {
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
