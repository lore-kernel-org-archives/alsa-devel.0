From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/2] ASoC: topology: ABI - Rename be_dai_elems
	to dai_elems in manifest
Date: Sat,  5 Nov 2016 08:42:24 +0800
Message-ID: <1478306544-23631-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 693A626759C
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 01:40:56 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

User space uses this field to count physical DAIs, not only BE DAIs since
users may not use DPCM. So we rename this field from be_dai_elems to
dai_elems.

This change is backward compatible, because it does not change the layout
of the struct or data type.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 3227073..03ee200 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -348,7 +348,7 @@ struct snd_soc_tplg_manifest {
 	__le32 graph_elems;	/* number of graph elements */
 	__le32 pcm_elems;	/* number of PCM elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
-	__le32 be_dai_elems;	/* number of BE DAI elements */
+	__le32 dai_elems;	/* number of physical DAI elements */
 	__le32 reserved[20];	/* reserved for new ABI element types */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
-- 
2.7.4
