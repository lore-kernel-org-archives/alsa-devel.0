Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D1C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 08:02:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A0C20714
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 08:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xf5i77iO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S2Ut1a4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A0C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDF251673;
	Thu, 26 Mar 2020 09:01:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDF251673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585209726;
	bh=s9rWsQq/XxYtppmTzccEMCopw9A/gdlO729hrKS6Gno=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xf5i77iOM0Cghi3boFcWo5cwtx7UJ74D/5SKkc8VpfbHn7MOQrT3huabMmp+2j3Zj
	 mZVvFy86ztE6fGgcSD/cEQsGSFk/D6DArm5lZZXDENd3dscTqJyjWYEtXUAt7ieXkC
	 G5pPRI4dBDKqWAPxpY4jEO+9hM4h2wul0/dKTe38=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00D94F802E8;
	Thu, 26 Mar 2020 08:55:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1940F80227; Thu, 26 Mar 2020 07:17:10 +0100 (CET)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 625D1F8011B
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 07:17:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 625D1F8011B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="S2Ut1a4F"
Received: by mail-pg1-x54a.google.com with SMTP id f14so3921756pgj.15
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=+SxjJva0YWqxT42y0+cCD4roUNRLjOULUql4d4jTyTI=;
 b=S2Ut1a4FemVD9Zoec3UCctFsUiTAvIJKEHmJLdisnxkdN1QAmnv7kUCCGObqlXGywG
 y11PUqJTLCd2pzRTATD1VEWCVRT+whbEo8ULNoJHo/iiZ+HR/ytJpFnw//IdN6ehY2bc
 cF1Ir8+jaJUqJWqQse+nBtttB6IVOU0NI+f594KuonTEodvlE6sOXKy8B/MlIdL22X+A
 TLPLFio2kcOT5Xh1chrb/ZZzqp7+5ZpJ6G8tgY3/oqf2T3w2XkY038nFERVrfEod3K2e
 QZemx+O3sr4+ZAA79fr/cEHqIX85qwabSve279SYHkLZC7Yf2iU3Qilch59sfklhcdwf
 LvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=+SxjJva0YWqxT42y0+cCD4roUNRLjOULUql4d4jTyTI=;
 b=l1GKx/PWoJgNnKUQ4AlUCMOqZ9DW0fWNHWX58wZs0b9/MgznvngCXHjw0MJcTtPMQK
 HNbXqT5KeytrJB2nhrSXg8l1PBtLDcHkEGESx2I88/OUnA4zDPLC2llE29Lmy8098srQ
 sWjZKmE+0TT1X3RxXYs6LJjwE1KW1q2F+Y8MrfGGA9XiNuQ2iWtB3lDymFDzBdM9+3WG
 AUTJ/o9HtCyxblCym7xqa5hpQdbvRRezbl9V2bbrlYSt980s9rlTRVinLKggtYKR43hl
 72+IsJkhBaymZSFDbRASpGcxm1RjOcpnPi+C4JisdtcJtIx4cJUR5MiD3rj4kaFDi/To
 QISw==
X-Gm-Message-State: ANhLgQ3toD6OYJjHB/4TcjYSVZxIUJ/0km4qNHFfgkwfvJHqcKD9RZDE
 D7IBL2BZH5BuQRKB1QlntR1l/GWcm0N5Lb4=
X-Google-Smtp-Source: ADFU+vtQ+Z2Scs+XMv1fSFAZCfEtCAWRrDtOmcSf1EJHJYN3e2K+DylCjXC8A/4njqK7vcMXHIqrBg82Yw5Lzog=
X-Received: by 2002:a17:90b:3752:: with SMTP id
 ne18mr1415515pjb.143.1585203422125; 
 Wed, 25 Mar 2020 23:17:02 -0700 (PDT)
Date: Wed, 25 Mar 2020 23:16:48 -0700
Message-Id: <20200326061648.78914-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] slimbus: core: Set fwnode for a device when setting of_node
From: Saravana Kannan <saravanak@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 26 Mar 2020 08:54:37 +0100
Cc: alsa-devel@alsa-project.org, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 John Stultz <john.stultz@linaro.org>, kernel-team@android.com
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

When setting the of_node for a newly created device, also set the
fwnode. This allows fw_devlink to work for slimbus devices.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Change-Id: I5505213f8ecca908860a1ad6bbc275ec0f78e4a6
---
 drivers/slimbus/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 526e3215d8fe..44228a5b246d 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
 
-	if (node)
+	if (node) {
 		sbdev->dev.of_node = of_node_get(node);
+		sbdev->dev.fwnode = of_fwnode_handle(node);
+	}
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
-- 
2.25.1.696.g5e7596f4ac-goog

