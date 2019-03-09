From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: audio-graph-card: test memory
	allocation
Date: Fri,  8 Mar 2019 20:02:51 -0600
Message-ID: <20190309020252.27860-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA82DF8072E
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2019 03:03:04 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

devm_kcalloc() return value needs to be checked.

Fixes: 1e4771a62fd7a ('ASoC: audio-graph-card: add link_info')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index bb12351330e8..ba65b48c10a7 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -670,7 +670,7 @@ static int graph_probe(struct platform_device *pdev)
 	dai_link  = devm_kcalloc(dev, li.link, sizeof(*dai_link),  GFP_KERNEL);
 	dais      = devm_kcalloc(dev, li.dais, sizeof(*dais),      GFP_KERNEL);
 	cconf     = devm_kcalloc(dev, li.conf, sizeof(*cconf),     GFP_KERNEL);
-	if (!dai_props || !dai_link || !dais)
+	if (!dai_props || !dai_link || !dais || !cconf)
 		return -ENOMEM;
 
 	/*
-- 
2.17.1
