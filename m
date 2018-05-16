From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] slimbus: core: add need_tid flag to
	slim_msg_txn
Date: Wed, 16 May 2018 12:36:38 +0100
Message-ID: <20180516113642.28136-4-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 34DDF266F44
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 13:39:11 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id v15-v6so554363wrm.10
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 04:39:11 -0700 (PDT)
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add need_tid flag to txn, this flag can be set before start of transcation.
Having this flag would avoid calling slim_tid_txn() multiple times on the
same txn. Also it is handy for controller drivers too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 79f8e05d92dd..c0450f469e07 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -113,6 +113,7 @@ struct slim_msg_txn {
 	u8			la;
 	struct slim_val_inf	*msg;
 	struct	completion	*comp;
+	bool			need_tid;
 };
 
 /* Frequently used message transaction structures */
-- 
2.16.2
