From: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [alsa-devel] [PATCH 2/4] ASoC: bt-sco: extend rate and add a general
 compatible string
Date: Mon, 4 Jul 2016 18:56:26 +0800
Message-ID: <1467629788-14411-3-git-send-email-garlic.tseng@mediatek.com>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467629788-14411-1-git-send-email-garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ir.lian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, PC.Liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add supports for 16k (wideband BT) and add a general compatible
string "linux,bt-sco"

Signed-off-by: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/bt-sco.txt |  2 +-
 sound/soc/codecs/bt-sco.c                          | 52 +++++++++++++++-------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/bt-sco.txt b/Documentation/devicetree/bindings/sound/bt-sco.txt
index 29b8e5d..641edf7 100644
--- a/Documentation/devicetree/bindings/sound/bt-sco.txt
+++ b/Documentation/devicetree/bindings/sound/bt-sco.txt
@@ -4,7 +4,7 @@ This device support generic Bluetooth SCO link.
 
 Required properties:
 
-  - compatible : "delta,dfbmcs320"
+  - compatible : "delta,dfbmcs320" or "linux,bt-sco"
 
 Example:
 
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index b084ad1..2a8d0ee 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -25,22 +25,41 @@ static const struct snd_soc_dapm_route bt_sco_routes[] = {
 	{ "TX", NULL, "Playback" },
 };
 
-static struct snd_soc_dai_driver bt_sco_dai = {
-	.name = "bt-sco-pcm",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.capture = {
-		 .stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+static struct snd_soc_dai_driver bt_sco_dai[] = {
+	{
+		.name = "bt-sco-pcm",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			 .stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
 	},
+	{
+		.name = "bt-sco-pcm-wb",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			 .stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	}
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
@@ -53,7 +72,7 @@ static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
 static int bt_sco_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_bt_sco,
-			&bt_sco_dai, 1);
+				      bt_sco_dai, ARRAY_SIZE(bt_sco_dai));
 }
 
 static int bt_sco_remove(struct platform_device *pdev)
@@ -77,6 +96,7 @@ MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 #if defined(CONFIG_OF)
 static const struct of_device_id bt_sco_codec_of_match[] = {
 	{ .compatible = "delta,dfbmcs320", },
+	{ .compatible = "linux,bt-sco", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bt_sco_codec_of_match);
-- 
1.9.1
