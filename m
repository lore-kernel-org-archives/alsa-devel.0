Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0BCCF6498
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Sep 2024 15:43:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E722714EA;
	Sun, 29 Sep 2024 17:43:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E722714EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727624609;
	bh=CYSySN5IETqzzXiORun76u6VX622i7IVuXkGUAzFmMU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lZ4WFHNl4dwQamI4cHLtEo7jzwXcgXT5aRnzkhfxKphERMsj8L7o8KCLlwpfGASid
	 GOMOGE9ytHklvOXhRSuwTyjrL9ydCJomyz7YbNLjO1jjZjwIykD0ZqOpf0/xzyZI+V
	 OMZuD6QZZGgy6Y0TvndiorwEgmFwrsZcwxwi1oHc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52D6DF805BE; Sun, 29 Sep 2024 17:42:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BAFCF805AC;
	Sun, 29 Sep 2024 17:42:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C37D3F80517; Sun, 29 Sep 2024 17:42:48 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6DBA5F80007
	for <alsa-devel@alsa-project.org>; Sun, 29 Sep 2024 17:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DBA5F80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=oldherl.one header.i=me@oldherl.one header.a=rsa-sha256
 header.s=default header.b=kFhv3bTh
ARC-Seal: i=1; a=rsa-sha256; t=1727624555; cv=none;
	d=zohomail.com; s=zohoarc;
	b=NK82svE22Jd/1WKVz6fDs2+MR+RGLOOxTP3r+Vz3Uxj6DXSlmj44ogNJ/9iNzCijCCStDLSSsZVPZvwvpYZx7wEJei/q9j9EaCfTQo0dcev75648KC8yfH50d2asuhrM09feNxrmFlKqwWXR3S7CrHim7c57EcwiPT2KvkVQzWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc;
	t=1727624555;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
	bh=CYSySN5IETqzzXiORun76u6VX622i7IVuXkGUAzFmMU=;
	b=ibIAndLowDGaL7PUXU0DztOG9R0oEZLYPWOaBvgF+//JsrZR0m2uaTZ3rc4wuYIm4mjLcGYbs5iYSXjn+Aj4dBZTvpnV0qx8DeyNX81otSXvHGZ63OjgTngTX7PFIlCf/dI+AhJHTHiNHmEZ2zsddcy897J4ccCIxNLmJLctjhY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=oldherl.one;
	spf=pass  smtp.mailfrom=me@oldherl.one;
	dmarc=pass header.from=<me@oldherl.one>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727624555;
	s=default; d=oldherl.one; i=me@oldherl.one;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CYSySN5IETqzzXiORun76u6VX622i7IVuXkGUAzFmMU=;
	b=kFhv3bThr6pY3YGWaw+AaB1R/Hjq5LpaX2/NPlZv1gPx2os7Qm/+Y6GStV4bNMvw
	8+7iVsO/NI/gurwnShUbGEOmRLS8rUidcvDBUeIWVDIvJfUudYkvDUddjf1kfG8mh0H
	QpridQk63RCfmjaOQJPbyYilE8Ww8mfIL5bTzopo=
Received: by mx.zohomail.com with SMTPS id 1727624554137584.8493342942339;
	Sun, 29 Sep 2024 08:42:34 -0700 (PDT)
From: Oldherl Oh <me@oldherl.one>
To: alsa-devel@alsa-project.org
Cc: bo.liu@senarytech.com,
	tiwai@suse.de
Subject: Fix some typos in hda/conexant
Date: Sun, 29 Sep 2024 23:40:59 +0800
Message-ID: <20240929154223.1869717-1-me@oldherl.one>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Message-ID-Hash: FL3ERGTPY7BSXHSEDVYJPUKLMBBW2ELD
X-Message-ID-Hash: FL3ERGTPY7BSXHSEDVYJPUKLMBBW2ELD
X-MailFrom: me@oldherl.one
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FL3ERGTPY7BSXHSEDVYJPUKLMBBW2ELD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I'm trying to understand Conexant driver code in order to solve my microphone
detection problem. As I am new to kernel development, I have made this simple
typo-fixing-only patch as an exercise. Hope it is not disturbing.
