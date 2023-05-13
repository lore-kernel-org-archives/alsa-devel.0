Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85B7C77B7C
	for <alsa-devel@archiver.kernel.org>; Sat, 13 May 2023 11:40:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2572DF8;
	Sat, 13 May 2023 13:39:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2572DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683977998;
	bh=w3KATCyTOBSjKXftw9D+uWvQllBWSQT5G/Fr64H+PPA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mXew00k8du1BNXxwXxs4Ru07wcxGasZfaC0KwRUayrlsJ/lJbefwGgxmyBE6z7ccr
	 LlhknlLZ91+2cCFAYqBLjgdmRHzAo5lo+PRwyIwOro3GIWrCVYDe5CHsnCjnYPWDeL
	 Ayv5AQcZ7wAZiGwnO3iIV5UFSKqkCORBUP+OOgx8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 001E5F80549; Sat, 13 May 2023 13:38:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 707A7F8014C;
	Sat, 13 May 2023 13:38:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F16DCF8052E; Sat, 13 May 2023 13:38:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B4F5EF802E8
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2023 13:38:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4F5EF802E8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683977912283395290-webhooks-bot@alsa-project.org>
References: <1683977912283395290-webhooks-bot@alsa-project.org>
Subject: 1.2.9: arithmetic exception in pcm/pcm_hw.c:753
Message-Id: <20230513113835.F16DCF8052E@alsa1.perex.cz>
Date: Sat, 13 May 2023 13:38:35 +0200 (CEST)
Message-ID-Hash: EOVXC4XJVPEADPVOETZHB4YVYN45HWRO
X-Message-ID-Hash: EOVXC4XJVPEADPVOETZHB4YVYN45HWRO
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EOVXC4XJVPEADPVOETZHB4YVYN45HWRO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #318 was opened from engineeror:

[`period_size`](https://github.com/alsa-project/alsa-lib/blob/904f0f7e7a29244c05e5874bc36486638d1f7e7f/src/pcm/pcm_hw.c#LL753C33-L753C33  ) is zero on USB DACs: https://bugs.archlinux.org/index.php?do=details&task_id=78476

@perexg

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/318
Repository URL: https://github.com/alsa-project/alsa-lib
