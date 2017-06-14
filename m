From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Add support for missing fields
	parser.
Date: Wed, 14 Jun 2017 12:37:39 +0100
Message-ID: <1497440260-28334-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E7AD12671E6
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 13:37:56 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The alsa-lib topology parser is missing some fields for certain objects that
are part of the ABI. This patch adds the missing fields to the parser.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/pcm.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index daef20e..0f4deb4 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -383,6 +383,49 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
 			tplg_dbg("\t\t%s: %d\n", id, sc->channels_max);
 			continue;
 		}
+
+		if (strcmp(id, "periods_min") == 0) {
+			sc->periods_min = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->periods_min);
+			continue;
+		}
+
+		if (strcmp(id, "periods_max") == 0) {
+			sc->periods_max = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->periods_max);
+			continue;
+		}
+
+		if (strcmp(id, "period_size_min") == 0) {
+			sc->period_size_min = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->period_size_min);
+			continue;
+		}
+
+		if (strcmp(id, "period_size_max") == 0) {
+			sc->period_size_max = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->period_size_max);
+			continue;
+		}
+
+		if (strcmp(id, "buffer_size_min") == 0) {
+			sc->buffer_size_min = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->buffer_size_min);
+			continue;
+		}
+
+		if (strcmp(id, "buffer_size_max") == 0) {
+			sc->buffer_size_max = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->buffer_size_max);
+			continue;
+		}
+
+		if (strcmp(id, "sig_bits") == 0) {
+			sc->sig_bits = atoi(val);
+			tplg_dbg("\t\t%s: %d\n", id, sc->sig_bits);
+			continue;
+		}
+
 	}
 
 	return 0;
@@ -572,6 +615,17 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "compress") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (strcmp(val, "true") == 0)
+				pcm->compress = 1;
+
+			tplg_dbg("\t%s: %s\n", id, val);
+			continue;
+		}
+
 		if (strcmp(id, "dai") == 0) {
 			err = tplg_parse_compound(tplg, n,
 				tplg_parse_fe_dai, elem);
@@ -655,6 +709,26 @@ int tplg_parse_dai(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "playback") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			dai->playback = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, dai->playback);
+			continue;
+		}
+
+
+		if (strcmp(id, "capture") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			dai->capture = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, dai->capture);
+			continue;
+		}
+
+
 		/* stream capabilities */
 		if (strcmp(id, "pcm") == 0) {
 			err = tplg_parse_compound(tplg, n,
@@ -997,6 +1071,23 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
+		if (strcmp(id, "bclk_freq") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->bclk_rate = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "bclk_invert") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (!strcmp(val, "true"))
+				hw_cfg->invert_bclk = true;
+			continue;
+		}
+
 		if (strcmp(id, "fsync") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
@@ -1005,6 +1096,98 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 				hw_cfg->fsync_master = true;
 			continue;
 		}
+
+		if (strcmp(id, "fsync_invert") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (!strcmp(val, "true"))
+				hw_cfg->invert_fsync = true;
+			continue;
+		}
+
+		if (strcmp(id, "fsync_freq") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->fsync_rate = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "mclk_freq") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->mclk_rate = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "mclk") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (!strcmp(val, "master"))
+				hw_cfg->mclk_direction = true;
+			continue;
+		}
+
+		if (strcmp(id, "pm_gate_clocks") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (!strcmp(val, "true"))
+				hw_cfg->clock_gated = true;
+			continue;
+		}
+
+		if (strcmp(id, "tdm_slots") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->tdm_slots = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "tdm_slot_width") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->tdm_slot_width = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "tx_slots") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->tx_slots = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "rx_slots") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->rx_slots = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "tx_channels") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->tx_channels = atoi(val);
+			continue;
+		}
+
+		if (strcmp(id, "rx_channels") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->rx_channels = atoi(val);
+			continue;
+		}
+
 	}
 
 	return 0;
-- 
1.9.1
