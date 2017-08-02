From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: codec: add DT support in dmic codec" to the asoc tree
Date: Wed, 02 Aug 2017 18:30:17 +0100
Message-ID: <E1dcxTN-0003oR-2M@debutante>
References: <1500972494-10696-3-git-send-email-arnaud.pouliquen@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500972494-10696-3-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: add DT support in dmic codec

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

>From 29685e207b37ad7f415e4bf21320076c025f3df1 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Date: Tue, 25 Jul 2017 10:48:14 +0200
Subject: [PATCH] ASoC: codec: add DT support in dmic codec

Add of_table to allows DT probing.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/dmic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c82b9dc41e9a..d50f142e2972 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -73,9 +73,15 @@ static int dmic_dev_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:dmic-codec");
 
+static const struct of_device_id dmic_dev_match[] = {
+	{.compatible = "dmic-codec"},
+	{}
+};
+
 static struct platform_driver dmic_driver = {
 	.driver = {
 		.name = "dmic-codec",
+		.of_match_table = dmic_dev_match,
 	},
 	.probe = dmic_dev_probe,
 	.remove = dmic_dev_remove,
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
