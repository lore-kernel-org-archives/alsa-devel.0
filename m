From: mengdong.lin@linux.intel.com
Subject: [PATCH 17/22] topology: Parse name and stream name of
	physical DAI links
Date: Thu, 27 Oct 2016 15:14:24 +0800
Message-ID: <a662a1628f4bf9a462c2665e86662f0c9ff27f0d.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C1652672C7
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:13:08 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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

Add name and stream name to C API template of physical DAI links.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index d7971b7..f7ab7fe 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -632,6 +632,8 @@ extern "C" {
  *
  *	id "0"				# used for binding to the link
  *
+ *	stream_name "name"		# used for binding to the link
+ *
  *	hw_configs [	# runtime supported HW configurations, optional
  *		"config1"
  *		"config2"
@@ -960,6 +962,8 @@ struct snd_tplg_hw_config_template {
 struct snd_tplg_link_template {
 	const char *name;	/*!< link name */
 	int id;	/*!< unique ID - used to match with existing BE and CC links */
+	const char *stream_name;        /*!< stream name of the link */
+
 	int num_streams;	/*!< number of configs */
 	struct snd_tplg_stream_template *stream;       /*!< supported configs */
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index c4857ba..67d647b 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -640,6 +640,7 @@ int tplg_parse_link(snd_tplg_t *tplg,
 
 	link = elem->link;
 	link->size = elem->size;
+	elem_copy_text(link->name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	tplg_dbg(" Link: %s\n", elem->id);
 
@@ -673,6 +674,16 @@ int tplg_parse_link(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "stream_name") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			elem_copy_text(link->stream_name, val,
+					SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+			tplg_dbg("\t%s: %s\n", id, val);
+			continue;
+		}
+
 		if (strcmp(id, "hw_configs") == 0) {
 			err = parse_hw_config_refs(tplg, n, elem);
 			if (err < 0)
@@ -1066,7 +1077,13 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	link = elem->link;
 	link->size = elem->size;
 
+	/* ID and names */
 	link->id = link_tpl->id;
+	elem_copy_text(link->name, link_tpl->name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	elem_copy_text(link->stream_name, link_tpl->stream_name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
 	/* stream configs */
 	if (link_tpl->num_streams > SND_SOC_TPLG_STREAM_CONFIG_MAX)
 		return -EINVAL;
-- 
2.5.0
