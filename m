From: mengdong.lin@linux.intel.com
Subject: [PATCH v5 09/11] ASoC: topology: Rename the function
	to create a FE link
Date: Tue, 11 Oct 2016 13:31:38 +0800
Message-ID: <98ad5c7796d53053c1389306a57e7a1446e05383.1476162939.git.mengdong.lin@linux.intel.com>
References: <cover.1476162939.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F69F26655F
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 07:30:48 +0200 (CEST)
In-Reply-To: <cover.1476162939.git.mengdong.lin@linux.intel.com>
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

Just code refactoring. The function soc_tplg_link_create() will
create a front end link, not a physical link. So rename it to
soc_tplg_fe_link_create().

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2964e39..4285ebe 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1712,7 +1712,7 @@ static void set_link_flags(struct snd_soc_dai_link *link,
 }
 
 /* create the FE DAI link */
-static int soc_tplg_link_create(struct soc_tplg *tplg,
+static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
 	struct snd_soc_dai_link *link;
@@ -1768,7 +1768,7 @@ static int soc_tplg_pcm_create(struct soc_tplg *tplg,
 	if (ret < 0)
 		return ret;
 
-	return  soc_tplg_link_create(tplg, pcm);
+	return  soc_tplg_fe_link_create(tplg, pcm);
 }
 
 /* copy stream caps from the old version 4 of source */
-- 
2.5.0
