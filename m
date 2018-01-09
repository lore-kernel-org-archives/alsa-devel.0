From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] slimbus: Unlock on error path in
	slim_msg_response()
Date: Tue, 9 Jan 2018 12:34:35 +0300
Message-ID: <20180109093435.4n45kxibmpvpb5i2@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDED26717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:34:47 +0100 (CET)
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

We need to unlock and restore IRQs before returning on this error path.

Fixes afbdcc7c384b0 ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 755462a4c75e..94818a8427e2 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -36,6 +36,7 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 
 	msg = txn->msg;
 	if (msg == NULL || msg->rbuf == NULL) {
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
 				tid, len);
 		return;
