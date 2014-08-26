From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: rt5640: Do not allow regmap to use bulk read-write operations
Date: Tue, 26 Aug 2014 17:03:13 +0300
Message-ID: <1409061793-10495-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1409061793-10495-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409061793-10495-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org

Debugging showed Realtek RT5642 doesn't support autoincrementing writes so
driver should set the use_single_rw flag for regmap.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
I'm not sure is this specific only to RT5642? I was thinking that because
commit 4c9185be5e8e ("ASoC: rt5640: Move cache sync() to resume()") is way
after 75a5f89f635c ("regmap: cache: Write consecutive registers in a single
block write") which started to use block writes during rbtree sync.
Or maybe 4c9185be5e8e was done on top of older kernel?
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6bc6efdec550..f1ec6e6bd08a 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2059,6 +2059,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
 static const struct regmap_config rt5640_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
+	.use_single_rw = true,
 
 	.max_register = RT5640_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5640_ranges) *
 					       RT5640_PR_SPACING),
-- 
2.1.0
