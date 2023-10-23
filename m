Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39F1C25B42
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 21:59:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66C8686E;
	Mon, 23 Oct 2023 23:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66C8686E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698098364;
	bh=GJQtFrstnwTBAOsqyDx2CcNPhYEQ9DUGGxkDY0G766Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T3Zd3haAAyrkroQx9nQspN6wyM9k5Mns9htBHPFEJ77EgbMdNYhOWPk60fqSXiRfr
	 Xh667vLPwTh9aQmy94vb0tUYoggncJ+RCBlNpVzUOdnVaiSjd/lgjQz+huUeFtyisw
	 3k31jJV+D2tWdShru6/bWfx+q4WnRwVA6VjvcrdE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B66B7F8055A; Mon, 23 Oct 2023 23:58:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58374F804F3;
	Mon, 23 Oct 2023 23:58:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCC49F804F3; Mon, 23 Oct 2023 23:58:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B27FF80134
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 23:57:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B27FF80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698098275600102663-webhooks-bot@alsa-project.org>
References: <1698098275600102663-webhooks-bot@alsa-project.org>
Subject: Add UCM2 configuration for Topping DX3 Pro+
Message-Id: <20231023215800.DCC49F804F3@alsa1.perex.cz>
Date: Mon, 23 Oct 2023 23:58:00 +0200 (CEST)
Message-ID-Hash: FM5UOW3YZEWHCGRBQZOLB47K3ZEYVUFX
X-Message-ID-Hash: FM5UOW3YZEWHCGRBQZOLB47K3ZEYVUFX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FM5UOW3YZEWHCGRBQZOLB47K3ZEYVUFX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #362 was opened from ZVNexus:

Fixes it showing up as "digital" and "analog" output in Settings, should just be "Headphones".

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/362
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/362.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
