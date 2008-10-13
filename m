From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Hide TLV320AIC26 configuration option
	for non-OpenFirwmare users
Date: Mon, 13 Oct 2008 17:38:34 +0100
Message-ID: <1223915914-12196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E67FB2453E
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 18:38:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since Kconfig ignores dependencies on select and other users should
select SND_SOC_TLV320AIC26 we can add a dependency on the OpenFirmware
helper to avoid exposing the menu entry to users who can't benefit from
it.

Thanks to Takashi for the suggestion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4975d85..9242889 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -70,6 +70,9 @@ config SND_SOC_TLV320AIC23
 config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support"
 	depends on SPI
+	# Note the Kconfig doesn't enforce dependencies - this just
+	# prevents non-OF users seeing the tristate in menus.
+	depends on SND_SOC_OF_SIMPLE
 
 config SND_SOC_TLV320AIC3X
 	tristate
-- 
1.5.6.5
