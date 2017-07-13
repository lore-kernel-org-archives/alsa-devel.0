From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 06/12] ASoC: rt5514: constify snd_soc_dai_ops
	structure
Date: Thu, 13 Jul 2017 15:37:59 -0500
Message-ID: <274b7cfa762e8c933bedc09d2f7b8e775ccde02c.1499974826.git.garsilva@embeddedor.com>
References: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
 [192.185.145.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 065412672B2
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 22:38:00 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id 3715F2663A6
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 15:38:00 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <cover.1499974826.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.orgi
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Also, make rt5514_aif_dai_ops static, as it is not used outside this
module.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index a71e630..4ca73bf 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1006,7 +1006,7 @@ static int rt5514_i2c_write(void *context, unsigned int reg, unsigned int val)
 #define RT5514_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5514_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5514_aif_dai_ops = {
 	.hw_params = rt5514_hw_params,
 	.set_fmt = rt5514_set_dai_fmt,
 	.set_sysclk = rt5514_set_dai_sysclk,
-- 
2.5.0
