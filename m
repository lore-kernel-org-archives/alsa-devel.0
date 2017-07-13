From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: hisilicon: constify snd_soc_dai_ops
	structure
Date: Thu, 13 Jul 2017 02:08:53 -0500
Message-ID: <20170713070853.GA29230@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com
 [192.185.51.56])
 by alsa0.perex.cz (Postfix) with ESMTP id DA424266B7E
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 09:08:55 +0200 (CEST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway24.websitewelcome.com (Postfix) with ESMTP id 66EDA6272
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 02:08:54 -0500 (CDT)
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
 sound/soc/hisilicon/hi6210-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index b193d3b..0c8f86d 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -517,7 +517,7 @@ static int hi6210_i2s_dai_probe(struct snd_soc_dai *dai)
 }
 
 
-static struct snd_soc_dai_ops hi6210_i2s_dai_ops = {
+static const struct snd_soc_dai_ops hi6210_i2s_dai_ops = {
 	.trigger	= hi6210_i2s_trigger,
 	.hw_params	= hi6210_i2s_hw_params,
 	.set_fmt	= hi6210_i2s_set_fmt,
-- 
2.5.0
