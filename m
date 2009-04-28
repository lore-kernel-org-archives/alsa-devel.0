From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/17] ASoC: Include WM8350 register
	definitions in CODEC header
Date: Tue, 28 Apr 2009 16:23:31 +0100
Message-ID: <1240932222-3718-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4DD8103884
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:45 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
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

It's expected behaviour for the CODEC header to provide them but the
WM8350 doesn't due to having all the registers together under drivers/mfd.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8350.h b/sound/soc/codecs/wm8350.h
index d11bd92..d088eb4 100644
--- a/sound/soc/codecs/wm8350.h
+++ b/sound/soc/codecs/wm8350.h
@@ -13,6 +13,7 @@
 #define _WM8350_H
 
 #include <sound/soc.h>
+#include <linux/mfd/wm8350/audio.h>
 
 extern struct snd_soc_dai wm8350_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8350;
-- 
1.6.2.4
