From: Colin King <colin.king@canonical.com>
Subject: [PATCH] gpiolib: remove unused variable 'i'
Date: Tue, 30 May 2017 10:44:20 +0100
Message-ID: <20170530094420.31076-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Fixes smatch warning: unused variable 'i' [-Wunused-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpio/gpiolib.c                   | 2 --
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index be8097097326..62ffb4e293d2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1471,8 +1471,6 @@ static struct gpio_chip *find_chip_by_name(const char *name)
 
 static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gpiochip)
 {
-	int i;
-
 	if (!gpiochip->irq_need_valid_mask)
 		return 0;
 
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index c5c52d1f500c..e15f63c74f59 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -246,7 +246,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 			continue;
 
 		if (rcpu_ep != cpu_ep) {
-			dev_err(dev, "remote-endpoint missmatch (%s/%s/%s)\n",
+			dev_err(dev, "remote-endpoint mismatch (%s/%s/%s)\n",
 				cpu_ep->name, codec_ep->name, rcpu_ep->name);
 			ret = -EINVAL;
 			goto parse_of_err;
-- 
2.11.0

