From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: Intel: Atom: constify snd_soc_dai_ops
	structures
Date: Thu, 13 Jul 2017 01:26:06 -0500
Message-ID: <20170713062606.GA27121@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
 [192.185.46.187])
 by alsa0.perex.cz (Postfix) with ESMTP id C7372266C3C
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 08:26:08 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 9038D1E6
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 01:26:07 -0500 (CDT)
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
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index b082b31..49c7b88 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -471,7 +471,7 @@ static void sst_disable_ssp(struct snd_pcm_substream *substream,
 	}
 }
 
-static struct snd_soc_dai_ops sst_media_dai_ops = {
+static const struct snd_soc_dai_ops sst_media_dai_ops = {
 	.startup = sst_media_open,
 	.shutdown = sst_media_close,
 	.prepare = sst_media_prepare,
@@ -480,11 +480,11 @@ static struct snd_soc_dai_ops sst_media_dai_ops = {
 	.mute_stream = sst_media_digital_mute,
 };
 
-static struct snd_soc_dai_ops sst_compr_dai_ops = {
+static const struct snd_soc_dai_ops sst_compr_dai_ops = {
 	.mute_stream = sst_media_digital_mute,
 };
 
-static struct snd_soc_dai_ops sst_be_dai_ops = {
+static const struct snd_soc_dai_ops sst_be_dai_ops = {
 	.startup = sst_enable_ssp,
 	.hw_params = sst_be_hw_params,
 	.set_fmt = sst_set_format,
-- 
2.5.0
