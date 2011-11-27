From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix CODEC enumeration for
	auto_nc_codec_pins
Date: Sun, 27 Nov 2011 19:39:50 +0000
Message-ID: <1322422790-828-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85DD2103830
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 20:39:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We need to enumerate all the CODECs that are part of the card we're
instantiating, not all the CODECs that are in the system as the system
may have multiple cards.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 169ab29..e0f4515 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1489,7 +1489,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	snd_soc_dapm_new_widgets(&card->dapm);
 
 	if (card->fully_routed)
-		list_for_each_entry(codec, &codec_list, list)
+		list_for_each_entry(codec, &card->codec_dev_list, card_list)
 			snd_soc_dapm_auto_nc_codec_pins(codec);
 
 	ret = snd_card_register(card->snd_card);
-- 
1.7.7.3
