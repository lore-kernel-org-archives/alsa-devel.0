From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/7] mfd: db8500-prcmu: Ensure AB8500 platform
	data is passed through MFD Core
Date: Fri, 27 Jul 2012 13:38:50 +0100
Message-ID: <1343392734-11805-4-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DF385264F8F
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:39:04 +0200 (CEST)
Received: by mail-wg0-f51.google.com with SMTP id ed3so2087774wgb.20
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:39:07 -0700 (PDT)
In-Reply-To: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org

When booting via platform code the AB8500 platform data is now passed
in though the DB8500. However, if pdata_size is not set it will not be
subsequently passed onto subordinate devices. This patch correctly
populates pdata_size.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 4050a1e..7040a00 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3002,6 +3002,7 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(db8500_prcmu_devs); i++) {
 		if (!strcmp(db8500_prcmu_devs[i].name, "ab8500-core")) {
 			db8500_prcmu_devs[i].platform_data = ab8500_platdata;
+			db8500_prcmu_devs[i].pdata_size = sizeof(struct ab8500_platform_data);
 		}
 	}
 
-- 
1.7.9.5
