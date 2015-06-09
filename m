From: Inha Song <ideal.song@samsung.com>
Subject: [PATCH] mfd: wm8994: Fix NULL pointer exception on
 missing pdata
Date: Tue, 09 Jun 2015 19:18:32 +0900
Message-ID: <1433845112-371-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 21CA226065C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 12:18:57 +0200 (CEST)
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NPO00EVN9YVLG40@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Tue, 09 Jun 2015 19:18:31 +0900 (KST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Inha Song <ideal.song@samsung.com>, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If we use the dev_get_platdata, pdata can be NULL in DT environments.
Actually, NULL pointer exception is occurs with error messages like this:

[    1.226583] Unable to handle kernel NULL pointer dereference at virtual address 00000044
[    1.467910] [<c02f1e38>] (wm8994_irq_init) from [<c02f1bd4>] (wm8994_i2c_probe+0x684/0x858)
[    1.476241] [<c02f1bd4>] (wm8994_i2c_probe) from [<c0371c78>] (i2c_device_probe+0x11c/0x17c)

In wm8994-core, we already checked wheter platform data is NULL and set the
wm8994->pdata to platform data if platform data is not NULL.
So, we can use wm8994->pdata instead of platform data.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 drivers/mfd/wm8994-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index a14407e..ec2c891 100644
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
