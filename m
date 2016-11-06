From: mengdong.lin@linux.intel.com
Subject: [PATCH 12/13] topology: Parse name and stream name of
	physical DAI links
Date: Sun,  6 Nov 2016 13:14:34 +0800
Message-ID: <dfc0118040eef98ba0ed801f4f84426423d6c383.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C1E182665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:13:04 +0100 (CET)
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

Parse name and stream name of physical links defined by text conf file
or C API. Add name and stream name to C API template of physical DAI
links.

These two fields will help topology kernel driver to find an existing
physical link to configure, since the id of links are often the default
value ZERO and useless for match.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index ad84c15..66dd084 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -631,6 +631,8 @@ extern "C" {
  *
  *	id "0"				# used for binding to the link
  *
+ *	stream_name "name"		# used for binding to the link
+ *
  *	hw_configs [	# runtime supported HW configurations, optional
  *		"config1"
  *		"config2"
@@ -985,8 +987,10 @@ struct snd_tplg_hw_config_template {
  * \brief Template type for BE and CC DAI Links.
  */
 struct snd_tplg_link_template {
-	const char *name;	/*!< link name */
+	const char *name;	/*!< link name, used to match */
 	int id;	/*!< unique ID - used to match with existing BE and CC links */
+	const char *stream_name;        /*!< link stream name, used to match */
+
 	int num_streams;	/*!< number of configs */
 	struct snd_tplg_stream_template *stream;       /*!< supported configs */
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 1d70396..a9d3277 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -622,6 +622,7 @@ int tplg_parse_link(snd_tplg_t *tplg,
 
 	link = elem->link;
 	link->size = elem->size;
+	elem_copy_text(link->name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	tplg_dbg(" Link: %s\n", elem->id);
 
@@ -655,6 +656,16 @@ int tplg_parse_link(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "stream_name") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			elem_copy_text(link->stream_name, val,
+				       SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+			tplg_dbg("\t%s: %s\n", id, val);
+			continue;
+		}
+
 		if (strcmp(id, "hw_configs") == 0) {
 			err = parse_hw_config_refs(tplg, n, elem);
 			if (err < 0)
@@ -1030,7 +1041,15 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	link = elem->link;
 	link->size = elem->size;
 
+	/* ID and names */
 	link->id = link_tpl->id;
+	if (link->name)
+		elem_copy_text(link->name, link_tpl->name,
+			       SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (link->stream_name)
+		elem_copy_text(link->stream_name, link_tpl->stream_name,
+			       SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
 	/* stream configs */
 	if (link_tpl->num_streams > SND_SOC_TPLG_STREAM_CONFIG_MAX)
 		return -EINVAL;
-- 
2.7.4
