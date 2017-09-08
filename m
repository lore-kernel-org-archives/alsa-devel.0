From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/7] ASoC: max98090: reduce verbosity on PLL
	unlock
Date: Fri,  8 Sep 2017 00:13:03 -0500
Message-ID: <20170908051309.19028-2-pierre-louis.bossart@linux.intel.com>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 820FB267400
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 07:13:25 +0200 (CEST)
In-Reply-To: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

'commit b8a3ee820f7b ("ASoC: max98090: Add recovery for PLL lock failure")'
enabled a workaround PLL unlocked issues, but generates annoying
dev_info "PLL unlocked" messages at a 10ms rate, usually on startup.

Move to dev_info_ratelimited. This issue doesn't seem to impact audio
functionality.  This trace is commented out in the GalliumOS patches,
it's better to keep it to check on potential quality issues

Tested on Lenovo 100s (Baytrail Chromebook)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 13bcfb1..f5075d1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2115,7 +2115,7 @@ static void max98090_pll_work(struct work_struct *work)
 	if (!snd_soc_codec_is_active(codec))
 		return;
 
-	dev_info(codec->dev, "PLL unlocked\n");
+	dev_info_ratelimited(codec->dev, "PLL unlocked\n");
 
 	/* Toggle shutdown OFF then ON */
 	snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
-- 
2.9.3
