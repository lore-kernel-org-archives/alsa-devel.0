From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8904: Correct number of EQ registers
Date: Tue, 20 Oct 2015 10:25:58 +0100
Message-ID: <1445333158-18580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E77862663E5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 11:44:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, axel.lin@ingics.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

There are 24 EQ registers not 25, I suspect this bug came about because
the registers start at EQ1 not zero. The bug is relatively harmless as
the extra register written is an unused one.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/wm8904.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/wm8904.h b/include/sound/wm8904.h
index 898be3a..6d8f8fb 100644
--- a/include/sound/wm8904.h
+++ b/include/sound/wm8904.h
@@ -119,7 +119,7 @@
 #define WM8904_MIC_REGS  2
 #define WM8904_GPIO_REGS 4
 #define WM8904_DRC_REGS  4
-#define WM8904_EQ_REGS   25
+#define WM8904_EQ_REGS   24
 
 /**
  * DRC configurations are specified with a label and a set of register
-- 
1.7.2.5
