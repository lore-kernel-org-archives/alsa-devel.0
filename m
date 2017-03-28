From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 3/8] MAINTAINERS: Add missing regulator
	regex for Wolfson Arizona parts
Date: Tue, 28 Mar 2017 15:14:39 +0100
Message-ID: <1490710484-25277-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CA09426648D
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:13:42 +0200 (CEST)
In-Reply-To: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

The maintainers entry for the Wolfson parts seems to be missing
an entry that covers the Arizona regulator drivers, correct this by
adding one.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

New patch in the series since v1.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c265a5f..c35e0ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13616,6 +13616,7 @@ F:	drivers/mfd/cs47l24*
 F:	drivers/power/supply/wm83*.c
 F:	drivers/rtc/rtc-wm83*.c
 F:	drivers/regulator/wm8*.c
+F:	drivers/regulator/arizona*
 F:	drivers/video/backlight/wm83*_bl.c
 F:	drivers/watchdog/wm83*_wdt.c
 F:	include/linux/mfd/arizona/
-- 
2.1.4
