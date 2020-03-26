Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC035C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:36:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6956E2073E
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c4uNsK9I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VktKbXpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6956E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A87D71666;
	Thu, 26 Mar 2020 18:35:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A87D71666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585244161;
	bh=WvzwVK/3I73H8TAMR33ovNa5DMn9AUrkj67EyQld2Us=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c4uNsK9ISaviBmLdeqCja4IsUY3OwScKD+BqC5A8gADDdrQNlF7pup4dM0vZeIDFM
	 3lbzs/jMis15BMNZcO5ZakapSJgYcN9oAopykUm0cT5oEBdjIFVsqIKLBcy3Ea7+rO
	 QyUG3VIZ+9rGzB8wfS1sTwcUgEm0Vne0pnbgsBME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25217F801F9;
	Thu, 26 Mar 2020 18:35:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AECDAF80227; Thu, 26 Mar 2020 18:35:09 +0100 (CET)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17CEBF8011B
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 18:35:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17CEBF8011B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="VktKbXpg"
Received: by mail-pg1-x54a.google.com with SMTP id x4so5353322pgh.14
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=G+G8SzoTNYm3INTXZnya/9BfrExbp6FOm4lsdACc9gY=;
 b=VktKbXpg0Ao5yMu4T3/zZ0IkunVLznTzi3YISxgzT27E2R21Mq9W4obdxBrjpWmvpW
 dYfL86TNZPqhACrwLiin0og2QiAUeF31QIbNU4NjDDt0P5ZkG2tZDuTUGtAZ84D97Gu8
 EGS9/riz8VU7cuM1TuixG/Fzcy0QO11pY36A2ME+BtirqMOUmpT9LhgkoG2/06m5E5w6
 KwwPh3ZMMeOoARPq+4atwfAS34STDNHOgousf97A+DntfBawLWCT8WN7hSRP1vfpRP0D
 zQs31npcQxr9R9IYGS1lLBF09sEmAQi0Yz2lD9mBYppJvvXDTBMadqecDI4hU5tGQbPM
 FLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=G+G8SzoTNYm3INTXZnya/9BfrExbp6FOm4lsdACc9gY=;
 b=gZuG6bdt4tNBQMvA+/YBVyxL4ya4+SqWuJEMfDRuAsvdP+QsobI3MQY22dbvr4Z1q3
 7DeGjlDEWJbMxmK153cg+yhyR3rMswFqUKEz0+Szgw8broe0j4kLxsfYOlwoBWI4wAOn
 JDvT15/Mufe/lY7r/5Os3wd68wcv6tb/wwtxbIA4oWjIiJ+ubE0TThg4LfXXcPyCRNAB
 J0N/NXj/jitDQST/asXrksYWFqTlrx0ANLXVM59XdzzEzwuKHzamHTwccRmi9L2cGCi9
 W5wAnlYNspFpa8OEv/486IJb7bx0i6SV2c3g4WAHlKwWyGhWNpkSAlLfdlst4TLZhBTZ
 R8Ig==
X-Gm-Message-State: ANhLgQ2obMEX08UStBPmvQ/Kv6+xCjB+lLvUff2sJCpg4xfcIxfhTbVb
 4vapW3I2ILyrGqbpwH3mjBPGbc/qkucTtgM=
X-Google-Smtp-Source: ADFU+vvrbubNnjF/Quaud6R8eOUsieihvCBBg9WfH4mP4HFBuqBith01Gbz68HRn3tEjfLibzAYBTR1d8Ti89yY=
X-Received: by 2002:a17:90a:198b:: with SMTP id
 11mr1230411pji.23.1585244101710; 
 Thu, 26 Mar 2020 10:35:01 -0700 (PDT)
Date: Thu, 26 Mar 2020 10:34:56 -0700
Message-Id: <20200326173457.29233-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] slimbus: core: Fix mismatch in of_node_get/put
From: Saravana Kannan <saravanak@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Also, remove some unnecessary NULL checks. The functions in question
already do NULL checks.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/slimbus/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 44228a5b246d..ae1e248a8fb8 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -162,11 +162,8 @@ static int slim_add_device(struct slim_controller *ctrl,
 	sbdev->ctrl = ctrl;
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
-
-	if (node) {
-		sbdev->dev.of_node = of_node_get(node);
-		sbdev->dev.fwnode = of_fwnode_handle(node);
-	}
+	sbdev->dev.of_node = of_node_get(node);
+	sbdev->dev.fwnode = of_fwnode_handle(node);
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
@@ -285,6 +282,7 @@ EXPORT_SYMBOL_GPL(slim_register_controller);
 /* slim_remove_device: Remove the effect of slim_add_device() */
 static void slim_remove_device(struct slim_device *sbdev)
 {
+	of_node_put(sbdev->dev.of_node);
 	device_unregister(&sbdev->dev);
 }
 
-- 
2.25.1.696.g5e7596f4ac-goog

