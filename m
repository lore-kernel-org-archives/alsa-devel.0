From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 4/5] ASoC: wm8960: add support for big-endian
	audio samples
Date: Fri, 14 Sep 2012 16:14:37 -0500
Message-ID: <1347657278-25295-4-git-send-email-timur@freescale.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 by alsa0.perex.cz (Postfix) with ESMTP id E9F81265E52
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 23:15:17 +0200 (CEST)
In-Reply-To: <1347657278-25295-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

PowerPC ASoC drivers frequently use the _BE variants of the SNDRV_PCM_FORMAT
macros, so we need to look for those as well.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/wm8960.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 8740423..782faa0 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -557,18 +557,25 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
+	snd_pcm_format_t format = params_format(params);
 	int i;
 
 	/* bit size */
-	switch (params_format(params)) {
+	switch (format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
 		break;
 	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
 		iface |= 0x0004;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_BE:
 		iface |= 0x0008;
 		break;
+	default:
+		dev_err(codec->dev, "unsupported format %i\n", format);
+		return -EINVAL;
 	}
 
 	/* Update filters for the new rate */
-- 
1.7.3.4
