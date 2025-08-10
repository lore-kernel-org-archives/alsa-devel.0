Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C96C87FCF
	for <alsa-devel@archiver.kernel.org>; Sun, 10 Aug 2025 13:27:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DF016023E;
	Sun, 10 Aug 2025 15:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DF016023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754832424;
	bh=dpzA38ObbJaPjmxJi5T6AdAXxzPC3nYR5HYQpToJCuo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bQFxUhNH/+vr4LoE/E0FXkrTzTJmZAyyeMClrBkhuqBk+gwBAKVL+jJCNYOj1Ch1E
	 AWPNtbXkzuPF1c0FFL2wTEdGEAGg2jiGJytBP46RlZCAa30CsV+aohPlKIWzeorAhO
	 jDv/Q4TKbgVZI7t1fXGelq7v4GpMqNsC4ba2NNPE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5030F805C9; Sun, 10 Aug 2025 15:26:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E0B2F805D2;
	Sun, 10 Aug 2025 15:26:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91167F80272; Sun, 10 Aug 2025 15:26:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 38399F8010B
	for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2025 15:26:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38399F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185a6abede399400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/601@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/601@alsa-project.org>
Subject: ucm2: Qualcomm: add Radxa Dragon Q6A
Date: Sun, 10 Aug 2025 15:26:16 +0200 (CEST)
Message-ID-Hash: YKABHRT3W5QWJNET2YSLHXNT4DVA3IUF
X-Message-ID-Hash: YKABHRT3W5QWJNET2YSLHXNT4DVA3IUF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YKABHRT3W5QWJNET2YSLHXNT4DVA3IUF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #601 was opened from strongtz:

This is an upcoming SBC (single board computer) based on QCS6490. Full specs:

- Headphone jack using WCD9380 codec
- Onboard DisplayPort to HDMI bridge using Radxa RA620
- MI2S0 available via the 40-Pin GPIO header (unused by default)
- AMICs using WCD9380 codec via a dedicated MIC header (unused by default)

The kernel device tree part is not yet but going to be upstreamed soon.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/601
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/601.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
