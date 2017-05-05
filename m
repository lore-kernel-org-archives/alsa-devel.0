From: fuweix.tang@intel.com
Subject: [PATCH v2] topology: Fix issue in parsing routes when
	generating topology binary
Date: Fri,  5 May 2017 15:57:20 +0800
Message-ID: <1493971040-15628-1-git-send-email-fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D73EB26687D
 for <alsa-devel@alsa-project.org>; Fri,  5 May 2017 09:57:43 +0200 (CEST)
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

We missed parsing the index value, which is used as a use case indicator, when
processing the route objects.

This patch fixes the bug.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 src/topology/dapm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 13aa1c4..6af750b 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -381,7 +381,7 @@ done:
 }
 
 
-static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg)
+static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg, int index)
 {
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -399,7 +399,7 @@ static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg)
 		elem = tplg_elem_new_route(tplg);
 		if (!elem)
 			return -ENOMEM;
-
+		elem->index = index;
 		line = elem->route;
 
 		err = tplg_parse_line(val, line);
@@ -419,7 +419,8 @@ int tplg_parse_dapm_graph(snd_tplg_t *tplg, snd_config_t *cfg,
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	int err;
-	const char *graph_id;
+	const char *graph_id, *val = NULL;
+	int index;
 
 	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
 		SNDERR("error: compound is expected for dapm graph definition\n");
@@ -436,8 +437,14 @@ int tplg_parse_dapm_graph(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
+		if (strcmp(id, "index") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+			index = atoi(val);
+		}
+
 		if (strcmp(id, "lines") == 0) {
-			err = tplg_parse_routes(tplg, n);
+			err = tplg_parse_routes(tplg, n, index);
 			if (err < 0) {
 				SNDERR("error: failed to parse dapm graph %s\n",
 					graph_id);
-- 
2.7.4
