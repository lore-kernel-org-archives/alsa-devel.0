From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: mediatek: mt2701: constify
	snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 01:10:19 -0500
Message-ID: <20170713061019.GA24134@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.143.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 53B09267099
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 08:10:26 +0200 (CEST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 616AE1543C
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 01:10:25 -0500 (CDT)
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
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index bc5d4db..10dcd69 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -595,7 +595,7 @@ static const struct snd_soc_dai_ops mt2701_afe_i2s_ops = {
 };
 
 /* MRG BE DAIs */
-static struct snd_soc_dai_ops mt2701_btmrg_ops = {
+static const struct snd_soc_dai_ops mt2701_btmrg_ops = {
 	.startup = mt2701_btmrg_startup,
 	.shutdown = mt2701_btmrg_shutdown,
 	.hw_params = mt2701_btmrg_hw_params,
-- 
2.5.0
