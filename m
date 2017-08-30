From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: fix fallback when
	"label" property isn't present" to the asoc tree
Date: Wed, 30 Aug 2017 18:57:08 +0100
Message-ID: <E1dn7Ei-0001BQ-Ds@debutante>
References: <20170829155122.28606-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CECE2671BA
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 19:57:16 +0200 (CEST)
In-Reply-To: <20170829155122.28606-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple_card_utils: fix fallback when "label" property isn't present

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1b4a56cd7f5c2f835ffae2a8204fb95597269b10 Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Tue, 29 Aug 2017 17:51:22 +0200
Subject: [PATCH] ASoC: simple_card_utils: fix fallback when "label" property
 isn't present

snd_soc_of_parse_card_name() doesn't return an error if the requested
property isn't present, but silently fails to fill the card name. This can
not be changed, as it is a backwards compatibility measure itself.

We can not rely on the return value of this function alone, but must check
if the card name has been filled sucessfully when deciding to skip the
fallback path, which is in place for existing users.

Fixes: dedfaa1eedc7 (ASoC: simple-card-utils: enable "label" on
                     asoc_simple_card_parse_card_name)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 26d64fa40c9c..0442099157e6 100644
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
2.14.1
