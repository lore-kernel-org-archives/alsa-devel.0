From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Prevent components from being bound
	to multiple cards
Date: Wed,  8 Jul 2015 20:47:43 +0200
Message-ID: <1436381264-6924-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-104.synserver.de (smtp-out-104.synserver.de
 [212.40.185.104])
 by alsa0.perex.cz (Postfix) with ESMTP id DB2EB265A01
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:47:51 +0200 (CEST)
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

A component can only be bound to a single card at a time. Binding it to
card while it is already bound to another will result in undefined
behavior.

As the undefined behavior might only manifest itself later on it is not
necessarily always straight forward to find the cause. To prevent this add
a check that refuses to bind a component to multiple cards as well as
prints a error describing the problem.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8baf87d..d9ae826 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1104,9 +1104,19 @@ static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_dai *dai;
 	int ret;
 
-	if (!strcmp(component->name, "snd-soc-dummy") || component->probed)
+	if (!strcmp(component->name, "snd-soc-dummy"))
 		return 0;
 
+	if (component->probed) {
+		if (component->card != card) {
+			dev_err(component->dev,
+				"Trying to bind component to card \"%s\" but is already bound to card \"%s\"\n",
+				card->name, component->card->name);
+			return -ENODEV;
+		}
+		return 0;
+	}
+
 	component->card = card;
 	dapm->card = card;
 	soc_set_name_prefix(card, component);
-- 
2.1.4
