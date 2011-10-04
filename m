From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4] ASoC: wm8711: Use snd_soc_update_bits for
 read-modify-write
Date: Tue, 04 Oct 2011 09:55:45 +0800
Message-ID: <1317693345.2688.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 32E65243F0
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 03:55:56 +0200 (CEST)
Received: by ywn1 with SMTP id 1so2755ywn.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 18:55:55 -0700 (PDT)
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
Cc: Mike Arthur <linux@wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8711.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 8457d3c..6ecf1ab 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -381,10 +381,8 @@ static int wm8711_probe(struct snd_soc_codec *codec)
 	wm8711_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
-	reg = snd_soc_read(codec, WM8711_LOUT1V);
-	snd_soc_write(codec, WM8711_LOUT1V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8711_ROUT1V);
-	snd_soc_write(codec, WM8711_ROUT1V, reg | 0x0100);
+	snd_soc_update_bits(codec, WM8711_LOUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8711_ROUT1V, 0x0100, 0x0100);
 
 	snd_soc_add_controls(codec, wm8711_snd_controls,
 			     ARRAY_SIZE(wm8711_snd_controls));
-- 
1.7.4.1
