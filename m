From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH alsa-lib v4 3/4] ASoC: topology: Add
	definitions for mclk_direction values
Date: Mon, 16 Apr 2018 20:26:40 +0200
Message-ID: <20180416182641.30312-4-k.marinushkin@gmail.com>
References: <20180416182641.30312-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 70C9F267608
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 20:26:33 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id h3so16045242wrh.5
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 11:26:33 -0700 (PDT)
In-Reply-To: <20180416182641.30312-1-k.marinushkin@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Current comment makes not clear the direction of mclk. Previously, similar
description caused a misunderstanding for bclk_master and fsync_master.

This commit solves the potential confusion the same way it is solved for
bclk_master and fsync_master.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 include/sound/asoc.h |  6 +++++-
 include/topology.h   |  2 +-
 src/topology/pcm.c   | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 297e837c..bb8aec78 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -140,6 +140,10 @@
 #define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
 #define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
 
+/* DAI mclk_direction */
+#define SND_SOC_TPLG_MCLK_CO            0 /* for codec, mclk is output */
+#define SND_SOC_TPLG_MCLK_CI            1 /* for codec, mclk is input */
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -330,7 +334,7 @@ struct snd_soc_tplg_hw_config {
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
 	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
-	__u8 mclk_direction;    /* 0 for input, 1 for output */
+	__u8 mclk_direction;    /* SND_SOC_TPLG_MCLK_ value */
 	__le16 reserved;	/* for 32bit alignment */
 	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
 	__le32 bclk_rate;	/* BCLK freqency in Hz */
diff --git a/include/topology.h b/include/topology.h
index 3793115c..27da7308 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -1002,7 +1002,7 @@ struct snd_tplg_hw_config_template {
 	unsigned char  invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
 	unsigned char  bclk_master;     /* SND_SOC_TPLG_BCLK_ value */
 	unsigned char  fsync_master;    /* SND_SOC_TPLG_FSYNC_ value */
-	unsigned char  mclk_direction;  /* 0 for input, 1 for output */
+	unsigned char  mclk_direction;  /* SND_SOC_TPLG_MCLK_ value */
 	unsigned short reserved;        /* for 32bit alignment */
 	unsigned int mclk_rate;	        /* MCLK or SYSCLK freqency in Hz */
 	unsigned int bclk_rate;	        /* BCLK freqency in Hz */
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index b53f6b03..2ce1651b 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1223,8 +1223,19 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			if (!strcmp(val, "master"))
-				hw_cfg->mclk_direction = true;
+			if (!strcmp(val, "master")) {
+				/* For backwards capability,
+				 * "master" == "for codec, mclk is input"
+				 */
+				SNDERR("warning: deprecated mclk value '%s'\n",
+				       val);
+
+				hw_cfg->mclk_direction = SND_SOC_TPLG_MCLK_CI;
+			} else if (!strcmp(val, "codec_mclk_in")) {
+				hw_cfg->mclk_direction = SND_SOC_TPLG_MCLK_CI;
+			} else if (!strcmp(val, "codec_mclk_out")) {
+				hw_cfg->mclk_direction = SND_SOC_TPLG_MCLK_CO;
+			}
 			continue;
 		}
 
-- 
2.13.6
