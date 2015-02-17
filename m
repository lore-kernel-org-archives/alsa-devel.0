From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5670: Add disabled item in dmic
	pin enum
Date: Tue, 17 Feb 2015 13:59:26 +0800
Message-ID: <1424152767-29226-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AEC902606A7
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 06:59:40 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, mengdong.lin@intel.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Currently, we will configure dmic related pin definition if pdata.dmic_en
is true. However, there is no disable option in the enum. So, any dmic is
used, all 3 dmic related pins will be configured. It may cause unexpected
pin definition. This patch adds a disable item for each dmic enum and
take it as default. So the driver will not set the pin configuration if
we don't set dmicx_data_pin in platform data.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.h | 3 +++
 1 file changed, 3 insertions(+)
 mode change 100755 => 100644 sound/soc/codecs/rt5670.h

diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
old mode 100755
new mode 100644
index 21f8e18..0a67adb
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1950,17 +1950,20 @@ enum {
 };
 
 enum {
+	RT5670_DMIC1_DISABLED,
 	RT5670_DMIC_DATA_GPIO6,
 	RT5670_DMIC_DATA_IN2P,
 	RT5670_DMIC_DATA_GPIO7,
 };
 
 enum {
+	RT5670_DMIC2_DISABLED,
 	RT5670_DMIC_DATA_GPIO8,
 	RT5670_DMIC_DATA_IN3N,
 };
 
 enum {
+	RT5670_DMIC3_DISABLED,
 	RT5670_DMIC_DATA_GPIO9,
 	RT5670_DMIC_DATA_GPIO10,
 	RT5670_DMIC_DATA_GPIO5,
-- 
1.8.1.1.439.g50a6b54
