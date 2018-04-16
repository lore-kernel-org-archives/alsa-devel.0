From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH alsa-lib v4 4/4] ASoC: topology: Add alias conf
	parameter names for hw_configs
Date: Mon, 16 Apr 2018 20:26:41 +0200
Message-ID: <20180416182641.30312-5-k.marinushkin@gmail.com>
References: <20180416182641.30312-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0026C267611
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 20:26:36 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id l49so28665365wrl.4
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 11:26:36 -0700 (PDT)
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

Currently, some parameter names in conf differ from field names in struct.
These look like typos.

This commit suggests to add aliases for such parameters, so that the names
in conf are similar to names in struct. This solution is backwards
compatible.

If the difference between conf names and struct names is done on purpose -
this commit can be dropped.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 src/topology/pcm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 2ce1651b..8ebfafd8 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1126,7 +1126,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "format") == 0) {
+		if (strcmp(id, "format") == 0 ||
+		    strcmp(id, "fmt") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1137,7 +1138,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "bclk") == 0) {
+		if (strcmp(id, "bclk") == 0 ||
+		    strcmp(id, "bclk_master") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1157,7 +1159,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "bclk_freq") == 0) {
+		if (strcmp(id, "bclk_freq") == 0 ||
+		    strcmp(id, "bclk_rate") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1165,7 +1168,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "bclk_invert") == 0) {
+		if (strcmp(id, "bclk_invert") == 0 ||
+		    strcmp(id, "invert_bclk") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1174,7 +1178,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "fsync") == 0) {
+		if (strcmp(id, "fsync") == 0 ||
+		    strcmp(id, "fsync_master") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1194,7 +1199,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "fsync_invert") == 0) {
+		if (strcmp(id, "fsync_invert") == 0 ||
+		    strcmp(id, "invert_fsync") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1203,7 +1209,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "fsync_freq") == 0) {
+		if (strcmp(id, "fsync_freq") == 0 ||
+		    strcmp(id, "fsync_rate") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1211,7 +1218,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "mclk_freq") == 0) {
+		if (strcmp(id, "mclk_freq") == 0 ||
+		    strcmp(id, "mclk_rate") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1219,7 +1227,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "mclk") == 0) {
+		if (strcmp(id, "mclk") == 0 ||
+		    strcmp(id, "mclk_direction") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
@@ -1239,7 +1248,8 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "pm_gate_clocks") == 0) {
+		if (strcmp(id, "pm_gate_clocks") == 0 ||
+		    strcmp(id, "clock_gated") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-- 
2.13.6
