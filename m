From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 03/12] ASoC: rt5616: constify snd_soc_dai_ops
	structure
Date: Thu, 13 Jul 2017 15:37:43 -0500
Message-ID: <4be0b8fc4ac7bcb044e588386b1ff23914e0f144.1499974826.git.garsilva@embeddedor.com>
References: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.192.34])
 by alsa0.perex.cz (Postfix) with ESMTP id A7C6A2672A8
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 22:37:45 +0200 (CEST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id B74123938E
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 15:37:44 -0500 (CDT)
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
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/rt5616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 7d6e082..33bdfe7 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1265,7 +1265,7 @@ static int rt5616_resume(struct snd_soc_codec *codec)
 #define RT5616_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5616_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5616_aif_dai_ops = {
 	.hw_params = rt5616_hw_params,
 	.set_fmt = rt5616_set_dai_fmt,
 	.set_sysclk = rt5616_set_dai_sysclk,
-- 
2.5.0
