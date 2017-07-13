From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: Intel: Skylake: constify snd_soc_dai_ops
	structures
Date: Thu, 13 Jul 2017 01:16:46 -0500
Message-ID: <20170713061646.GA25608@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com
 [192.185.51.36])
 by alsa0.perex.cz (Postfix) with ESMTP id D87CC267099
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 08:16:48 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway24.websitewelcome.com (Postfix) with ESMTP id 689FF3393
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 01:16:47 -0500 (CDT)
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

These structures are only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 0ebea34a..b1f2dba 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -628,7 +628,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_dai_ops skl_pcm_dai_ops = {
+static const struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.startup = skl_pcm_open,
 	.shutdown = skl_pcm_close,
 	.prepare = skl_pcm_prepare,
@@ -637,15 +637,15 @@ static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.trigger = skl_pcm_trigger,
 };
 
-static struct snd_soc_dai_ops skl_dmic_dai_ops = {
+static const struct snd_soc_dai_ops skl_dmic_dai_ops = {
 	.hw_params = skl_be_hw_params,
 };
 
-static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
+static const struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
 	.hw_params = skl_be_hw_params,
 };
 
-static struct snd_soc_dai_ops skl_link_dai_ops = {
+static const struct snd_soc_dai_ops skl_link_dai_ops = {
 	.prepare = skl_link_pcm_prepare,
 	.hw_params = skl_link_hw_params,
 	.hw_free = skl_link_hw_free,
-- 
2.5.0
