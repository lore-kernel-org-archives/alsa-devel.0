From: mengdong.lin@linux.intel.com
Subject: [PATCH 7/9] topology: ABI - Rename dai_elems to
	pcm_elems in manifest
Date: Thu,  5 Nov 2015 20:49:10 +0800
Message-ID: <c818ed746a2785fe5c69e3798712ecc535c9c327.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D439B266056
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:57 +0100 (CET)
In-Reply-To: <cover.1446726689.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This field is the number of PCM objects (a pair of FE DAI and DAI link).

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 5f857cf..a29c05c 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -234,7 +234,7 @@ struct snd_soc_tplg_manifest {
 	__le32 control_elems;	/* number of control elements */
 	__le32 widget_elems;	/* number of widget elements */
 	__le32 graph_elems;	/* number of graph elements */
-	__le32 dai_elems;	/* number of DAI elements */
+	__le32 pcm_elems;	/* number of PCM elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
-- 
1.9.1
