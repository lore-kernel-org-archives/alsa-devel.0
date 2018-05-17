From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/8] slimbus: messaging: pass correct wbuf
Date: Thu, 17 May 2018 09:58:46 +0100
Message-ID: <20180517085850.14276-5-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 594CA26707F
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 11:01:00 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id x9-v6so1950679wrl.13
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 02:01:00 -0700 (PDT)
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There seems to be a typo while filling msg for slim_write, wbuf is
set to NULL instead of rbuf.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 457ea1f8db30..5a2ff01b394c 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -307,7 +307,7 @@ int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
 {
 	struct slim_val_inf msg;
 
-	slim_fill_msg(&msg, addr, count,  val, NULL);
+	slim_fill_msg(&msg, addr, count,  NULL, val);
 
 	return slim_xfer_msg(sdev, &msg, SLIM_MSG_MC_CHANGE_VALUE);
 }
-- 
2.16.2
