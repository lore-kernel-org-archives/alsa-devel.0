From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mfd: wm5110: ARIZONA_CLOCK_CONTROL should
	be volatile
Date: Tue, 26 Apr 2016 17:06:19 +0100
Message-ID: <1461686780-22885-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1461686780-22885-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DE0126154F
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 18:06:27 +0200 (CEST)
In-Reply-To: <1461686780-22885-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some of the bits in this register can be changed by the codec
so we must mark it volatile.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5110-tables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 8e74e71..1ee68bd 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -3066,6 +3066,7 @@ static bool wm5110_volatile_register(struct device *dev, unsigned int reg)
 	case ARIZONA_AOD_IRQ_RAW_STATUS:
 	case ARIZONA_FX_CTRL2:
 	case ARIZONA_ASRC_STATUS:
+	case ARIZONA_CLOCK_CONTROL:
 	case ARIZONA_DSP_STATUS:
 	case ARIZONA_DSP1_STATUS_1:
 	case ARIZONA_DSP1_STATUS_2:
-- 
1.9.1
