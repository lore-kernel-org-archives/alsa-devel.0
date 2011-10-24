From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: wm8940: Fix a typo for the mask of
 setting WM8940_BCLKDIV
Date: Mon, 24 Oct 2011 11:33:55 +0800
Message-ID: <1319427235.5773.4.camel@phoenix>
References: <1319427161.5773.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 37F21244AC
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 05:34:02 +0200 (CEST)
Received: by ggnk1 with SMTP id k1so5660122ggn.38
	for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2011 20:34:01 -0700 (PDT)
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

The registers are 16 bits, thus remove an extra F for the mask.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8940.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 3cc3bce..fec3892 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -619,7 +619,7 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8940_BCLKDIV:
-		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFEF3;
+		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFEF3;
 		ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 2));
 		break;
 	case WM8940_MCLKDIV:
-- 
1.7.5.4
