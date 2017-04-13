From: fuweix.tang@intel.com
Subject: [PATCH 2/4] topology: Remove code parsing index value
	in paring each object
Date: Thu, 13 Apr 2017 14:52:45 +0800
Message-ID: <48a65d737ca229024dbb3d317e6a96f72263c917.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E732D266AE4
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:53:00 +0200 (CEST)
In-Reply-To: <cover.1492065639.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

We insert a new element into the object list based on its index value, so we parse
index value in "tplg_elem_new_common" before insert it, and then remove code
parsing index value in parsing each object.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>
---
 src/topology/ctl.c  | 27 ---------------------------
 src/topology/dapm.c |  9 ---------
 src/topology/data.c |  9 ---------
 src/topology/pcm.c  | 36 ------------------------------------
 4 files changed, 81 deletions(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 1da3d18..1b160a2 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -397,15 +397,6 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "base") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
@@ -538,15 +529,6 @@ int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "texts") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
@@ -648,15 +630,6 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "channel") == 0) {
 			if (mc->num_channels >= SND_SOC_TPLG_MAX_CHAN) {
 				SNDERR("error: too many channels %s\n",
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index eef72bb..ba5d9fe 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -483,15 +483,6 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "type") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
diff --git a/src/topology/data.c b/src/topology/data.c
index e2aa38c..7b92cea 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -1009,15 +1009,6 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "type") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 5568d57..ed50c9c 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -554,15 +554,6 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "id") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
@@ -654,15 +645,6 @@ int tplg_parse_dai(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "id") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
@@ -804,15 +786,6 @@ int tplg_parse_link(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "id") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
@@ -918,15 +891,6 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 		if (id[0] == '#')
 			continue;
 
-		if (strcmp(id, "index") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			elem->index = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, elem->index);
-			continue;
-		}
-
 		if (strcmp(id, "id") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
-- 
2.7.4
