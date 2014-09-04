From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/9] ASoC: Shutdown DAPM contexts when removing
	a card
Date: Thu,  4 Sep 2014 19:44:05 +0200
Message-ID: <1409852652-27939-3-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D9D926569B
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently when a ASoC sound card is unregistered we leave the individual
components in their current state, just call the remove() callback and leave
it to the drivers to do the proper shutdown/cleanup.

This patch introduces a call to snd_soc_dapm_shutdown() when removing the
card.  This will make sure that all DAPM widgets are properly powered down
and all DAPM contexts are put at the SND_SOC_BIAS_OFF level. This will
ensure that all components are properly powered down when the card is
removed.

Since a lot of drivers manually go to SND_SOC_BIAS_OFF in their remove
callback this will also allow us to remove a bit of duplicated code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 031a19a..42f3690 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3812,6 +3812,7 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 {
 	if (card->instantiated) {
 		card->instantiated = false;
+		snd_soc_dapm_shutdown(card);
 		soc_cleanup_card_resources(card);
 	}
 	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
-- 
1.8.0
