From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: cs4265: Mark chip ID register as
	volatile
Date: Mon, 24 Oct 2016 10:55:47 +0100
Message-ID: <1477302949-28049-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 238652667EA
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 11:55:38 +0200 (CEST)
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
 sound/soc/codecs/cs4265.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index fd966bb..f8ad458 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -70,6 +70,7 @@ static bool cs4265_readable_register(struct device *dev, unsigned int reg)
 static bool cs4265_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case CS4265_CHIP_ID:
 	case CS4265_INT_STATUS:
 		return true;
 	default:
-- 
2.1.4
