From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Thu,  8 Aug 2019 14:36:55 +0200
Message-ID: <20190808123655.31520-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan.agner@toradex.com>
List-Id: alsa-devel@alsa-project.org

From: Stefan Agner <stefan.agner@toradex.com>

Deferred probes shouldn't cause error messages in the boot log. Avoid
printing with dev_err() in case EPROBE_DEFER is the return value.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 sound/soc/soc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd6eaae6c0ed..98e1e80b5493 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1985,9 +1985,11 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = soc_init_dai_link(card, dai_link);
-		if (ret) {
+		if (ret && ret != -EPROBE_DEFER) {
 			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
 				dai_link->name, ret);
+		}
+		if (ret) {
 			mutex_unlock(&client_mutex);
 			return ret;
 		}
-- 
2.22.0
