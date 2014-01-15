From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: core: Return -ENOTSUPP from set_sysclk()
	if no operation provided
Date: Wed, 15 Jan 2014 19:06:04 +0000
Message-ID: <1389812764-17812-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CF7C2608C9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2014 20:06:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, Xiubo Li <Li.Xiubo@freescale.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Make it easier for generic code to work with set_sysclk() by distinguishing
between the operation not being supported and an error as is done for
other operations like set_dai_fmt()

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a128f0cd752..fe1df50805a3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3485,7 +3485,7 @@ int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		return dai->codec->driver->set_sysclk(dai->codec, clk_id, 0,
 						      freq, dir);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 
@@ -3506,7 +3506,7 @@ int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 		return codec->driver->set_sysclk(codec, clk_id, source,
 						 freq, dir);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_sysclk);
 
-- 
1.8.5.2
