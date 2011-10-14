From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8991: Use snd_soc_update_bits for
 read-modify-write
Date: Fri, 14 Oct 2011 12:09:48 +0800
Message-ID: <1318565388.10049.3.camel@phoenix>
References: <1318565280.10049.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1CB29243A2
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 06:09:54 +0200 (CEST)
Received: by ywn1 with SMTP id 1so1993776ywn.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 21:09:54 -0700 (PDT)
In-Reply-To: <1318565280.10049.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8991.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 708d251..c9ab3ba 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1264,7 +1264,6 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 {
 	struct wm8991_priv *wm8991;
 	int ret;
-	unsigned int reg;
 
 	wm8991 = snd_soc_codec_get_drvdata(codec);
 
@@ -1282,19 +1281,18 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 
 	wm8991_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	reg = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_4);
-	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_4, reg | WM8991_ALRCGPIO1);
+	snd_soc_update_bits(codec, WM8991_AUDIO_INTERFACE_4,
+			    WM8991_ALRCGPIO1, WM8991_ALRCGPIO1);
 
-	reg = snd_soc_read(codec, WM8991_GPIO1_GPIO2) &
-	      ~WM8991_GPIO1_SEL_MASK;
-	snd_soc_write(codec, WM8991_GPIO1_GPIO2, reg | 1);
+	snd_soc_update_bits(codec, WM8991_GPIO1_GPIO2,
+			    WM8991_GPIO1_SEL_MASK, 1);
 
-	reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_1);
-	snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, reg | WM8991_VREF_ENA|
-		      WM8991_VMID_MODE_MASK);
+	snd_soc_update_bits(codec, WM8991_POWER_MANAGEMENT_1,
+			    WM8991_VREF_ENA | WM8991_VMID_MODE_MASK,
+			    WM8991_VREF_ENA | WM8991_VMID_MODE_MASK);
 
-	reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_2);
-	snd_soc_write(codec, WM8991_POWER_MANAGEMENT_2, reg | WM8991_OPCLK_ENA);
+	snd_soc_update_bits(codec, WM8991_POWER_MANAGEMENT_2,
+			    WM8991_OPCLK_ENA, WM8991_OPCLK_ENA);
 
 	snd_soc_write(codec, WM8991_DAC_CTRL, 0);
 	snd_soc_write(codec, WM8991_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
-- 
1.7.4.1
