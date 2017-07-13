From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: zx-i2s: constify snd_soc_dai_ops
	structure
Date: Thu, 13 Jul 2017 00:22:09 -0500
Message-ID: <20170713052208.GA11536@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com
 [192.185.188.18])
 by alsa0.perex.cz (Postfix) with ESMTP id C8DE1267099
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 07:22:11 +0200 (CEST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id 3E9C34028691A
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 00:22:10 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embededdor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/zte/zx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 8bbad1d..9a05659 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -357,7 +357,7 @@ static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(zx_i2s->dai_pclk);
 }
 
-static struct snd_soc_dai_ops zx_i2s_dai_ops = {
+static const struct snd_soc_dai_ops zx_i2s_dai_ops = {
 	.trigger	= zx_i2s_trigger,
 	.hw_params	= zx_i2s_hw_params,
 	.set_fmt	= zx_i2s_set_fmt,
-- 
2.5.0
