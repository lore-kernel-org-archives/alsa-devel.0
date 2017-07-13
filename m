From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: spear: spdif_in: constify
	snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 00:57:10 -0500
Message-ID: <20170713055710.GA21105@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.152.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 4047A267099
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 07:57:12 +0200 (CEST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 110FA12120
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 00:57:12 -0500 (CDT)
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
 sound/soc/spear/spdif_in.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 7f32527..d9368e1 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -151,7 +151,7 @@ static int spdif_in_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static struct snd_soc_dai_ops spdif_in_dai_ops = {
+static const struct snd_soc_dai_ops spdif_in_dai_ops = {
 	.shutdown	= spdif_in_shutdown,
 	.trigger	= spdif_in_trigger,
 	.hw_params	= spdif_in_hw_params,
-- 
2.5.0
