From: Sergej Sawazki <sergej@taudac.com>
Subject: [PATCH v2] ASoC: wm8741: Set OSR mode in hw_params()
Date: Sun, 10 Feb 2019 16:29:29 +0100
Message-ID: <1549812569-17533-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B61B26748F
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2019 16:29:41 +0100 (CET)
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

For correct operation of the digital filtering and other processing on the
WM8741, the user must ensure the correct value of OSR[1:0] is set at all
times.[1] Hence, depending the selected sampling rate, set the OSR (over-
sampling rate) mode in hw_params().

References:
	[1] "WM8741 Data Sheet"

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
---
Changes in v2:
 * Using update_bits() rather than write().

 sound/soc/codecs/wm8741.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index fdda83b..a4b8c45 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -196,7 +196,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8741_priv *wm8741 = snd_soc_component_get_drvdata(component);
-	unsigned int iface;
+	unsigned int iface, mode;
 	int i;
 
 	/* The set of sample rates that can be supported depends on the
@@ -240,11 +240,21 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* oversampling rate */
+	if (params_rate(params) > 96000)
+		mode = 0x40;
+	else if (params_rate(params) > 48000)
+		mode = 0x20;
+	else
+		mode = 0x00;
+
 	dev_dbg(component->dev, "wm8741_hw_params:    bit size param = %d, rate param = %d",
 		params_width(params), params_rate(params));
 
 	snd_soc_component_update_bits(component, WM8741_FORMAT_CONTROL, WM8741_IWL_MASK,
 			    iface);
+	snd_soc_component_update_bits(component, WM8741_MODE_CONTROL_1, WM8741_OSR_MASK,
+			    mode);
 
 	return 0;
 }
-- 
2.7.4
