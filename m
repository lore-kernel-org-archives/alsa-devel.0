From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] slimbus: core: use put_device() instead of
	kfree()
Date: Wed,  7 Mar 2018 15:52:38 +0530
Message-ID: <9d7f5ca30baa3a336b145a96a631a8c093f54d8b.1520418001.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 81AC526705A
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 11:23:29 +0100 (CET)
Received: by mail-it0-f66.google.com with SMTP id v194so2789431itb.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2018 02:23:28 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org, broonie@kernel.org, gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/slimbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 4988a8f..7ddfc67 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -141,7 +141,7 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
 	sbdev->e_addr = *eaddr;
 	ret = slim_add_device(ctrl, sbdev, node);
 	if (ret) {
-		kfree(sbdev);
+		put_device(&sbdev->dev);
 		return NULL;
 	}
 
-- 
1.9.1
