Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B388EE784BB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Dec 2025 03:50:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18BAA601E8;
	Thu, 25 Dec 2025 04:49:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18BAA601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1766634608;
	bh=BSOwh3twLaq9kinRWjumiN+907iK3H4AsUJY8mOkamo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=O5DfQr+JiJD3bMEt2ysc6KnOtHveZpZWkjUERMnDiHPFMCEF7+iAqv4Xk3OG1+qnz
	 B+OTZni+3wtrInbKaLLFJ5gNJw4lW9Q94dm+PsNvjNpECDesbb0pikRpCyT0jXd0mQ
	 gpgrQwwY1MKu1JK7svnahEo5S4x0foMHsuMNdlbU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EF68F805E6; Thu, 25 Dec 2025 04:49:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8734F805E5;
	Thu, 25 Dec 2025 04:49:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2BAEF80169; Thu, 25 Dec 2025 04:49:27 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D282DF80100
	for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2025 04:49:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D282DF80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <188458c6dcf64100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/667@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/667@alsa-project.org>
Subject: ucm2: Qualcomm: Add Lenovo Yoga Air 14s support
Date: Thu, 25 Dec 2025 04:49:27 +0100 (CET)
Message-ID-Hash: IN25TMBRIJGJN4AAOT27SB3KEURCPL2R
X-Message-ID-Hash: IN25TMBRIJGJN4AAOT27SB3KEURCPL2R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IN25TMBRIJGJN4AAOT27SB3KEURCPL2R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #667 was opened from shawnguo2:

Lenovo Yoga Air 14s laptop is basically a Slim 7 for China, and they share the same audio configuration.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/667
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/667.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
