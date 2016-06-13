From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: [PATCH v4 7/9] ASoC: bt-sco: extend rate and add a
	general compatible string
Date: Mon, 13 Jun 2016 15:26:44 +0800
Message-ID: <1465802806-19197-8-git-send-email-garlic.tseng@mediatek.com>
References: <1465802806-19197-1-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id E3217261685
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 09:26:55 +0200 (CEST)
In-Reply-To: <1465802806-19197-1-git-send-email-garlic.tseng@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add supports for 16k (wideband BT) and add a general compatible
string "linux,bt-sco"

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 Documentation/devicetree/bindings/sound/bt-sco.txt | 2 +-
 sound/soc/codecs/bt-sco.c                          | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index b084ad1..101b384 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -31,14 +31,14 @@ static struct snd_soc_dai_driver bt_sco_dai = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
 		 .stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 };
@@ -77,6 +77,7 @@ MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
 #if defined(CONFIG_OF)
 static const struct of_device_id bt_sco_codec_of_match[] = {
 	{ .compatible = "delta,dfbmcs320", },
+	{ .compatible = "linux,bt-sco", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bt_sco_codec_of_match);
-- 
1.9.1
