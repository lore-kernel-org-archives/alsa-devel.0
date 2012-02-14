From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: core: Fix snd_soc_add_card_controls to
	pass correct data
Date: Tue, 14 Feb 2012 15:56:33 -0700
Message-ID: <1329260193-9757-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 542EA2437A
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 23:56:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Commit 022658b "ASoC: core: Add support for DAI and machine kcontrols."
created new functions to create controls for cards, codecs, platforms,
and DAIs. The new snd_soc_add_card_controls() passed the wrong "data" to
utility function snd_soc_add_controls(); it should be passing a codec,
but instead ended up passing the soc_card. Fix this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8bd9995..e44b6f6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2095,9 +2095,13 @@ int snd_soc_add_card_controls(struct snd_soc_card *soc_card,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = soc_card->snd_card;
+	struct snd_soc_codec *codec =
+			list_first_entry(&soc_card->codec_dev_list,
+					 struct snd_soc_codec,
+					 card_list);
 
 	return snd_soc_add_controls(card, soc_card->dev, controls, num_controls,
-			NULL, soc_card);
+			NULL, codec);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_card_controls);
 
-- 
1.7.0.4
