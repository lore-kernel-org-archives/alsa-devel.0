From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: export snd_soc_register_component
Date: Tue, 26 Mar 2013 16:38:19 -0600
Message-ID: <1364337499-10156-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 546EA261725
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 23:38:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Without this, modules will fail to link against those symbols.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7ae68b0..561d589 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4195,6 +4195,7 @@ error_component_name:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_register_component);
 
 /**
  * snd_soc_unregister_component - Unregister a component from the ASoC core
@@ -4220,6 +4221,7 @@ found:
 	dev_dbg(dev, "ASoC: Unregistered component '%s'\n", cmpnt->name);
 	kfree(cmpnt->name);
 }
+EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
 /* Retrieve a card's name from device tree */
 int snd_soc_of_parse_card_name(struct snd_soc_card *card,
-- 
1.7.10.4
