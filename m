From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "MAINTAINERS: add entries for UniPhier ASoC sound drivers" to the asoc tree
Date: Mon, 04 Dec 2017 18:48:24 +0000
Message-ID: <E1eLvmy-0000Gd-N2@debutante>
References: <20171122114321.29196-8-suzuki.katsuhiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171122114321.29196-8-suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: add entries for UniPhier ASoC sound drivers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 576f8f46e7c923f830dfa61924ad547447399b05 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Date: Wed, 22 Nov 2017 20:43:20 +0900
Subject: [PATCH] MAINTAINERS: add entries for UniPhier ASoC sound drivers

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..55ae8ea8722a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12581,6 +12581,12 @@ F:	include/media/soc*
 F:	drivers/media/i2c/soc_camera/
 F:	drivers/media/platform/soc_camera/
 
+SOCIONEXT UNIPHIER SOUND DRIVER
+M:	Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
+L:	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/uniphier/
+
 SOEKRIS NET48XX LED SUPPORT
 M:	Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
 S:	Maintained
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
