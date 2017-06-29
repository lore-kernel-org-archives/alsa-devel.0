From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: show index in debug when
	adding DAPM routes
Date: Thu, 29 Jun 2017 14:22:26 +0100
Message-ID: <1498742546-23463-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1498742546-23463-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 564B426736F
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 15:22:59 +0200 (CEST)
In-Reply-To: <1498742546-23463-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Makes the debug output much more useful.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 06fb7c4c664a..dd471d2c0266 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1171,7 +1171,8 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	dev_dbg(tplg->dev, "ASoC: adding %d DAPM routes\n", count);
+	dev_dbg(tplg->dev, "ASoC: adding %d DAPM routes for index %d\n", count,
+		hdr->index);
 
 	for (i = 0; i < count; i++) {
 		elem = (struct snd_soc_tplg_dapm_graph_elem *)tplg->pos;
-- 
2.11.0
