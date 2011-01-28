From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/7] ASoC: Move card list initialization to
	snd_soc_register_card
Date: Fri, 28 Jan 2011 14:26:35 -0700
Message-ID: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE142441F
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 22:26:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

All ASoC cards need snd_soc_initialize_card_lists called. Previously, it was
only called for cards backed by a "soc-audio" platform device, via
soc_probe(). However, it's also needed for cards backed by other platform
devices, and registered directly via snd_soc_register_card().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9dfbb8f..3feddd9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1881,7 +1881,6 @@ static int soc_probe(struct platform_device *pdev)
 
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
-	snd_soc_initialize_card_lists(card);
 
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
@@ -3122,6 +3121,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	snd_soc_initialize_card_lists(card);
+
 	soc_init_card_debugfs(card);
 
 	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) *
-- 
1.7.1
