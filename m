From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v2 2/3] ASoC: atmel_wm8904: make it available
	to choose clock
Date: Mon, 27 Jan 2014 14:55:25 +0800
Message-ID: <1390805726-1841-3-git-send-email-voice.shen@atmel.com>
References: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B1F7261B14
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 07:57:22 +0100 (CET)
In-Reply-To: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, nicolas.ferre@atmel.com, Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Make it available to choose the clock from TK pin or RK pin. This
is hardware design decided.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2: None

 sound/soc/atmel/atmel_wm8904.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index b4e3690..9346410 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -108,6 +108,7 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
 	struct device_node *codec_np, *cpu_np;
 	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
 	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
+	struct atmel_ssc_info *ssc_info;
 	int ret;
 
 	if (!np) {
@@ -115,6 +116,15 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ssc_info = devm_kzalloc(&pdev->dev, sizeof(*ssc_info), GFP_KERNEL);
+	if (!ssc_info)
+		return -ENOMEM;
+
+	ssc_info->clk_from_rk_pin =
+		of_property_read_bool(np, "atmel,clk-from-rk-pin");
+
+	card->drvdata = (void *)ssc_info;
+
 	ret = snd_soc_of_parse_card_name(card, "atmel,model");
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse card name\n");
-- 
1.8.5.2
