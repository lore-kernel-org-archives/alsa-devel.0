Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52EAC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:58:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685E820825
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fj+EOPgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685E820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C80C81660;
	Mon,  3 Aug 2020 17:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C80C81660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596470336;
	bh=z3mUBmQVxlSRJSc0shtk5Dg63BWIob69TnDlcf2L9Kw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fj+EOPgKywU+dmlYHho41Xr1W+MTgmg81+rDTc707KF+iSwjp7R3jhQemW3nPNR9S
	 9leRyOK59XrNnl1zNct6UrgBdHd6ec6k54N1qiqa61BP9WtnVe4ejmHOtzYG+e7ucu
	 rwOhUbxbELtTEcEEYIbuTNasmJDHxUnHB1FDPU7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 749C4F800BD;
	Mon,  3 Aug 2020 17:58:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69259F801F7; Mon,  3 Aug 2020 17:58:04 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41085F800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 17:57:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41085F800BD
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1k2cqV-0003ZP-2a; Mon, 03 Aug 2020 15:57:51 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] conf: USB-Audio: Disable IEC958 on Lenovo ThinkStation P620
Date: Mon,  3 Aug 2020 23:57:45 +0800
Message-Id: <20200803155745.18082-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
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

Both USB audio cards on Lenovo ThinkStation P620 don't support IEC958,
so disable IEC958 accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 src/conf/cards/USB-Audio.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 297629f3..9b64af3c 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -63,6 +63,8 @@ USB-Audio.pcm.iec958_device {
 	"Scarlett 2i4 USB" 999
 	"Sennheiser USB headset" 999
 	"SWTOR Gaming Headset by Razer" 999
+	"ThinkStation P620 Main" 999
+	"ThinkStation P620 Rear" 999
 	"Thunderbolt Dock Audio Headset" 999
 	"Thunderbolt Dock Audio Module" 999
 	"USB Device 0x46d_0x821" 999
-- 
2.17.1

