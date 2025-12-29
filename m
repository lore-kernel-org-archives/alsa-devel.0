Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37F4D3B7E5
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:04:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71C6C601FA;
	Mon, 29 Dec 2025 11:04:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71C6C601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767002690;
	bh=TOivJ4vV1ivSp7XR4v/C2gNW5f1N2RT82h/XRsYfGIw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Fx1tWeqt28T5B8FnSfaxu27BdCgKN/1wh62uolHycf3rQTwogXRJVOR/V7G9VubQm
	 3wrrvD2SiqU7GvaC2SdCEZqHFRI+qOPsvKcFvxcoWwbAfkyt2b1Sd7u/WAl8pHpLY2
	 z4mJYdIBTUm/NuJQxwageK1E2eOHHvUvdFxVds/s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E122F805D6; Mon, 29 Dec 2025 11:04:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1D82F805DF;
	Mon, 29 Dec 2025 11:04:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D029F80533; Mon, 29 Dec 2025 11:03:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 334DAF80166
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2025 11:03:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 334DAF80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1885a783a6fde000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/668@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/668@alsa-project.org>
Subject: Asus vivobook 16 x126100
Date: Mon, 29 Dec 2025 11:03:35 +0100 (CET)
Message-ID-Hash: PC6CYP4FKVZ665XMZV2SSPWLMOJR5ZTH
X-Message-ID-Hash: PC6CYP4FKVZ665XMZV2SSPWLMOJR5ZTH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PC6CYP4FKVZ665XMZV2SSPWLMOJR5ZTH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #668 was opened from kellermanrivero:

Add support for Asus Vivobook 16 (F1607QA) with Snapdragon X1 SoC. This device topology is nearly identical to Lenovo Thinkpad T14s or Asus Vivobook S15.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/668
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/668.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
