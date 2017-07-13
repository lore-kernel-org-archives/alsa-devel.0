From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: zx-tdm: constify snd_soc_dai_ops
	structure
Date: Thu, 13 Jul 2017 00:30:52 -0500
Message-ID: <20170713053052.GA13749@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com
 [192.185.197.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9ED267099
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 07:31:00 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id 5ABDB407A2036
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 00:30:59 -0500 (CDT)
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
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/zte/zx-tdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index bd632cc..dc95527 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -309,7 +309,7 @@ static void zx_tdm_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(zx_tdm->dai_wclk);
 }
 
-static struct snd_soc_dai_ops zx_tdm_dai_ops = {
+static const struct snd_soc_dai_ops zx_tdm_dai_ops = {
 	.trigger	= zx_tdm_trigger,
 	.hw_params	= zx_tdm_hw_params,
 	.set_fmt	= zx_tdm_set_fmt,
-- 
2.5.0
