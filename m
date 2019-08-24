From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/6] misc: atmel-ssc: get LRCLK pin selection from DT
Date: Sat, 24 Aug 2019 22:26:56 +0200
Message-ID: <5f1fd1b8f646c5ced1d838c381b6973e5abccd53.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Chas Williams <3chas3@gmail.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Rob Herring <robh-dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Store LRCLK pin selection for use by ASoC DAI driver.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
  v2: split from ASoC implementation

---
 drivers/misc/atmel-ssc.c  | 9 +++++++++
 include/linux/atmel-ssc.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index ab4144ea1f11..1322e29bc37a 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -210,6 +210,15 @@ static int ssc_probe(struct platform_device *pdev)
 		struct device_node *np = pdev->dev.of_node;
 		ssc->clk_from_rk_pin =
 			of_property_read_bool(np, "atmel,clk-from-rk-pin");
+		ssc->lrclk_from_tf_pin =
+			of_property_read_bool(np, "atmel,lrclk-from-tf-pin");
+		ssc->lrclk_from_rf_pin =
+			of_property_read_bool(np, "atmel,lrclk-from-rf-pin");
+
+		if (ssc->lrclk_from_tf_pin && ssc->lrclk_from_rf_pin) {
+			dev_err(&pdev->dev, "both LRCLK from RK/TK options found in DT node");
+			return -EINVAL;
+		}
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 6091d2abc1eb..fbe1c2ffaa81 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -21,6 +21,8 @@ struct ssc_device {
 	int			user;
 	int			irq;
 	bool			clk_from_rk_pin;
+	bool			lrclk_from_tf_pin;
+	bool			lrclk_from_rf_pin;
 	bool			sound_dai;
 };
 
-- 
2.20.1
