From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: simple-card-utils: enable "label" on asoc_simple_card_parse_card_name" to the asoc tree
Date: Wed, 17 May 2017 10:53:00 +0100
Message-ID: <E1dAvdc-0006zV-8R@debutante>
References: <877f2foog1.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877f2foog1.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: enable "label" on asoc_simple_card_parse_card_name

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

>From dedfaa1eedc7309252989a7defab4d565a9f481b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 20 Apr 2017 01:34:49 +0000
Subject: [PATCH] ASoC: simple-card-utils: enable "label" on
 asoc_simple_card_parse_card_name

Current asoc_simple_card_parse_card_name() detects [prefix]name,
but in generally, we uses "label" for user visible names.
This patch enables it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/generic/simple-card-utils.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 343b291fc372..c5ab8ad2a5ce 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -81,15 +81,21 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_set_dailink_name);
 int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 				     char *prefix)
 {
-	char prop[128];
 	int ret;
 
-	snprintf(prop, sizeof(prop), "%sname", prefix);
+	if (!prefix)
+		prefix = "";
 
 	/* Parse the card name from DT */
-	ret = snd_soc_of_parse_card_name(card, prop);
-	if (ret < 0)
-		return ret;
+	ret = snd_soc_of_parse_card_name(card, "label");
+	if (ret < 0) {
+		char prop[128];
+
+		snprintf(prop, sizeof(prop), "%sname", prefix);
+		ret = snd_soc_of_parse_card_name(card, prop);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (!card->name && card->dai_link)
 		card->name = card->dai_link->name;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
