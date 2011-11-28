From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: AD193X: Make enum items const char * const
Date: Mon, 28 Nov 2011 17:28:08 +0100
Message-ID: <1322497692-27868-3-git-send-email-lars@metafoo.de>
References: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 7da7e29..665af5c 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -30,7 +30,7 @@ struct ad193x_priv {
 /*
  * AD193X volume/mute/de-emphasis etc. controls
  */
-static const char *ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};
+static const char * const ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};
 
 static const struct soc_enum ad193x_deemp_enum =
 	SOC_ENUM_SINGLE(AD193X_DAC_CTRL2, 1, 4, ad193x_deemp);
-- 
1.7.7.3
