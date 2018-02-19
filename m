From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH,
	alsa-lib 2/2] ASoC: topology: Rename clock_gated to clock_cont in
	snd_soc_tplg_hw_config
Date: Mon, 19 Feb 2018 07:07:58 +0100
Message-ID: <20180219060758.17344-2-k.marinushkin@gmail.com>
References: <20180219060758.17344-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180219060758.17344-1-k.marinushkin@gmail.com>
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
Cc: alsa-patch@alsa-project.org, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

In kernel `soc-dai.h`, DAI clock gating is defined as following:

~~~~
\#define SND_SOC_DAIFMT_CONT            (1 << 4) /* continuous clock */
\#define SND_SOC_DAIFMT_GATED           (0 << 4) /* clock is gated */
~~~~

Therefore, the corresponding field of struct snd_soc_tplg_hw_config should
be inverted compared to the current logic:

clock_count = 1 => SND_SOC_DAIFMT_CONT
clock_count = 0 => SND_SOC_DAIFMT_GATED

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: alsa-patch@alsa-project.org
---
 include/sound/asoc.h | 4 +++-
 include/topology.h   | 4 +++-
 src/topology/pcm.c   | 6 +++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 0f5d9f9a..9f601ef0 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -308,7 +308,9 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_cont;	/* 1 if clock is continuous, and can not be
+				 * gated to save power
+				 */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
diff --git a/include/topology.h b/include/topology.h
index 8779da4d..630fee21 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -997,7 +997,9 @@ struct snd_tplg_pcm_template {
 struct snd_tplg_hw_config_template {
 	int id;                         /* unique ID - - used to match */
 	unsigned int fmt;               /* SND_SOC_DAI_FORMAT_ format value */
-	unsigned char clock_gated;      /* 1 if clock can be gated to save power */
+	unsigned char clock_cont;	/* 1 if clock is continuous, and can not
+					 * be gated to save power
+					 */
 	unsigned char  invert_bclk;     /* 1 for inverted BCLK, 0 for normal */
 	unsigned char  invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
 	unsigned char  bclk_master;     /* 1 for master of BCLK, 0 for slave */
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index d3836677..7f280ed0 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1205,12 +1205,12 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "pm_gate_clocks") == 0) {
+		if (strcmp(id, "pm_cont_clock") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
 			if (!strcmp(val, "true"))
-				hw_cfg->clock_gated = true;
+				hw_cfg->clock_cont = true;
 			continue;
 		}
 
@@ -1376,7 +1376,7 @@ static int set_link_hw_config(struct snd_soc_tplg_hw_config *cfg,
 	cfg->id = tpl->id;
 
 	cfg->fmt = tpl->fmt;
-	cfg->clock_gated = tpl->clock_gated;
+	cfg->clock_cont = tpl->clock_cont;
 	cfg->invert_bclk = tpl->invert_bclk;
 	cfg->invert_fsync = tpl->invert_fsync;
 	cfg->bclk_master = tpl->bclk_master;
-- 
2.13.6
