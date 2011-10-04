From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] ASoC: wm8988: Use snd_soc_update_bits for
 read-modify-write
Date: Tue, 04 Oct 2011 09:59:26 +0800
Message-ID: <1317693566.2688.6.camel@phoenix>
References: <1317693345.2688.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D593C243F5
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 03:59:32 +0200 (CEST)
Received: by gyg4 with SMTP id 4so4938gyg.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 18:59:32 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8988.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index d7170f1..5099e62 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -774,16 +774,11 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 	}
 
 	/* set the update bits (we always update left then right) */
-	reg = snd_soc_read(codec, WM8988_RADC);
-	snd_soc_write(codec, WM8988_RADC, reg | 0x100);
-	reg = snd_soc_read(codec, WM8988_RDAC);
-	snd_soc_write(codec, WM8988_RDAC, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8988_ROUT1V);
-	snd_soc_write(codec, WM8988_ROUT1V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8988_ROUT2V);
-	snd_soc_write(codec, WM8988_ROUT2V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8988_RINVOL);
-	snd_soc_write(codec, WM8988_RINVOL, reg | 0x0100);
+	snd_soc_update_bits(codec, WM8988_RADC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8988_RDAC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8988_ROUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8988_ROUT2V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8988_RINVOL, 0x0100, 0x0100);
 
 	wm8988_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.7.4.1
