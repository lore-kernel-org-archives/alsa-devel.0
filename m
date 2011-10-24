From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH 3/3] ASoC: wm8940: Do not left shift the
 div parameter in wm8940_set_dai_clkdiv
Date: Mon, 24 Oct 2011 11:35:12 +0800
Message-ID: <1319427312.5773.6.camel@phoenix>
References: <1319427161.5773.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id A63B5244AC
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 05:35:19 +0200 (CEST)
Received: by ywp31 with SMTP id 31so2066889ywp.38
	for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2011 20:35:18 -0700 (PDT)
In-Reply-To: <1319427161.5773.3.camel@phoenix>
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

Just check with other codec drivers, we do left shit div for
the corresponding bits from the caller in all other drivers.
I don't find the caller calling wm8940_set_dai_clkdiv now,
just make the behavior consistent with other drivers.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8940.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index fec3892..72cec5b 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -620,15 +620,15 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	switch (div_id) {
 	case WM8940_BCLKDIV:
 		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFEF3;
-		ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 2));
+		ret = snd_soc_write(codec, WM8940_CLOCK, reg | div);
 		break;
 	case WM8940_MCLKDIV:
 		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFF1F;
-		ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 5));
+		ret = snd_soc_write(codec, WM8940_CLOCK, reg | div);
 		break;
 	case WM8940_OPCLKDIV:
 		reg = snd_soc_read(codec, WM8940_GPIO) & 0xFFCF;
-		ret = snd_soc_write(codec, WM8940_GPIO, reg | (div << 4));
+		ret = snd_soc_write(codec, WM8940_GPIO, reg | div);
 		break;
 	}
 	return ret;
-- 
1.7.5.4
