From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: rt5670: Fix arguments to set_sysclk
Date: Thu, 29 Jun 2017 13:16:51 +0530
Message-ID: <1498722411-2387-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7335C266E2C
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 10:02:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

set_sysclk expects pointer to snd_soc_codec. Fix it.

Fixes: 6c28ce3c425e ("ASoC: rt5670: move set_sysclk to codec level")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
CC: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 10fec7cdf1a1..0ec7985ed306 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2442,7 +2442,7 @@ static int rt5670_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int rt5670_set_codec_sysclk(struct snd_soc_dai *dai, int clk_id,
+static int rt5670_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 				   int source, unsigned int freq, int dir)
 {
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
-- 
1.9.1
