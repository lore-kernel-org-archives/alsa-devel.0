From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: register irq handler for mic1
	detect
Date: Tue, 12 Aug 2014 12:43:49 +0100
Message-ID: <1407843829-4908-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 188AE264F10
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 13:43:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 247b390..24bcbe3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4099,6 +4099,15 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 				dev_warn(codec->dev,
 					 "Failed to request Mic1 detect IRQ: %d\n",
 					 ret);
+		} else {
+			ret = wm8994_request_irq(wm8994->wm8994,
+					WM8994_IRQ_MIC1_DET,
+					wm8994_mic_irq, "Mic 1 detect",
+					wm8994);
+			if (ret != 0)
+				dev_warn(codec->dev,
+				"Failed to request Mic1 detect IRQ: %d\n",
+				ret);
 		}
 
 		ret = wm8994_request_irq(wm8994->wm8994,
-- 
1.7.9.5
