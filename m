From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 2/4] ASoC: soc core move the card debugfs
	initialization
Date: Thu, 13 Jan 2011 22:48:32 +0530
Message-ID: <1294939112-26381-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 905E3103B20
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:16:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <harsha.priya@intel.com>, broonie@opensource.wolfsonmicro.com, selma.bensaid@intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The card debugfs initialization is done in soc_probe but would be better if it
is done when the card in registered

This patch moves the debugfs initialization to register_card()

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <harsha.priya@intel.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 318c3a7..9c5e7cf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1879,8 +1879,6 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
 
-	soc_init_card_debugfs(card);
-
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to register card\n");
@@ -3123,6 +3121,8 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	soc_init_card_debugfs(card);
+
 	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) *
 			    (card->num_links + card->num_aux_devs),
 			    GFP_KERNEL);
-- 
1.7.2.3
