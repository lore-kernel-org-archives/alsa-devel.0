From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel][RESEND PATCH] mfd: wm8994: Fix NULL pointer exception on
 missing pdata
Date: Fri, 07 Aug 2015 10:35:59 +0900
Message-ID: <1438911359-26949-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

If we use the dev_get_platdata, pdata can be NULL in DT environments.
Actually, NULL pointer exception is occurs with error messages like this:

[    1.226583] Unable to handle kernel NULL pointer dereference at virtual address 00000044
[    1.467910] [<c02f1e38>] (wm8994_irq_init) from [<c02f1bd4>] (wm8994_i2c_probe+0x684/0x858)
[    1.476241] [<c02f1bd4>] (wm8994_i2c_probe) from [<c0371c78>] (i2c_device_probe+0x11c/0x17c)

In wm8994-core, we already checked whether platform data is NULL and set the
wm8994->pdata to platform data if platform data is not NULL.
So, we can use wm8994->pdata instead of platform data.

Signed-off-by: Inha Song <ideal.song@samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm8994-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index 55c380a..55c59d9 100644
--- a/drivers/mfd/wm8994-irq.c
+++ b/drivers/mfd/wm8994-irq.c
@@ -193,7 +193,7 @@ int wm8994_irq_init(struct wm8994 *wm8994)
 {
 	int ret;
 	unsigned long irqflags;
-	struct wm8994_pdata *pdata = dev_get_platdata(wm8994->dev);
+	struct wm8994_pdata *pdata = &wm8994->pdata;
 
 	if (!wm8994->irq) {
 		dev_warn(wm8994->dev,
-- 
2.0.0.390.gcb682f8
