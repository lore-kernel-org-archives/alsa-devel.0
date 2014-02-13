From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: max98090: make REVISION_ID readable
Date: Thu, 13 Feb 2014 16:54:24 -0700
Message-ID: <1392335664-6586-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D740026527E
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 00:54:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

The REVISION_ID register is not currently marked readable. snd_soc_read()
refuses to read the register, and hence probe() fails.

Fixes: d4807ad2c4c0 ("regmap: Check readable regs in _regmap_read")
[exposed the bug, by checking for readability]
Fixes: 685e42154dcf ("ASoC: Replace max98090 Device Driver")
[left out this register from the readable list]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/max98090.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 51f9b3d16b41..141091c62db5 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -336,6 +336,7 @@ static bool max98090_readable_register(struct device *dev, unsigned int reg)
 	case M98090_REG_RECORD_TDM_SLOT:
 	case M98090_REG_SAMPLE_RATE:
 	case M98090_REG_DMIC34_BIQUAD_BASE ... M98090_REG_DMIC34_BIQUAD_BASE + 0x0E:
+	case M98090_REG_REVISION_ID:
 		return true;
 	default:
 		return false;
-- 
1.8.1.5
