From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH 1/2] ASoC: fix WM8753 initialization.
Date: Sun, 26 Feb 2012 19:21:53 +0100
Message-ID: <1330280514-32232-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp204.alice.it (smtp204.alice.it [82.57.200.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B27F243E8
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2012 19:22:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
List-Id: alsa-devel@alsa-project.org

Without that fix the wm8753 SPI initialization fails, and then produces
  a kernel panic during boot with the following call trace:
    Unable to handle kernel paging request at virtual address 37386d9b
    [<c01ccafc>] (regmap_get_val_bytes+0x0/0x14) from [<c0243dfc>] (snd_soc_codec_set_cache_io+0x9c/0xcc)
    [<c0243dfc>] (snd_soc_codec_set_cache_io+0x9c/0xcc) from [<c0244a4c>] (wm8753_probe+0x5c/0x1c4)
    [<c0244a4c>] (wm8753_probe+0x5c/0x1c4) from [<c023bb24>] (soc_probe_codec+0x174/0x284)
    [<c023bb24>] (soc_probe_codec+0x174/0x284) from [<c023c2c0>] (snd_soc_instantiate_cards+0x68c/0xe28)
    [<c023c2c0>] (snd_soc_instantiate_cards+0x68c/0xe28) from [<c023d278>] (snd_soc_register_card+0x240/0x2d4)
    [<c023d278>] (snd_soc_register_card+0x240/0x2d4) from [<c023d330>] (soc_probe+0x24/0x40)
    [<c023d330>] (soc_probe+0x24/0x40) from [<c01c3900>] (platform_drv_probe+0x14/0x18)
    [...]

The commit d3398ff05907167f463e119421b053ce043741d1
 ( ASoC: Convert WM8753 to direct regmap API usage ) introduced
 the problem.

Thanks to Lars-Peter Clausen for helping me a bit during the debugging.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 sound/soc/codecs/wm8753.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 21ed75d..98fb921 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1577,6 +1577,9 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 		dev_err(&spi->dev, "Failed to register CODEC: %d\n", ret);
 		goto err_regmap;
 	}
+
+	return 0;
+
 err_regmap:
 	regmap_exit(wm8753->regmap);
 err:
@@ -1632,6 +1635,9 @@ static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
 		goto err_regmap;
 	}
+
+	return 0;
+
 err_regmap:
 	regmap_exit(wm8753->regmap);
 err:
-- 
1.7.4.1
