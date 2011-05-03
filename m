From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Don't crash on PM operations
Date: Tue,  3 May 2011 18:26:07 +0100
Message-ID: <1304443567-1530-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D2FE1037FF
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 19:25:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The move over to exposing snd_soc_register_card() let the initialisation
of the driver data we use to find the card in PM operations go AWOL. Fix
this by setting the driver data when we register the card.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a823654..f3833f4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3365,6 +3365,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	dev_set_drvdata(card->dev, card);
+
 	snd_soc_initialize_card_lists(card);
 
 	soc_init_card_debugfs(card);
-- 
1.7.4.1
