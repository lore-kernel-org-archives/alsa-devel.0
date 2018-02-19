From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH,
	alsa-lib v2 2/2] ASoC: topology: Add defines for
	snd_soc_tplg_hw_config.clock_gated
Date: Mon, 19 Feb 2018 21:38:43 +0100
Message-ID: <20180219203843.3781-2-k.marinushkin@gmail.com>
References: <b890d16d-31df-279f-dbf0-0bb699ca7b8b@sakamocchi.jp>
 <20180219203843.3781-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180219203843.3781-1-k.marinushkin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, alsa-patch@alsa-project.org, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

In kernel `soc-dai.h`, DAI clock gating is defined as following:

~~~~
\#define SND_SOC_DAIFMT_CONT            (1 << 4) /* continuous clock */
\#define SND_SOC_DAIFMT_GATED           (0 << 4) /* clock is gated */
~~~~

The corresponding field of struct snd_soc_tplg_hw_config cannot be used as
bool values due to the inverted logic. Therefore this commit adds the
defines for this field.

snd_soc_tplg_hw_config.clock_gated = 0 => no effect
snd_soc_tplg_hw_config.clock_gated = 1 => SND_SOC_DAIFMT_GATED
snd_soc_tplg_hw_config.clock_gated = 2 => SND_SOC_DAIFMT_CONT

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
Cc: alsa-patch@alsa-project.org
---
 include/sound/asoc.h | 7 ++++++-
 include/topology.h   | 2 +-
 src/topology/pcm.c   | 6 +++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 0f5d9f9a..8f3d7bac 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -135,6 +135,11 @@
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 
+/* DAI clock gating */
+#define SND_SOC_TPLG_DAI_CLK_GATE_UNDEFINED	0
+#define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
+#define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -308,7 +313,7 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_gated;	/* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
diff --git a/include/topology.h b/include/topology.h
index 8779da4d..80d959be 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -997,7 +997,7 @@ struct snd_tplg_pcm_template {
 struct snd_tplg_hw_config_template {
 	int id;                         /* unique ID - - used to match */
 	unsigned int fmt;               /* SND_SOC_DAI_FORMAT_ format value */
-	unsigned char clock_gated;      /* 1 if clock can be gated to save power */
+	unsigned char clock_gated;      /* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 	unsigned char  invert_bclk;     /* 1 for inverted BCLK, 0 for normal */
 	unsigned char  invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
 	unsigned char  bclk_master;     /* 1 for master of BCLK, 0 for slave */
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index d3836677..973f3028 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1210,7 +1210,11 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 				return -EINVAL;
 
 			if (!strcmp(val, "true"))
-				hw_cfg->clock_gated = true;
+				hw_cfg->clock_gated =
+					SND_SOC_TPLG_DAI_CLK_GATE_GATED;
+			else
+				hw_cfg->clock_gated =
+					SND_SOC_TPLG_DAI_CLK_GATE_CONT;
 			continue;
 		}
 
-- 
2.13.6
