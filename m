From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: sun4i-i2s: don't try to start up or shut
	down DAI if it's active
Date: Fri, 12 Oct 2018 08:32:54 -0700
Message-ID: <20181012153254.10844-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id BCBFF267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 17:33:21 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so6116093plr.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 08:33:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, Yong Deng <yong.deng@magewell.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we may end up with shutting down I2S if shutdown() was
called for capture substream, but playback is still running.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a9ea329dc046..787b67c4f845 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -649,6 +649,9 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
+	if (dai->active)
+		return 0;
+
 	/* Enable the whole hardware block */
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
 			   SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
@@ -667,6 +670,9 @@ static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
+	if (dai->active)
+		return;
+
 	clk_disable_unprepare(i2s->mod_clk);
 
 	/* Disable our output lines */
-- 
2.19.0
