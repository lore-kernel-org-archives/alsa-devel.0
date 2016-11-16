From: mengdong.lin@linux.intel.com
Subject: [PATCH 7/7] topology: Revise document and comments for
	ABI v5
Date: Wed, 16 Nov 2016 14:43:07 +0800
Message-ID: <178981456f027965d94e8e1a7eaeeab7de71dcf2.1479277829.git.mengdong.lin@linux.intel.com>
References: <cover.1479277829.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 222402665B6
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 07:41:36 +0100 (CET)
In-Reply-To: <cover.1479277829.git.mengdong.lin@linux.intel.com>
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

Revise the obsolete content in document and comments.

Here are the major changes in implementation from early phase design:
- PCM object is used to configure front end DAI & DAI links, not used by
  physical DAI or DAI links.
- No longer use separate object for backend or codec<->codec links, but
  use physical links to cover them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index c5d0080..593eaa6 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -40,9 +40,10 @@ extern "C" {
  * currently recognises the following object types :-
  *
  *  * Controls (mixer, enumerated and byte) including TLV data.
- *  * PCMs (FE and BE configurations and capabilities)
+ *  * PCMs (Front End DAI & DAI link)
  *  * DAPM widgets
  *  * DAPM graph elements.
+ *  * Physical DAI & DAI links
  *  * Private data for each object type.
  *  * Manifest (containing count of each object type)
  *
@@ -511,8 +512,8 @@ extern "C" {
  * refer to section Control Private Data.
  *
  * <h4>PCM Capabilities</h4>
- * Topology can also define the capabilities of FE and BE PCMs. Capabilities
- * can be defined with the following section :-
+ * Topology can also define the PCM capabilities of front end or physical DAIs.
+ * Capabilities can be defined with the following section :-
  *
  * <pre>
  * SectionPCMCapabilities."name" {
@@ -525,8 +526,8 @@ extern "C" {
  * }
  * </pre>
  * The supported formats use the same naming convention as the driver macros.
- * The PCM capabilities name can be referred to and included by BE, PCM and
- * Codec <-> codec topology sections.
+ * The PCM capabilities name can be referred to and included by PCM and
+ * physical DAI sections.
  *
  * <h4>PCM Configurations</h4>
  * PCM runtime configurations can be defined for playback and capture stream
@@ -552,31 +553,14 @@ extern "C" {
  * </pre>
  *
  * The supported formats use the same naming convention as the driver macros.
- * The PCM configuration name can be referred to and included by BE, PCM and
- * Codec <-> codec topology sections.
+ * The PCM configuration name can be referred to and included by PCM and
+ * physical link sections.
  *
- * <h4>PCM Configurations</h4>
- * PCM, BE and Codec to Codec link sections define the supported capabilities
- * and configurations for supported playback and capture streams. The
- * definitions and content for PCMs, BE and Codec links are the same with the
- * exception of the section type :-
- *
- * <pre>
- * SectionPCM."name" {
- *	....
- * }
- * SectionBE."name" {
- *	....
- * }
- * SectionCC."name" {
- *	....
- * }
- * </pre>
- *
- * The section types above should be used for PCMs, Back Ends and Codec to Codec
- * links respectively.<br>
- *
- * The data for each section is defined as follows :-
+ * <h4>PCM (Front-end DAI & DAI link) </h4>
+ * PCM sections define the supported capabilities and configurations for
+ * supported playback and capture streams, names and flags for front end
+ * DAI & DAI links. Topology kernel driver will use a PCM object to create
+ * a pair of FE DAI & DAI links.
  *
  * <pre>
  * SectionPCM."name" {
@@ -1031,7 +1015,7 @@ struct snd_tplg_dai_template {
 };
 
 /** \struct snd_tplg_link_template
- * \brief Template type for BE and CC DAI Links.
+ * \brief Template type for physical DAI Links.
  */
 struct snd_tplg_link_template {
 	const char *name;	/*!< link name, used to match */
@@ -1065,7 +1049,7 @@ typedef struct snd_tplg_obj_template {
 		struct snd_tplg_enum_template *enum_ctl;	/*!< Enum control */
 		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
 		struct snd_tplg_pcm_template *pcm;		/*!< PCM elements */
-		struct snd_tplg_link_template *link;		/*!< BE and CC Links */
+		struct snd_tplg_link_template *link;		/*!< physical DAI Links */
 		struct snd_tplg_dai_template *dai;		/*!< Physical DAI */
 	};
 } snd_tplg_obj_template_t;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index d7c04c2..2e0a120 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1198,7 +1198,6 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	    && t->type != SND_TPLG_TYPE_CC)
 		return -EINVAL;
 
-	/* here type can be either BE or CC. */
 	elem = tplg_elem_new_common(tplg, NULL, link_tpl->name, t->type);
 	if (!elem)
 		return -ENOMEM;
-- 
2.5.0
