From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: wm8961: Convert codec->hw_read to
	regmap_read
Date: Thu, 13 Oct 2011 15:25:20 +0800
Message-ID: <1318490720.2857.11.camel@phoenix>
References: <1318490575.2857.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 651BE1039A7
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 09:25:27 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so1643967ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 00:25:26 -0700 (PDT)
In-Reply-To: <1318490575.2857.8.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

codec->hw_read is broken now, let's covert to regmap_read.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8961.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index cdee810..2fa1672 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -960,6 +960,7 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 	u16 reg;
+	unsigned int val;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
@@ -974,10 +975,10 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 	}
 
 	/* This isn't volatile - readback doesn't correspond to write */
-	reg = codec->hw_read(codec, WM8961_RIGHT_INPUT_VOLUME);
+	regmap_read(codec->control_data, WM8961_RIGHT_INPUT_VOLUME, &val);
 	dev_info(codec->dev, "WM8961 family %d revision %c\n",
-		 (reg & WM8961_DEVICE_ID_MASK) >> WM8961_DEVICE_ID_SHIFT,
-		 ((reg & WM8961_CHIP_REV_MASK) >> WM8961_CHIP_REV_SHIFT)
+		 (val & WM8961_DEVICE_ID_MASK) >> WM8961_DEVICE_ID_SHIFT,
+		 ((val & WM8961_CHIP_REV_MASK) >> WM8961_CHIP_REV_SHIFT)
 		 + 'A');
 
 	ret = wm8961_reset(codec);
-- 
1.7.4.1
