From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] slimbus: qcom-ctrl: fix a NULL test
Date: Tue, 9 Jan 2018 12:26:16 +0300
Message-ID: <20180109092616.mfha2rs56oaxfjaz@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A23626717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:27:55 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia <sdharia@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"retries" ends when it is set to -1 and not 0 so that part of the test
is wrong.  This bug would lead to a NULL dereference a couple lines
later.

Fixes: afbdcc7c384b ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Should Greg be added to the MAINTAINERS file for this driver?

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index fb1a5e0eb8dd..3ab59209cbdc 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -345,7 +345,7 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 		}
 	}
 
-	if (!retries && !pbuf)
+	if (!pbuf)
 		return -ENOMEM;
 
 	puc = (u8 *)pbuf;
