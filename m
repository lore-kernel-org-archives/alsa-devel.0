From: mengdong.lin@linux.intel.com
Subject: [PATCH 07/13] topology: Define new type and section
	name to configure physical links
Date: Sun,  6 Nov 2016 13:13:36 +0800
Message-ID: <2f89586da5cd5c944d85b051ee2ad808e8aa6c90.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ABD52665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:12:06 +0100 (CET)
In-Reply-To: <cover.1478407716.git.mengdong.lin@linux.intel.com>
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

Users may not use DPCM but still need to configure the physical links.
So we should not only consider backend links for DPCM.

- SND_TPLG_TYPE_LINK is defined to configure physical links by C API.
  And SND_TPLG_TYPE_BE is still supported to configure Backend links for
  DPCM cases.

- SectionLink can be used to configure physical links in text conf file.
  And SectionBE is still supported to config Backend links for DPCM cases.

Actually, users can use SND_TPLG_TYPE_LINK and SectionLink to configure
backend links for DPCM cases, because BE links are also physical links.
The parsing is same and we rename the function from tplg_parse_be to
tplg_parse_link.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index dbd18b3..1fbaeb8 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -617,6 +617,24 @@ extern "C" {
  * }
  * </pre>
  *
+ * <h4>Physical DAI Link Configurations</h4>
+ * The runtime configurations of a physical DAI link can be defined by
+ * SectionLink. <br> Backend DAI links belong to physical links, and can
+ * be configured by either SectionLink or SectionBE, with same syntax.
+ * But SectionBE is deprecated atm since the internal processing is
+ * actually same.
+ *
+ * <pre>
+ * SectionLink."name" {
+ *
+ *	index "1"			# Index number
+ *
+ *	id "0"				# used for binding to the link
+ *
+ *	data "name"			# optional private data
+ * }
+ * </pre>
+ *
  * <h4>Manifest Private Data</h4>
  * Manfiest may have private data. Users need to define a manifest section
  * and add the references to 1 or multiple data sections. Please refer to
@@ -687,6 +705,7 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_MANIFEST,		/*!< Topology manifest */
 	SND_TPLG_TYPE_TOKEN,		/*!< Vendor tokens */
 	SND_TPLG_TYPE_TUPLE,		/*!< Vendor tuples */
+	SND_TPLG_TYPE_LINK,		/*!< Physical DAI link */
 };
 
 /**
diff --git a/src/topology/parser.c b/src/topology/parser.c
index ded2eb7..ed5da87 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -133,8 +133,9 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
-		if (strcmp(id, "SectionBE") == 0) {
-			err = tplg_parse_compound(tplg, n, tplg_parse_be,
+		if (strcmp(id, "SectionLink") == 0
+			|| strcmp(id, "SectionBE") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_link,
 				NULL);
 			if (err < 0)
 				return err;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index fe8af45..96a64e7 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -527,7 +527,8 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	return 0;
 }
 
-int tplg_parse_be(snd_tplg_t *tplg,
+/* Parse a physical link element in text conf file */
+int tplg_parse_link(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
 	struct snd_soc_tplg_link_config *link;
@@ -544,7 +545,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	link = elem->link;
 	link->size = elem->size;
 
-	tplg_dbg(" BE: %s\n", elem->id);
+	tplg_dbg(" Link: %s\n", elem->id);
 
 	snd_config_for_each(i, next, cfg) {
 
@@ -748,7 +749,8 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	struct tplg_elem *elem;
 	int i;
 
-	if (t->type != SND_TPLG_TYPE_BE && t->type != SND_TPLG_TYPE_CC)
+	if (t->type != SND_TPLG_TYPE_LINK && t->type != SND_TPLG_TYPE_BE
+	    && t->type != SND_TPLG_TYPE_CC)
 		return -EINVAL;
 
 	/* here type can be either BE or CC. */
@@ -756,10 +758,7 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	if (!elem)
 		return -ENOMEM;
 
-	if (t->type == SND_TPLG_TYPE_BE)
-		tplg_dbg("BE Link: %s", link_tpl->name);
-	else
-		tplg_dbg("CC Link: %s", link_tpl->name);
+	tplg_dbg("Link: %s", link_tpl->name);
 
 	link = elem->link;
 	link->size = elem->size;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 548f42d..947f27e 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -220,7 +220,7 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-int tplg_parse_be(snd_tplg_t *tplg,
+int tplg_parse_link(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
 int tplg_parse_cc(snd_tplg_t *tplg,
-- 
2.7.4
