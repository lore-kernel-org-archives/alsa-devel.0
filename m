From: srinivas.kandagatla@linaro.org
Subject: [PATCH 1/6] slimbus: avoid null pointer dereference on
	msg
Date: Tue,  2 Jan 2018 17:54:19 +0000
Message-ID: <20180102175424.14391-2-srinivas.kandagatla@linaro.org>
References: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id DC148267429
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 18:56:34 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id r78so62773320wme.5
 for <alsa-devel@alsa-project.org>; Tue, 02 Jan 2018 09:56:34 -0800 (PST)
In-Reply-To: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Colin Ian King <colin.king@canonical.com>, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer msg is checked to see if it is null at the start of
the function and jumps to the error exit label reterr that then
dereferences msg when it prints a dev_err error message. Avoid
this potential null pointer dereference by only printing the
error message if msg is not null.

Detected by CoverityScan, CID#1463141 ("Dereference after null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.15.0
