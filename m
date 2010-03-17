From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: remove a card from the list,
	if instantiation failed
Date: Wed, 17 Mar 2010 22:06:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1003172202050.4354@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0239610380B
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 22:06:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

If instantiation of a card failed, we have to remove it from the card 
list. This fixes an Oops on Migo-R, triggering, when after a failed 
firmware load attempt the driver modules are removed and re-inserted 
again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Should also be good for stable.

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c8b0556..307eea0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2361,6 +2361,8 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	list_add(&card->list, &card_list);
 	snd_soc_instantiate_cards();
+	if (!card->instantiated)
+		list_del(&card->list);
 	mutex_unlock(&client_mutex);
 
 	dev_dbg(card->dev, "Registered card '%s'\n", card->name);
