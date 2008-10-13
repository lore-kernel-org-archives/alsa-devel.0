From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Hide TLV320AIC26 configuration option
	for non-OpenFirwmare users
Date: Mon, 13 Oct 2008 19:16:14 +0100
Message-ID: <1223921774-10272-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081013181458.GA23014@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 55242245A8
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 20:16:39 +0200 (CEST)
In-Reply-To: <20081013181458.GA23014@opensource.wolfsonmicro.com>
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

Make the visibility of the tristate conditional on having the OpenFirmware
helper code enabed so that users who can't use it don't see the visible
option. Kconfig ignores dependencies for select so other users are
unaffected.

Thanks to Takashi for the suggestion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4975d85..38a0e3b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,7 +68,7 @@ config SND_SOC_TLV320AIC23
 	depends on I2C
 
 config SND_SOC_TLV320AIC26
-	tristate "TI TLV320AIC26 Codec support"
+	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
 	depends on SPI
 
 config SND_SOC_TLV320AIC3X
-- 
1.5.4.3
