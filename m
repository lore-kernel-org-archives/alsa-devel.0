Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D2EB362F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:02:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC37360246;
	Tue,  3 Mar 2026 16:02:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC37360246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772550163;
	bh=2P2uwG2grQvHPX/IGAFkagB8LV1VkAQrIzhDaLaKvMw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fAL5K34O8EqMqlHc7ebRUFLsu6SeHSETXBrkJEgkwwb3qVpcqAqGJ7o+Yu4Y2G6oR
	 p5ij+vEECneU8X+DB6AIiJXQUq8diE4rNMuC49hZpru/lkf7sVqMm70Q+LFhslZJ29
	 g4EdkIIdnPIlLdlbV/xdL177Gh2hMGD8/lzmSJ+I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29E10F8061B; Tue,  3 Mar 2026 16:01:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C6D2BF8063B;
	Tue,  3 Mar 2026 16:01:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56468F804B4; Tue,  3 Mar 2026 16:01:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D0031F8015B
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2026 16:01:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0031F8015B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18995ce80c622200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/494@alsa-project.org>
References: <alsa-project/alsa-lib/pr/494@alsa-project.org>
Subject: control: ucm: add ioctl to retrieve full card components
Date: Tue,  3 Mar 2026 16:01:26 +0100 (CET)
Message-ID-Hash: ND3X5TZUJXWAZXXIWZMRK75SEEJQMMJ5
X-Message-ID-Hash: ND3X5TZUJXWAZXXIWZMRK75SEEJQMMJ5
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #494 was edited from mstrozek:

The fixed-size components field in SNDRV_CTL_IOCTL_CARD_INFO can be too small on systems with many audio devices. The kernel [1] will provide a new ioctl to read the full string while truncating the original in card_info if it grows too big. Make sure alsa-lib can read the full string if the original is truncated.

[1] [link to v3](https://lore.kernel.org/all/20260303145815.9930-1-mstrozek@opensource.cirrus.com/)

Request URL   : https://github.com/alsa-project/alsa-lib/pull/494
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/494.patch
Repository URL: https://github.com/alsa-project/alsa-lib
