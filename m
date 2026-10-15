Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E985CC6B2F
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:40:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A200A60210;
	Thu, 15 Oct 2026 10:40:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A200A60210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792053625;
	bh=7jqcg17vvOOBPw11nXNGyr+VlsHCOZkiB3SRSFm/dag=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ka4eBPNm63i1adN5GBSR9Y6KbO1UcHFPo4sFpl00uRq8bT7dpUTNoiX/AGPTEh4aB
	 4GiQ9FpkP2da5Nlgnw2QZv6C63625mA2WiDaNtRiFKXjWnrrQoDV+lB67ht/v6O1WP
	 1jiyeRq2cfqGW5DdR+KCEjKivTtBPRKcjUPdUFKk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE1C3F805F5; Thu, 15 Oct 2026 10:39:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42124F805F9;
	Thu, 15 Oct 2026 10:39:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA199F804CF; Thu, 15 Oct 2026 10:39:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792053583;
	b=D6tVCCVJfBz2eVhgEQVsmy/L4ySD/uVjtYcKQW0ek4SLtnKLDwPFTjo7enzVZX+PIGDh
	 5C0tTx3lumkJARA/KgwaF4WE1wb6hzDXnwJhFjd3xsxb+ukjyckaqYlvLDZcqLFIZSk/c
	 kkPkpkRRkYBBj6zxcx/8CbthTftakONlwZI5e4TkbJJH3CFNuM37gyZ82iPFRkJwnvtwA
	 VydwrNhuj7cfouc/KqJp+goTXWvpzQdNyP0W1Z+4//mCoHQRQkvD4hs4D/npkNYa6OiY8
	 UJ6peito6UK0yWxrvyJFwr+4h/Wk6OtYJUfZTi3KPDuqprh7coDmDEAaqt1HBafihPw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792053583;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=7jqcg17vvOOBPw11nXNGyr+VlsHCOZkiB3SRSFm/dag=;
	b=i/EBSa4xklOSlRF07OQNC7fJWAkRtmpqIZHWO9pXuPg1536rwTAPDLqp2trIO3pO5Cpw
	 R37uDh+nSaaPc/10zEFsADDAParMnvyVvfOmL0yndAcvKzGIKaW0OjYwlo6nx0sGLxqJZ
	 ucwS0mjrMkX9y34uzTvI+kjH8brbk8ehPgCYcDXSxTJ0U2sryRFzrS8ry/Llgseei9zQG
	 noz7IHjsaIC4qrDMttOOJbUSrsLIpfjCtgzz5jLCnmddGbyyENb/Lwtj9Q0Qphiv1wfFS
	 69dmtdBETqZ5mF7nyKT6CRjpfHSANiQOQYauzpXm84iSrpwrDo7KLBzJjnYiOAmkJaA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C9DA6F8026D
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 10:39:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9DA6F8026D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dea73cfe93b000-webhooks-bot@alsa-project.org>
In-Reply-To: <18dea73cfe768100-webhooks-bot@alsa-project.org>
References: <18dea73cfe768100-webhooks-bot@alsa-project.org>
Subject: wpctl shows dummy output for Audio Sinks with the U-Boot build
Date: Thu, 15 Oct 2026 10:39:44 +0200 (CEST)
Message-ID-Hash: ZTGCPFA72XCADAUW5HZCMZJLJZYBRPIM
X-Message-ID-Hash: ZTGCPFA72XCADAUW5HZCMZJLJZYBRPIM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZTGCPFA72XCADAUW5HZCMZJLJZYBRPIM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #884 was opened from sauravk-git:

wpctl shows dummy output for Audio Sinks with the U-Boot build

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/884
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
