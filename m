From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] mfd: wm5110: Set FX_CTRL2 to volatile
Date: Tue,  6 Aug 2013 16:42:30 +0100
Message-ID: <1375803750-22116-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1375803750-22116-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1821F26084D
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 17:51:58 +0200 (CEST)
In-Reply-To: <1375803750-22116-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

FX_CTRL2 is a volatile register and should be marked as such, this patch
does so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5110-tables.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 4903265..3113e39 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -2349,6 +2349,7 @@ static bool wm5110_volatile_register(struct device *dev, unsigned int reg)
 	case ARIZONA_IRQ_PIN_STATUS:
 	case ARIZONA_AOD_IRQ1:
 	case ARIZONA_AOD_IRQ2:
+	case ARIZONA_FX_CTRL2:
 	case ARIZONA_ASRC_STATUS:
 	case ARIZONA_DSP_STATUS:
 	case ARIZONA_DSP1_CONTROL_1:
-- 
1.7.2.5
