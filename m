From: mengdong.lin@linux.intel.com
Subject: [PATCH 07/13] ASoC: topology: ABI - Add name &
	component info to BE/CC links
Date: Fri, 19 Aug 2016 18:13:36 +0800
Message-ID: <2175adec09f0058c60214452ddc74bd0819fb427.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 088D2266C56
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:07:43 +0200 (CEST)
In-Reply-To: <cover.1471599648.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Add link name, stream name, CPU and codec components info, for topology
to create new backend or codec-codec links in the future.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index c75ed4f..812a70b 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -39,6 +39,9 @@
  */
 #define SND_SOC_TPLG_STREAM_CONFIG_MAX  8
 
+/* maximum number of codecs for a BE/CC link */
+#define SND_SOC_TPLG_LINK_CODECS_MAX    4
+
 /* individual kcontrol info types - can be mixed with other types */
 #define SND_SOC_TPLG_CTL_VOLSW		1
 #define SND_SOC_TPLG_CTL_VOLSW_SX	2
@@ -465,6 +468,15 @@ struct snd_soc_tplg_pcm {
 
 
 /*
+ * Component for backend links.
+ */
+struct snd_soc_tplg_link_cmpnt {
+	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* component name, optional */
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+} __attribute__((packed));
+
+/*
  * Describes the BE or CC link runtime supported configs or params
  *
  * File block representation for BE/CC link config :-
@@ -476,9 +488,16 @@ struct snd_soc_tplg_pcm {
  */
 struct snd_soc_tplg_link_config {
 	__le32 size;            /* in bytes of this structure */
-	__le32 id;              /* unique ID - used to match */
+	__le32 id;              /* unique ID - used to match with DAI link */
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
 	__le32 num_streams;     /* number of streams */
+
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];        /* link name */
+	char stream_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* stream name */
+
+	struct snd_soc_tplg_link_cmpnt cpu;              /* cpu component */
+	struct snd_soc_tplg_link_cmpnt codecs[SND_SOC_TPLG_LINK_CODECS_MAX]; /* codec components */
+	__le32 num_codecs;      /* number of codecs */
 } __attribute__((packed));
 
 /*
-- 
2.5.0
