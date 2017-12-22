From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] slimbus: avoid null pointer dereference
	on msg
Date: Fri, 22 Dec 2017 00:01:08 +0000
Message-ID: <20171222000108.9533-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 90F43266D61
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 01:01:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer msg is checked to see if it is null at the start of
the function and jumps to the error exit label reterr that then
dereferences msg when it prints a dev_err error message. Avoid
this potential null pointer dereference by only printing the
error message if msg is not null.

Detected by CoverityScan, CID#1463141 ("Dereference after null check")

Fixes: afbdcc7c384b ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/slimbus/messaging.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 755462a4c75e..8b2c77f516b9 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -170,8 +170,9 @@ static int slim_val_inf_sanity(struct slim_controller *ctrl,
 		break;
 	}
 reterr:
-	dev_err(ctrl->dev, "Sanity check failed:msg:offset:0x%x, mc:%d\n",
-		msg->start_offset, mc);
+	if (msg)
+		dev_err(ctrl->dev, "Sanity check failed:msg:offset:0x%x, mc:%d\n",
+			msg->start_offset, mc);
 	return -EINVAL;
 }
 
-- 
2.14.1
