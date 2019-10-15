Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CDC4CECE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:04:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6487320854
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NWGLJmer";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="Y+Zh43VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6487320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11A8515E2;
	Thu, 17 Oct 2019 08:04:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11A8515E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571292290;
	bh=zj6EcfPD5sey3v6wQlEUzHguHeHphQn9Bu3Z6QJstjU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NWGLJmerXJ6PXs/83JHAa6MiQvfkH9b2RBZjNlIweG7TYSdOrkM++UsC/QLBStXQ+
	 kef9OFoN+GlnGbKBXsMdiWO/aFQHTuPM5KfsHA7yGWjv4Pc9VJ3OdnRIUOeqwpapWd
	 EWNWJlx3JaZLByLosvHdpHm/h1JTv/vqjd8/8lBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF0FCF805FC;
	Thu, 17 Oct 2019 08:02:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9557F804AA; Tue, 15 Oct 2019 06:38:22 +0200 (CEST)
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net
 [IPv6:2605:2700:0:5::4713:9cab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 310D2F800F4
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 06:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 310D2F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=bewilderbeest.net
 header.i=@bewilderbeest.net header.b="Y+Zh43VJ"
Received: from longray.bewilderbeest.net (unknown
 [IPv6:2600:6c44:7f:ba22:6b9e:df64:6c86:95f5])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: zev)
 by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5A058805DB;
 Mon, 14 Oct 2019 21:38:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 5A058805DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
 s=thorn; t=1571114298;
 bh=ZiBgpE89bCHDT1vBigCVEAT7eFH+AucgPY/ghUKCtoY=;
 h=From:To:Cc:Subject:Date:From;
 b=Y+Zh43VJ+tHCsrmwL1tIig7gzR1SMSh9mBCzYN1yKGo/psjpo8K6BZU967ip2LYdJ
 IfJCXEb//9VOF5r2XAEiTR7uxD2e3ny3WvH69+qlYzC+yJJbpcnVOAnd/Jel1JrAa9
 HU9uFiduNfUz+ZTsXh94m5xJAF54XATxaCa+ZUY0=
From: Zev Weiss <zev@bewilderbeest.net>
To: alsa-devel@alsa-project.org
Date: Mon, 14 Oct 2019 23:38:02 -0500
Message-Id: <20191015043802.23619-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 17 Oct 2019 08:02:16 +0200
Cc: Zev Weiss <zev@bewilderbeest.net>
Subject: [alsa-devel] [PATCH] alsactl: avoid needless wakeups in monitor
	loop.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The timeout wasn't really being used for anything; disabling it should
reduce idle energy consumption slightly.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 alsactl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 6b090e4f5c92..6d9328d899a4 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -340,7 +340,7 @@ static int run_dispatcher(int epfd, int sigfd, int infd, struct list_head *srcs,
 		int count;
 		int i;
 
-		count = epoll_wait(epfd, epev, max_ev_count, 200);
+		count = epoll_wait(epfd, epev, max_ev_count, -1);
 		if (count < 0) {
 			err = count;
 			break;
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
