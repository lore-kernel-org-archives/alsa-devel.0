From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: soc-core: enable "dai-format" on snd_soc_of_parse_daifmt()" to the asoc tree
Date: Wed, 17 May 2017 10:53:06 +0100
Message-ID: <E1dAvdi-00070a-N4@debutante>
References: <87h91mxww7.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h91mxww7.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: enable "dai-format" on snd_soc_of_parse_daifmt()

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

>From 5711c97920377827da4bbc18233ffb08c6e3bbef Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 20 Apr 2017 01:33:24 +0000
Subject: [PATCH] ASoC: soc-core: enable "dai-format" on
 snd_soc_of_parse_daifmt()

Current snd_soc_of_parse_daifmt() detects [prefix]format, but
"format" was unclear in some case. This patch checks "dai-format"
first, and try to check "[prefix]format" if "dai-format" was not
exist.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/soc-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aae099c0e502..ab7a07f86ab8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3960,11 +3960,15 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 		prefix = "";
 
 	/*
-	 * check "[prefix]format = xxx"
+	 * check "dai-format = xxx"
+	 * or    "[prefix]format = xxx"
 	 * SND_SOC_DAIFMT_FORMAT_MASK area
 	 */
-	snprintf(prop, sizeof(prop), "%sformat", prefix);
-	ret = of_property_read_string(np, prop, &str);
+	ret = of_property_read_string(np, "dai-format", &str);
+	if (ret < 0) {
+		snprintf(prop, sizeof(prop), "%sformat", prefix);
+		ret = of_property_read_string(np, prop, &str);
+	}
 	if (ret == 0) {
 		for (i = 0; i < ARRAY_SIZE(of_fmt_table); i++) {
 			if (strcmp(str, of_fmt_table[i].name) == 0) {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
