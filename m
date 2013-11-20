From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 01/11] wm8962: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:41 -0200
Message-ID: <1384969072-25906-2-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f52.google.com (mail-yh0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 603A3261AC1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:05 +0100 (CET)
Received: by mail-yh0-f52.google.com with SMTP id i72so2414753yha.39
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:04 -0800 (PST)
In-Reply-To: <1384969072-25906-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the IS_ENABLED() macro can make the code shorter and simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 543c5c2..07da601 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -74,7 +74,7 @@ struct wm8962_priv {
 	struct regulator_bulk_data supplies[WM8962_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8962_NUM_SUPPLIES];
 
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#if IS_ENABLED(CONFIG_INPUT)
 	struct input_dev *beep;
 	struct work_struct beep_work;
 	int beep_rate;
@@ -3108,7 +3108,7 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(wm8962_mic_detect);
 
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#if IS_ENABLED(CONFIG_INPUT)
 static int beep_rates[] = {
 	500, 1000, 2000, 4000,
 };
-- 
1.8.1.2
