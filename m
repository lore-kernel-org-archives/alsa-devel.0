From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/2] ASoC: wm8974: add devicetree support
Date: Wed, 16 Dec 2015 13:02:55 +0000
Message-ID: <1450270975-17955-2-git-send-email-mans@mansr.com>
References: <1450270975-17955-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 729722657F8
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 14:02:59 +0100 (CET)
In-Reply-To: <1450270975-17955-1-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This adds devicetree support to the wm8974 codec driver.
With a DT-based kernel, there is no board-specific setting
to select the driver so allow it to be manually chosen.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/soc/codecs/Kconfig  | 3 ++-
 sound/soc/codecs/wm8974.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cfdafc4..e36b14c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -838,7 +838,8 @@ config SND_SOC_WM8971
 	tristate
 
 config SND_SOC_WM8974
-	tristate
+	tristate "Wolfson Microelectronics WM8974 codec"
+	depends on I2C
 
 config SND_SOC_WM8978
 	tristate "Wolfson Microelectronics WM8978 codec"
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 4c29bd2..c284c7b 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -632,9 +632,16 @@ static const struct i2c_device_id wm8974_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8974_i2c_id);
 
+static const struct of_device_id wm8974_of_match[] = {
+       { .compatible = "wlf,wm8974", },
+       { }
+};
+MODULE_DEVICE_TABLE(of, wm8974_of_match);
+
 static struct i2c_driver wm8974_i2c_driver = {
 	.driver = {
 		.name = "wm8974",
+		.of_match_table = wm8974_of_match,
 	},
 	.probe =    wm8974_i2c_probe,
 	.remove =   wm8974_i2c_remove,
-- 
2.6.3
