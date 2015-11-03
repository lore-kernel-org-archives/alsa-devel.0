From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 5/5] MAINTAINERS: Update Wolfson Micro section to include CS47L24 source
Date: Tue, 3 Nov 2015 15:08:36 +0000
Message-ID: <1446563316-28878-6-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The CS47L24 source is part of the ex-Wolfson "Arizona" group of
drivers. Not all cs47lxx devices are part of the Arizona driver
group so the cs47l24 is explicitly listed by its full part number.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee10b57..bd181c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11444,6 +11444,7 @@ F:	drivers/input/touchscreen/wm831x-ts.c
 F:	drivers/input/touchscreen/wm97*.c
 F:	drivers/mfd/arizona*
 F:	drivers/mfd/wm*.c
+F:	drivers/mfd/cs47l24*
 F:	drivers/power/wm83*.c
 F:	drivers/rtc/rtc-wm83*.c
 F:	drivers/regulator/wm8*.c
@@ -11457,6 +11458,7 @@ F:	include/linux/wm97xx.h
 F:	include/sound/wm????.h
 F:	sound/soc/codecs/arizona.?
 F:	sound/soc/codecs/wm*
+F:	sound/soc/codecs/cs47l24*
 
 WORKQUEUE
 M:	Tejun Heo <tj@kernel.org>
-- 
1.9.1
