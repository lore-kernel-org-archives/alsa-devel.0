From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/10] ASoC: Fix register cache size for UDA1380
Date: Wed, 11 Jun 2008 13:47:07 +0100
Message-ID: <1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C91524820
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:17 +0200 (CEST)
In-Reply-To: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

The register cache size is used by the codec_reg sysfs file which works in
terms of the register cache access functions rather than in terms of raw
access to the cache so the size specified needs to be in terms of the
number of elements.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/uda1380.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index cb50486..6d5335b 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -655,8 +655,8 @@ static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
 				   GFP_KERNEL);
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
-	codec->reg_cache_size = sizeof(uda1380_reg);
-	codec->reg_cache_step = 2;
+	codec->reg_cache_size = ARRAY_SIZE(uda1380_reg);
+	codec->reg_cache_step = 1;
 	uda1380_reset(codec);
 
 	/* register pcms */
-- 
1.5.5.3
