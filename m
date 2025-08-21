Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F15CA0EEB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Aug 2025 19:32:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD56260242;
	Thu, 21 Aug 2025 21:31:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD56260242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1755804717;
	bh=hNdwWNVTwfY0CgMTjIeyx+twJ2xXZQ2HTKPyqcUJOOQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CFy+eisQ6oE6i3QR+W8iSi0ICv38VHTHVlp4uHHQ1BzLM0SkEA6XMDpgUNTM4jgGx
	 a0QkbwoCdWciUp6Bq+Ew4R9tpkbTkws4nT5uzumxDMWD4jbdL4uxLb3hxoSm3Tu1Ch
	 hrPi/tZKJAA20E+gggDOvdidnvZV2tkCCHZIV/tU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D85C1F805D9; Thu, 21 Aug 2025 21:31:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B14B3F805D4;
	Thu, 21 Aug 2025 21:31:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49486F8052D; Thu, 21 Aug 2025 21:31:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 81F64F80254
	for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2025 21:31:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81F64F80254
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185ddf0efa85c800-webhooks-bot@alsa-project.org>
In-Reply-To: <185ddf0efa53ce00-webhooks-bot@alsa-project.org>
References: <185ddf0efa53ce00-webhooks-bot@alsa-project.org>
Subject: Mute LED not working.
Date: Thu, 21 Aug 2025 21:31:27 +0200 (CEST)
Message-ID-Hash: 6SVBD6JQGGUXAORCJKHJX3C27MFMXKH2
X-Message-ID-Hash: 6SVBD6JQGGUXAORCJKHJX3C27MFMXKH2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6SVBD6JQGGUXAORCJKHJX3C27MFMXKH2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #473 was opened from Gropinou:

https://alsa-project.org/db/?f=a68feee728b669f547491855254add15fddad73e

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/473
Repository URL: https://github.com/alsa-project/alsa-lib
