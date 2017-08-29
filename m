From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ASoC: simple_card_utils: fix fallback when
	"label" property isn't present
Date: Tue, 29 Aug 2017 17:51:22 +0200
Message-ID: <20170829155122.28606-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 3F66E266C6D
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 17:52:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

snd_soc_of_parse_card_name() doesn't return an error if the requested
property isn't present, but silently fails to fill the card name. This can
not be changed, as it is a backwards compatibility measure itself.

We can not rely on the return value of this function alone, but must check
if the card name has been filled sucessfully when deciding to skip the
fallback path, which is in place for existing users.

Fixes: dedfaa1eedc7 (ASoC: simple-card-utils: enable "label" on
                     asoc_simple_card_parse_card_name)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
This may be applied instead of the revert I just sent. After examining the
function more closely, the fix seems easy enough to go into 4.13 final.
---
 sound/soc/generic/simple-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 7d7ab4aee42e..d72f7d58102f 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -132,7 +132,7 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 
 	/* Parse the card name from DT */
 	ret = snd_soc_of_parse_card_name(card, "label");
-	if (ret < 0) {
+	if (ret < 0 || !card->name) {
 		char prop[128];
 
 		snprintf(prop, sizeof(prop), "%sname", prefix);
-- 
2.11.0
