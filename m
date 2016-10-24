From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: cs42l52: Mark chip ID register as
	volatile
Date: Mon, 24 Oct 2016 10:55:48 +0100
Message-ID: <1477302949-28049-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 604312667EA
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 11:55:45 +0200 (CEST)
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

Mark the chip ID register as volatile, the current code does work as
without a default value regmap will read from the hardware the first
time, however, this makes it more explicit that this register should be
read from the hardware.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs42l52.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 0d9c4a5..1164990 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -120,6 +120,7 @@ static bool cs42l52_readable_register(struct device *dev, unsigned int reg)
 static bool cs42l52_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case CS42L52_CHIP:
 	case CS42L52_IFACE_CTL2:
 	case CS42L52_CLK_STATUS:
 	case CS42L52_BATT_LEVEL:
-- 
2.1.4
