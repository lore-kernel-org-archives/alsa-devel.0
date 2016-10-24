From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: cs53l30: Mark chip ID registers as
	volatile
Date: Mon, 24 Oct 2016 10:55:49 +0100
Message-ID: <1477302949-28049-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 775672667EA
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 11:55:53 +0200 (CEST)
In-Reply-To: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark the chip ID registers as volatile, the current code does work as
without a default value regmap will read from the hardware the first
time, however, this makes it more explicit that this register should be
read from the hardware.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs53l30.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index cb47fb5..b4f0a43 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -89,10 +89,16 @@ static const struct reg_default cs53l30_reg_defaults[] = {
 
 static bool cs53l30_volatile_register(struct device *dev, unsigned int reg)
 {
-	if (reg == CS53L30_IS)
+	switch (reg) {
+	case CS53L30_DEVID_AB:
+	case CS53L30_DEVID_CD:
+	case CS53L30_DEVID_E:
+	case CS53L30_REVID:
+	case CS53L30_IS:
 		return true;
-	else
+	default:
 		return false;
+	}
 }
 
 static bool cs53l30_writeable_register(struct device *dev, unsigned int reg)
-- 
2.1.4
