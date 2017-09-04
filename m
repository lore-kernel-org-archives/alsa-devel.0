From: Sergej Sawazki <sergej@taudac.com>
Subject: [PATCH 3/3] ASoC: wm8741: Set SR mode in hw_params()
Date: Mon,  4 Sep 2017 21:34:13 +0200
Message-ID: <1504553653-8144-4-git-send-email-sergej@taudac.com>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id CD7A32669DB
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 21:34:52 +0200 (CEST)
In-Reply-To: <1504553653-8144-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Sergej Sawazki <sergej@taudac.com>
List-Id: alsa-devel@alsa-project.org

Set the ratio of MCLK/LRCLK in hw_params() instead of relying on the
auto-detection.

The ratio of MCLK/LRCLK is known to the driver, there is no need to let
the device to detect it.

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
---
 sound/soc/codecs/wm8741.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 7e8a7fe..534741b 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -198,7 +198,6 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
 	u16 mode = snd_soc_read(codec, WM8741_MODE_CONTROL_1) & 0x183;
-	int i;
 
 	/* The set of sample rates that can be supported depends on the
 	 * MCLK supplied to the CODEC - enforce this.
@@ -209,13 +208,27 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Find a supported LRCLK rate */
-	for (i = 0; i < wm8741->sysclk_constraints->count; i++) {
-		if (wm8741->sysclk_constraints->list[i] == params_rate(params))
-			break;
-	}
-
-	if (i == wm8741->sysclk_constraints->count) {
+	/* MCLK to LRCLK sampling rate ratio */
+	switch (wm8741->sysclk / params_rate(params)) {
+	case 128:
+		mode |= 0x0004;
+		break;
+	case 192:
+		mode |= 0x0008;
+		break;
+	case 256:
+		mode |= 0x000C;
+		break;
+	case 384:
+		mode |= 0x0010;
+		break;
+	case 512:
+		mode |= 0x0014;
+		break;
+	case 768:
+		mode |= 0x0018;
+		break;
+	default:
 		dev_err(codec->dev, "LRCLK %d unsupported with MCLK %d\n",
 			params_rate(params), wm8741->sysclk);
 		return -EINVAL;
-- 
2.7.4
