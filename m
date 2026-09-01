Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D7C61DFD
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:19:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 010C9601CD;
	Tue,  1 Sep 2026 05:19:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 010C9601CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788232796;
	bh=gt0uP4ejrnkgYdlYHwyAUaqXpsk2S29XhKoxg+EEUVs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lz/lku9YURCjnbzpfimkVcWaXBEggJZkPaspiPwDNJG5DOdzBCqFU+WuJmJL5ToFf
	 5Kgu7UhrefqhVgYiraSljdp20235y5UaZKbgg1kpSEawOfGGL4sWi53GsF5xGQUbND
	 0STT1Fi1hy3D++5pKOwbrlwCzV9K/GLaPvVxI8aA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5E31F805EE; Tue,  1 Sep 2026 05:19:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3068F805EB;
	Tue,  1 Sep 2026 05:19:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A206DF804CC; Tue,  1 Sep 2026 05:19:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788232752;
	b=ZpQ55C1M7eUdQqjL8XpxmcpEIYOO8t5QQ7URO2KwDEBuA5+ZUUT/qfO64wJ8/hlgd41Q
	 9wJwmz0ovhsN21DQO01Nd5Zza7bWJsRgnf9AOMAeZHYq+LjZ09amcp0OM12Fk1KdXmw7J
	 Sx6IEsziqxNQEE3J+1As/PSqtJwhkNU0/Xzzo/n70iwr+WWbN3G6UC6h/DnXzGhrL+LG8
	 4yaTImuw3pXiLQhG4X1rJCLWsy6KwBMbvIoewYivjGnyKYa/sxwbilwr/H7+I2JzngUwc
	 QRAD2lRoi/5hAPYRnza+vy9WdNMQQ6jReyHa41xi5dKmzneCyhG4P/GDXWgZzF5H6fw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788232752;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=gt0uP4ejrnkgYdlYHwyAUaqXpsk2S29XhKoxg+EEUVs=;
	b=XrHkfEdgN3qmiUm5MWr2LDiIl4XoGDdOKz1BMYK5P++xq69Td48xAV5Tcn57Dp3opUMm
	 sEKFhEWAAbuF79wylhLhcOzpCFoFik3l9Dv3N/mbDxtXTAmoJlW3lIezSPVtTuDIeqnYu
	 zvalRGFglk8ytth0/rikxnv9I4eWxalAWBustdv2rCPngp8dgibztHrN2h7a08WEZQ0xw
	 51sVfUHQVNsnZfeFTxRIeLDVG9PP1efAQB/HTApp1viHD5CDXIQ9MFd2gs8uZs6ZLxnLQ
	 Zgx/Nlnzve/f7+Hjo8KKDKbsKHtWTqgCHgB53YDn94M18f/IJLOzuhFG4NUp4TcgIww==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B711BF80071
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 05:19:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B711BF80071
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d114367ac42200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/848@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/848@alsa-project.org>
Subject: ucm2: Qualcomm: Add support for HP OmniBook 5
Date: Tue,  1 Sep 2026 05:19:13 +0200 (CEST)
Message-ID-Hash: REQRPGVQSEPBFSAGM663PR4TKANCUUEL
X-Message-ID-Hash: REQRPGVQSEPBFSAGM663PR4TKANCUUEL
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/REQRPGVQSEPBFSAGM663PR4TKANCUUEL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #848 was opened from jspingu:

Add DMI match for the Purwa-based HP OmniBook 5 Laptop 14-he0xxx. Setup is identical to the existing Omnibook X14 (WCD938x codec, 2x WSA speakers), which is matched in the Lenovo T14s block.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/848
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/848.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
