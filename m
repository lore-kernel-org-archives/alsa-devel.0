From: Sergej Sawazki <sergej@taudac.com>
Subject: [PATCH 2/3] ASoC: wm8741: Set OSR mode in hw_params()
Date: Mon,  4 Sep 2017 21:34:12 +0200
Message-ID: <1504553653-8144-3-git-send-email-sergej@taudac.com>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 2876A266EAF
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 21:34:51 +0200 (CEST)
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

For correct operation of the digital filtering and other processing on the
WM8741, the user must ensure the correct value of OSR[1:0] is set at all
times.[1] Hence, depending the selected sampling rate, set the OSR (over-
sampling rate) mode in hw_params().

References:
	[1] https://d3uzseaevmutz1.cloudfront.net/pubs/proDatasheet/WM8741_v4.3.pdf
	    "WM8741 Data Sheet"

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
---
 sound/soc/codecs/wm8741.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index d552a8a..7e8a7fe 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -197,6 +197,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
+	u16 mode = snd_soc_read(codec, WM8741_MODE_CONTROL_1) & 0x183;
 	int i;
 
 	/* The set of sample rates that can be supported depends on the
@@ -220,6 +221,12 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* oversampling rate */
+	if (params_rate(params) > 96000)
+		mode |= 0x0040;
+	else if (params_rate(params) > 48000)
+		mode |= 0x0020;
+
 	/* bit size */
 	switch (params_width(params)) {
 	case 16:
@@ -243,6 +250,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 		params_width(params), params_rate(params));
 
 	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
+	snd_soc_write(codec, WM8741_MODE_CONTROL_1, mode);
 	return 0;
 }
 
-- 
2.7.4
