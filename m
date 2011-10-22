From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8400: Fix setting Fout clock divider
 for FLL Control 4
Date: Sat, 22 Oct 2011 22:48:27 +0800
Message-ID: <1319294907.2678.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C9DC710384C
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 16:48:41 +0200 (CEST)
Received: by ywp31 with SMTP id 31so1319767ywp.38
	for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2011 07:48:40 -0700 (PDT)
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

What we want here is to clear the WM8400_FLL_OUTDIV_MASK bits then
OR with factors.outdiv.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8400.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index dc13be2..f29bc26 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1059,7 +1059,7 @@ static int wm8400_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	wm8400_write(codec, WM8400_FLL_CONTROL_3, factors.n);
 
 	reg = wm8400_read(codec, WM8400_FLL_CONTROL_4);
-	reg &= WM8400_FLL_OUTDIV_MASK;
+	reg &= ~WM8400_FLL_OUTDIV_MASK;
 	reg |= factors.outdiv;
 	wm8400_write(codec, WM8400_FLL_CONTROL_4, reg);
 
-- 
1.7.5.4
