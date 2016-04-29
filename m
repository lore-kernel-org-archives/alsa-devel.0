From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 4/6] topology: Fix pcm ID & name parsing
Date: Fri, 29 Apr 2016 11:03:30 +0800
Message-ID: <ee41f44340104b6052fc694bf5fc156af1a23122.1461898635.git.mengdong.lin@linux.intel.com>
References: <cover.1461898635.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 066172666BF
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:00:31 +0200 (CEST)
In-Reply-To: <cover.1461898635.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The name and ID of SectionPCM should be set to pcm_name and pcm_id,
for a front-end DAI link in the kernel, not for the front-end DAI
of the link.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 920c9e0..abe49c5 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -414,7 +414,7 @@ struct snd_soc_tplg_pcm {
 	__le32 size;		/* in bytes of this structure */
 	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 pcm_id;		/* unique ID - used to match */
+	__le32 pcm_id;		/* unique ID - used to match with DAI link */
 	__le32 dai_id;		/* unique ID - used to match */
 	__le32 playback;	/* supports playback mode */
 	__le32 capture;		/* supports capture mode */
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 1df4f54..1661821 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -337,7 +337,7 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 
 	pcm = elem->pcm;
 	pcm->size = elem->size;
-	elem_copy_text(pcm->dai_name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	elem_copy_text(pcm->pcm_name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	tplg_dbg(" PCM: %s\n", elem->id);
 
@@ -366,8 +366,8 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			pcm->dai_id = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, pcm->dai_id);
+			pcm->pcm_id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, pcm->pcm_id);
 			continue;
 		}
 
-- 
2.5.0
