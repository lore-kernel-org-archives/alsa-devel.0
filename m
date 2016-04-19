From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/4] ASoC: topology: Set the link ID when
	creating a FE DAI link
Date: Tue, 19 Apr 2016 13:12:43 +0800
Message-ID: <363cac6fe4cb2e8c5f839ace62f1641927ac1e0f.1461042239.git.mengdong.lin@linux.intel.com>
References: <cover.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D620265CDD
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 07:10:00 +0200 (CEST)
In-Reply-To: <cover.1461042239.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Topology will set the link's generic id when creating a FE link.
Device drivers can check the id for link specific initialization.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index e8def0b..fcdf5d7 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -480,7 +480,7 @@ struct snd_soc_tplg_pcm {
 	__le32 size;		/* in bytes of this structure */
 	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 pcm_id;		/* unique ID - used to match */
+	__le32 pcm_id;		/* unique ID - used to match with DAI link */
 	__le32 dai_id;		/* unique ID - used to match */
 	__le32 playback;	/* supports playback mode */
 	__le32 capture;		/* supports capture mode */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 1cf94d7..bdbfcef 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1598,6 +1598,7 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 
 	link->name = pcm->pcm_name;
 	link->stream_name = pcm->pcm_name;
+	link->id = pcm->pcm_id;
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link);
-- 
2.5.0
