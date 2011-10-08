From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Ensure all DAPM widgets are
	instantiated with the card
Date: Sat,  8 Oct 2011 17:54:18 +0100
Message-ID: <1318092859-11561-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 782D224436
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Oct 2011 18:54:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Specifically for the widgets added by machine driver late probe functions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b65e3d4..8dc9aba 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1478,6 +1478,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	snd_soc_dapm_new_widgets(&card->dapm);
+
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: failed to register soundcard for %s\n", card->name);
-- 
1.7.6.3
