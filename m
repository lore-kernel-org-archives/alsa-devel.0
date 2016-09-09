From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 04/11] ASoC: topology: Add FE DAIs only if
	not already added
Date: Fri,  9 Sep 2016 19:45:51 +0800
Message-ID: <3d02fe86ffa83c8cf2ebcb31791edebb7ca22fef.1473420558.git.mengdong.lin@linux.intel.com>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B367326646C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2016 13:39:42 +0200 (CEST)
In-Reply-To: <cover.1473420558.git.mengdong.lin@linux.intel.com>
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

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Topology will check with ASoC if the FE DAI already exists by
checking its name. If not, topology will create a new one.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8ccd7f9..17e0b74 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1680,13 +1680,25 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 static int soc_tplg_pcm_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
+	struct snd_soc_dai_link_component dai_component = {0};
+	struct snd_soc_dai *dai;
 	int ret;
 
-	ret = soc_tplg_dai_create(tplg, pcm);
-	if (ret < 0)
-		return ret;
+	if (!strlen(pcm->dai_name)) {
+		dev_err(tplg->dev, "ASoC: Invalid FE DAI name %s\n",
+			pcm->dai_name);
+		return -EINVAL;
+	}
+
+	dai_component.dai_name = pcm->dai_name;
+	dai = snd_soc_find_dai(&dai_component);
+	if (!dai) { /* FE DAI doesn't exist, create it */
+		ret = soc_tplg_dai_create(tplg, pcm);
+		if (ret < 0)
+			return ret;
+	}
 
-	return  soc_tplg_link_create(tplg, pcm);
+	return soc_tplg_link_create(tplg, pcm);
 }
 
 static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
-- 
2.5.0
