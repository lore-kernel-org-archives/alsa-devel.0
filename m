From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] soundwire: cdns: fix check for number of
	messages
Date: Thu, 28 Mar 2019 13:41:32 +0000
Message-ID: <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EBD5F8963C
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 14:42:03 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id j9so22950537wrn.6
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 06:42:03 -0700 (PDT)
In-Reply-To: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Looks like there is a typo while checking number of messages, which
should be checked in defer pointer rather than message length.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index cb6a331f448a..d41adbc57918 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -434,7 +434,7 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
 	int cmd = 0, ret;
 
 	/* for defer only 1 message is supported */
-	if (msg->len > 1)
+	if (defer->length > 1)
 		return -ENOTSUPP;
 
 	ret = cdns_prep_msg(cdns, msg, &cmd);
-- 
2.21.0
