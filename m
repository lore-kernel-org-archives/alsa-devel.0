From: Koro Chen <koro.chen@mediatek.com>
Subject: [RFC PATCH] ASoC: Modify check condition of multiple bindings of components
Date: Tue, 13 Oct 2015 21:37:57 +0800
Message-ID: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com
Cc: srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, p.zabel@pengutronix.de, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The patch "ASoC: Prevent components from being bound to multiple cards"
adds check to prevent multiple cards from using the same component.
However, snd_soc_register_platform() or snd_soc_register_codec() will
also create components, and sharing the same platform by multiple cards
is then refused. This happens with a platform having multiple
independent DAIs that share the same DMA controller.

Relax the condition by checking component->registered_as_component,
which is only true in case of snd_soc_register_component() and
will be false for components created by snd_soc_register_platform()
or snd_soc_register_codec().

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 42575b0..eca169a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1106,7 +1106,8 @@ static int soc_probe_component(struct snd_soc_card *card,
 		return 0;
 
 	if (component->card) {
-		if (component->card != card) {
+		if (component->card != card &&
+		    component->registered_as_component) {
 			dev_err(component->dev,
 				"Trying to bind component to card \"%s\" but is already bound to card \"%s\"\n",
 				card->name, component->card->name);
-- 
1.7.9.5
