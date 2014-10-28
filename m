From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: rt5645:Mark RT5645_TDM_CTRL_3 as readable
Date: Tue, 28 Oct 2014 18:36:36 -0300
Message-ID: <1414532196-34611-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C1C260454
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 02:37:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, bardliao@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

amixer query fails due to it is not readable reigster

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/rt5645.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3fb83bf..d16331e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -139,6 +139,7 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0x76, 0x000a },
 	{ 0x77, 0x0c00 },
 	{ 0x78, 0x0000 },
+	{ 0x79, 0x0123 },
 	{ 0x80, 0x0000 },
 	{ 0x81, 0x0000 },
 	{ 0x82, 0x0000 },
@@ -334,6 +335,7 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_DMIC_CTRL2:
 	case RT5645_TDM_CTRL_1:
 	case RT5645_TDM_CTRL_2:
+	case RT5645_TDM_CTRL_3:
 	case RT5645_GLB_CLK:
 	case RT5645_PLL_CTRL1:
 	case RT5645_PLL_CTRL2:
-- 
1.7.9.5
