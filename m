From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: add private data to manifest
Date: Mon, 29 Jun 2015 17:36:46 +0100
Message-ID: <1435595806-7000-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0424E265A06
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:37:14 +0200 (CEST)
In-Reply-To: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The topology file manifest should include a private data field. This
allows vendors to specify vendor data in the manifest, like
timestamps, hashes, additional information for removing platform
configuration out of drivers and making these configurable per platform

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/asoc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index a584d91..2819fc1 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -238,6 +238,7 @@ struct snd_soc_tplg_manifest {
 	__le32 graph_elems;	/* number of graph elements */
 	__le32 dai_elems;	/* number of DAI elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
 /*
-- 
2.1.4
