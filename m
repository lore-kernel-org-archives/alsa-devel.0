From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add the types for BE
	DAI" to the asoc tree
Date: Fri, 05 Aug 2016 13:08:55 +0100
Message-ID: <E1bVdvr-0002b6-Nw@debutante>
References: <5ddb49c810e524aed794b6f6536e1ed566b01c15.1469165422.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CCCB62668F9
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 14:09:03 +0200 (CEST)
In-Reply-To: <5ddb49c810e524aed794b6f6536e1ed566b01c15.1469165422.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Add the types for BE DAI

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 75001c04f99b694d4f483f8028d96bf8bcd57a12 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Tue, 26 Jul 2016 14:32:18 +0800
Subject: [PATCH] ASoC: topology: ABI - Add the types for BE DAI

Define the type and ABI struct for Backend DAIs. Add the number of BE DAIs
to manifest, and some reserved fields for future extensions.

Pump the version number to 5.

Topology core will check size of ABI objects to detect version mismatch
between user space and kernel.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index e4701a3c6331..f734bea9a032 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -83,7 +83,7 @@
 #define SND_SOC_TPLG_NUM_TEXTS		16
 
 /* ABI version */
-#define SND_SOC_TPLG_ABI_VERSION	0x4
+#define SND_SOC_TPLG_ABI_VERSION	0x5
 
 /* Max size of TLV data */
 #define SND_SOC_TPLG_TLV_SIZE		32
@@ -105,7 +105,8 @@
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
 #define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
 #define SND_SOC_TPLG_TYPE_PDATA		11
-#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
+#define SND_SOC_TPLG_TYPE_BE_DAI	12
+#define SND_SOC_TPLG_TYPE_MAX		SND_SOC_TPLG_TYPE_BE_DAI
 
 /* vendor block IDs - please add new vendor types to end */
 #define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
@@ -124,6 +125,11 @@
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
@@ -285,6 +291,8 @@ struct snd_soc_tplg_manifest {
 	__le32 graph_elems;	/* number of graph elements */
 	__le32 pcm_elems;	/* number of PCM elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
+	__le32 be_dai_elems;	/* number of BE DAI elements */
+	__le32 reserved[20];	/* reserved for new ABI element types */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
@@ -450,4 +458,26 @@ struct snd_soc_tplg_link_config {
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
2.8.1
