From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8711: Fix wrong mask for setting
 input audio data bit length select
Date: Fri, 28 Oct 2011 11:08:01 +0800
Message-ID: <1319771281.3944.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 464AF24523
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Oct 2011 05:08:14 +0200 (CEST)
Received: by gyg8 with SMTP id 8so3886172gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2011 20:08:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The Input Audio Data Bit Length Select is controlled by BIT[3:2] of
WM8711_IFACE(07h) register.
Current code incorrectly masks BIT[1:0] which is for Audio Data Format Select.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8711.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 8d0347c..8ba49d8 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -151,7 +151,7 @@ static int wm8711_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8711_priv *wm8711 =  snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8711_IFACE) & 0xfffc;
+	u16 iface = snd_soc_read(codec, WM8711_IFACE) & 0xfff3;
 	int i = get_coeff(wm8711->sysclk, params_rate(params));
 	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
-- 
1.7.5.4
