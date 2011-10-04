From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/4] ASoC: wm8750: Use snd_soc_update_bits for
 read-modify-write
Date: Tue, 04 Oct 2011 09:57:07 +0800
Message-ID: <1317693427.2688.3.camel@phoenix>
References: <1317693345.2688.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id CED3D243F4
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 03:57:14 +0200 (CEST)
Received: by ywn1 with SMTP id 1so3856ywn.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 18:57:14 -0700 (PDT)
In-Reply-To: <1317693345.2688.1.camel@phoenix>
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
Cc: Richard Purdie <rchard.purdie@linuxfoundation.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8750.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 15f0372..bad400d 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -712,22 +712,14 @@ static int wm8750_probe(struct snd_soc_codec *codec)
 	wm8750_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* set the update bits */
-	reg = snd_soc_read(codec, WM8750_LDAC);
-	snd_soc_write(codec, WM8750_LDAC, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_RDAC);
-	snd_soc_write(codec, WM8750_RDAC, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_LOUT1V);
-	snd_soc_write(codec, WM8750_LOUT1V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_ROUT1V);
-	snd_soc_write(codec, WM8750_ROUT1V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_LOUT2V);
-	snd_soc_write(codec, WM8750_LOUT2V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_ROUT2V);
-	snd_soc_write(codec, WM8750_ROUT2V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_LINVOL);
-	snd_soc_write(codec, WM8750_LINVOL, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8750_RINVOL);
-	snd_soc_write(codec, WM8750_RINVOL, reg | 0x0100);
+	snd_soc_update_bits(codec, WM8750_LDAC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_RDAC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_LOUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_ROUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_LOUT2V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_ROUT2V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_LINVOL, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8750_RINVOL, 0x0100, 0x0100);
 
 	snd_soc_add_controls(codec, wm8750_snd_controls,
 				ARRAY_SIZE(wm8750_snd_controls));
-- 
1.7.4.1
