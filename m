From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ssm4567: Reset device before
	regcache_sync()
Date: Wed, 27 Jan 2016 14:26:18 +0100
Message-ID: <1453901178-11343-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DED26044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 14:26:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Harsha Priya <harshapriya.n@intel.com>, Yang A Fang <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

When the ssm4567 is powered up the driver calles regcache_sync() to restore
the register map content. regcache_sync() assumes that the device is in its
power-on reset state. Make sure that this is the case by explicitly
resetting the ssm4567 register map before calling regcache_sync() otherwise
we might end up with a incorrect register map which leads to undefined
behaviour.

One such undefined behaviour was observed when returning from system
suspend while a playback stream is active, in that case the ssm4567 was
kept muted after resume.

Fixes: 1ee44ce03011 ("ASoC: ssm4567: Add driver for Analog Devices SSM4567 amplifier")
Reported-by: Harsha Priya <harshapriya.n@intel.com>
Tested-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm4567.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index e619d56..080c78e 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -352,6 +352,11 @@ static int ssm4567_set_power(struct ssm4567 *ssm4567, bool enable)
 	regcache_cache_only(ssm4567->regmap, !enable);
 
 	if (enable) {
+		ret = regmap_write(ssm4567->regmap, SSM4567_REG_SOFT_RESET,
+			0x00);
+		if (ret)
+			return ret;
+
 		ret = regmap_update_bits(ssm4567->regmap,
 			SSM4567_REG_POWER_CTRL,
 			SSM4567_POWER_SPWDN, 0x00);
-- 
2.1.4
