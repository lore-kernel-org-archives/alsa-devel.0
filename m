Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E05C54F51
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76FE86022F;
	Wed, 29 Jul 2026 10:58:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76FE86022F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315527;
	bh=K9vxSL1BO/BDjF0RNhBwieZQpVdfpxrOkbJB69gbfAs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OspDp2zhi3fyBjWfPydHveKutsIpVuk9fetW6/fE9+BbY8FDQX8c/OhBPeGbGXTDg
	 TRQqitF/+7MLDZFomiiPjO/Skrj2R0wuiu4T4ia5Vlf28nK7Qf1QRmXBmayugPjxD9
	 5OHq1HwbPzuLb9GWSAhaZ3d9mkhI9liVUaNVFSUY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA9B5F80673; Wed, 29 Jul 2026 10:57:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 12F66F8067A;
	Wed, 29 Jul 2026 10:57:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29D5DF80526; Tue, 28 Jul 2026 08:56:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785221763;
	b=mv1BNx/W1A5qIGGy4nrmjLECPqzEOc0+nNS5BN2IGxr1RIA54uoK8GT9bxvo6vdR+eCw
	 j8SKe1vZfqZEKOhEpNast++GHuT5J2fhSWDOIS1My5hzJpVkSZ77yd74a5xm5MIPvd4/2
	 hHGzoloFTbbIfJAABmybD82pXq8Wa5adl+FTvQWl23qVwTl0coFDRqhCdAzp/jwfv8LtO
	 ePUg1m414EXTcLuaM9YW+h3ro7Su4CUYd//7kgLlvfq0dfN38Hy+v+t6bwl5DevFacPW7
	 98WgiApiCgEYY74fuONHob+/db6irXFeZPHtObwJAOUfXTEg4g0oXSy87J6o9XzWnSQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785221763;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature;
	bh=K9vxSL1BO/BDjF0RNhBwieZQpVdfpxrOkbJB69gbfAs=;
	b=Okv3qqthVNfln2XJ2/x23QqV8R4wXyzPwTu3kh1OUXUI0KoDpUkm49vPqVFFdKDDDZv+
	 +0wCsLfldR8xoD0DY1PFweH0kazW0DWiSzuujXQLuYyaCPrIl712iCun7J/o2N2XrXJUX
	 ivvmZjtWfrDdorQtLAeAidfKNEI7TmawBAcwnIYQxByG5xu776OC+rNXNHfDyreUhS78e
	 YlFHcE1vQipka4wocGZS7dEeu+Ye4dYMVOViv2Gl5YpmGAmVWO/iG/PCFPdZmjlS/Vpgq
	 m7ucPljtShK6FXWP+3DWzPeCXHvRsuW461dlxnAcJQam6Sa6EMgdaY61+LB5SO6J7Gg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=i8CULJI5;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BB9C9F801F7
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 08:56:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB9C9F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=i8CULJI5
Received: from LAPTOP-99KJFSET (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d3f7934;
	Tue, 28 Jul 2026 14:55:55 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>
Cc: alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [PATCH] mfd: cs42l43: cancel boot work during remove
Date: Tue, 28 Jul 2026 14:55:56 +0800
Message-ID: <20260728065556.1508-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa782328503a1kunm502714bde42d2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkJKVh8dHRhJGktDH0wfGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=i8CULJI5VrgrWneb8MXHz9hZpLhqoOObFyNAHZ4eRWJzfHSADcNHhyGshVQrF0/6PpB3E7yenn69dXFnAorACj5hscsPKzkb/2S8ruNO3OGnaWSeRbUiyjOK95WRa+fNJ1f9j8oMDZDDQORquEA/346c7Y0E2CBU7HQFEla2QcM=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=5RZNJeUj0krBwNh2Di9WbsEc1dsAr+ALq4D1gvEVVx0=;
	h=date:mime-version:subject:message-id:from;
X-MailFrom: getshell@seu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IMSDT42X37YBFBREDUZQKITORT3TOPOB
X-Message-ID-Hash: IMSDT42X37YBFBREDUZQKITORT3TOPOB
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:57:39 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IMSDT42X37YBFBREDUZQKITORT3TOPOB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Probe queues boot_work on system_long_wq, but both transport remove
callbacks release the devm-allocated CS42L43 data without waiting for it.

Cancel the work before powering the device down. Balance the runtime-PM
reference when pending work is cancelled, and have the worker call the
power-down helper directly on error to avoid cancelling itself.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/mfd/cs42l43.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 7b6d07c..411566e 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -868,6 +868,8 @@ static int cs42l43_irq_config(struct cs42l43 *cs42l43)
 	return 0;
 }
 
+static int cs42l43_power_down(struct cs42l43 *cs42l43);
+
 static void cs42l43_boot_work(struct work_struct *work)
 {
 	struct cs42l43 *cs42l43 = container_of(work, struct cs42l43, boot_work);
@@ -937,7 +939,7 @@ static void cs42l43_boot_work(struct work_struct *work)
 
 err:
 	pm_runtime_put_sync(cs42l43->dev);
-	cs42l43_dev_remove(cs42l43);
+	cs42l43_power_down(cs42l43);
 }
 
 static int cs42l43_power_up(struct cs42l43 *cs42l43)
@@ -1069,6 +1071,8 @@ EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, MFD_CS42L43);
 
 void cs42l43_dev_remove(struct cs42l43 *cs42l43)
 {
+	if (cancel_work_sync(&cs42l43->boot_work))
+		pm_runtime_put_noidle(cs42l43->dev);
 	cs42l43_power_down(cs42l43);
 }
 EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
-- 
2.50.1.windows.1
