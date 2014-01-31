From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 v2] mfd: wm5102: Update register patch
Date: Fri, 31 Jan 2014 16:16:17 +0000
Message-ID: <1391184978-14516-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70345261B19
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:24:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Update the register patch based on latest evaluation of the device.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changed since v1:
  - Updated commit message on patch 2

Thanks,
Charles

 drivers/mfd/wm5102-tables.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index 1e9a4b2..f9b1e96 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -73,6 +73,7 @@ static const struct reg_default wm5102_revb_patch[] = {
 	{ 0x171, 0x0000 },
 	{ 0x35E, 0x000C },
 	{ 0x2D4, 0x0000 },
+	{ 0x4DC, 0x0900 },
 	{ 0x80, 0x0000 },
 };
 
-- 
1.7.2.5
