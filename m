Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2BDCA0FED
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:53:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E81C6029A;
	Wed, 27 Aug 2025 16:53:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E81C6029A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756306391;
	bh=jc/lyTPWwLQk9cNU3YfjqfMW2EJqdkUQM/26/TRJcV0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YbnL+5pzzFJhEEZj3Q4jvPkszCXMp69vfl8u0biXBOLxcEDUjtEZgxui7ieYhf16k
	 XiaMqEgHboPX9iL1CVdqM5idEAQhQ3rs2oJjIJklp49uUYMC/fWzCmUKUbehrT2798
	 FaaNTwLF2UR1vo2DgwlkdSn4/cIQZeTdbwWEkbqI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05AB5F805C3; Wed, 27 Aug 2025 16:52:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76595F805C8;
	Wed, 27 Aug 2025 16:52:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5346EF80495; Wed, 27 Aug 2025 16:52:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F340F800DF
	for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2025 16:52:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F340F800DF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185fa74f79677a00-webhooks-bot@alsa-project.org>
In-Reply-To: <185fa74f74589b00-webhooks-bot@alsa-project.org>
References: <185fa74f74589b00-webhooks-bot@alsa-project.org>
Subject: Feature request: Add support for RME Fireface UCX
Date: Wed, 27 Aug 2025 16:52:22 +0200 (CEST)
Message-ID-Hash: IZB5O5HJ5BHDHGTYWXARWIPZ46UG4XQG
X-Message-ID-Hash: IZB5O5HJ5BHDHGTYWXARWIPZ46UG4XQG
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IZB5O5HJ5BHDHGTYWXARWIPZ46UG4XQG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #605 was opened from vascosantos:

I see there is already support for the RME Fireface UCX II.
Could you please add support for the previous version, RME Fireface UCX?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/605
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
