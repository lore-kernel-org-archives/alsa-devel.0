From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Implement SPI device unregistration
	for WM8731
Date: Wed, 18 Feb 2009 12:56:27 +0000
Message-ID: <1234961787-18435-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218125510.GA11978@opensource.wolfsonmicro.com>
	<1234961787-18435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F3C103897
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:56:35 +0100 (CET)
In-Reply-To: <1234961787-18435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Completely untested.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index a2c478e..4191bdb 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -655,12 +655,17 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 	codec->hw_write = (hw_write_t)wm8731_spi_write;
 	codec->dev = &spi->dev;
 
+	spi->dev.driver_data = wm8731;
+
 	return wm8731_register(wm8731);
 }
 
 static int __devexit wm8731_spi_remove(struct spi_device *spi)
 {
-	/* FIXME: This isn't actually implemented... */
+	struct wm8731_priv *wm8731 = spi->dev.driver_data;
+
+	wm8731_unregister(wm8731);
+
 	return 0;
 }
 
-- 
1.5.6.3
