From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH,
	alsa-lib] ASoC: topology: Fix bclk and fsync inversion in
	set_link_hw_format()
Date: Tue, 27 Feb 2018 21:35:41 +0100
Message-ID: <20180227203541.17343-1-k.marinushkin@gmail.com>
References: <20180227203317.17274-2-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CD8926772C
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 21:35:26 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id v65so118816wrc.11
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 12:35:26 -0800 (PST)
In-Reply-To: <20180227203317.17274-2-k.marinushkin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

The values of bclk and fsync are inverted WRT the codec. But the existing
solution already works for Broadwell, see the alsa-lib config:

`alsa-lib/src/conf/topology/broadwell/broadwell.conf`

This commit provides the backwards-compatible solution to fix this misuse.
This commit goes in pair with the corresponding patch for linux.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 include/sound/asoc.h                       | 16 ++++++++++++++--
 src/conf/topology/broadwell/broadwell.conf |  4 ++--
 src/topology/pcm.c                         | 20 ++++++++++++++++----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 0f5d9f9a..89b00703 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -156,6 +156,18 @@
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 #define SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP            (1 << 3)
 
+/* DAI topology BCLK parameter
+ * For the backwards capability, by default codec is bclk master
+ */
+#define SND_SOC_TPLG_BCLK_CM         0 /* codec is bclk master */
+#define SND_SOC_TPLG_BCLK_CS         1 /* codec is bclk slave */
+
+/* DAI topology FSYNC parameter
+ * For the backwards capability, by default codec is fsync master
+ */
+#define SND_SOC_TPLG_FSYNC_CM         0 /* codec is fsync master */
+#define SND_SOC_TPLG_FSYNC_CS         1 /* codec is fsync slave */
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -311,8 +323,8 @@ struct snd_soc_tplg_hw_config {
 	__u8 clock_gated;	/* 1 if clock can be gated to save power */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
-	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
-	__u8 fsync_master;	/* 1 for master of FSYNC, 0 for slave */
+	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
+	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
 	__u8 mclk_direction;    /* 0 for input, 1 for output */
 	__le16 reserved;	/* for 32bit alignment */
 	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
diff --git a/src/conf/topology/broadwell/broadwell.conf b/src/conf/topology/broadwell/broadwell.conf
index b8405d93..09fc4daa 100644
--- a/src/conf/topology/broadwell/broadwell.conf
+++ b/src/conf/topology/broadwell/broadwell.conf
@@ -393,8 +393,8 @@ SectionGraph."dsp" {
 SectionHWConfig."CodecHWConfig" {
 	id "1"
 	format "I2S"		# physical audio format.
-	bclk   "master"		# Platform is master of bit clock
-	fsync  "master"		# platform is master of fsync
+	bclk   "codec_slave"	# platform is master of bit clock (codec is slave)
+	fsync  "codec_slave"	# platform is master of fsync (codec is slave)
 }
 
 SectionLink."Codec" {
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 58cee31d..d5d5e5b3 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1137,8 +1137,14 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			if (!strcmp(val, "master"))
-				hw_cfg->bclk_master = true;
+			/* For backwards capability,
+			 * "master" == "codec is slave"
+			 */
+			if (!strcmp(val, "master") ||
+			    !strcmp(val, "codec_slave"))
+				hw_cfg->bclk_master = SND_SOC_TPLG_BCLK_CS;
+			else if (!strcmp(val, "codec_master"))
+				hw_cfg->bclk_master = SND_SOC_TPLG_BCLK_CM;
 			continue;
 		}
 
@@ -1163,8 +1169,14 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			if (!strcmp(val, "master"))
-				hw_cfg->fsync_master = true;
+			/* For backwards capability,
+			 * "master" == "codec is slave"
+			 */
+			if (!strcmp(val, "master") ||
+			    !strcmp(val, "codec_slave"))
+				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CS;
+			else if (!strcmp(val, "codec_master"))
+				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CM;
 			continue;
 		}
 
-- 
2.13.6
