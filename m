Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D27FCA9ED0
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:28:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB8D4601F1;
	Mon, 12 Oct 2026 22:28:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB8D4601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791836924;
	bh=YJfz+nvbaFreFa5lpJhDF+HquFYbT0t+8/6MQlWxZrw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CTukuMhk7+1jDieE7eugdG9k4ghgLQJdE00gA6qfdOszTNtdawQJtkEzinYXMAc74
	 V6yOLwAn9tZ5Ly5FedR8Hp27WT92J2ETyFg94XMTAzbARTwIvNLK5f2AscRzmnnALb
	 o7uhT6RhrucmoBU4ft17Vc3MKCMSFYhiVV8i/FlI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56FFAF805E7; Mon, 12 Oct 2026 22:28:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A10B7F80602;
	Mon, 12 Oct 2026 22:28:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 748B3F80526; Mon, 12 Oct 2026 22:28:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791836880;
	b=aNHpPd6OmlaOOt0Z0k15cxQNlQfxBE9OTHm9Lc6arANX4Qg0OcjXTUOXn0GM5EFcj/Hh
	 1ZgJDyNB4+i6SlhfJL6HWM0BxKcn3iXwemu2C+72UBZec8XQUbGtsfEo9LJ/rnIlhClMT
	 8XPcBlW3BcKCb3uz/jcw0QC99x+zqjdQLhpxdELrL2xExdIUMLzu6jl4zEQSV7NicHMaS
	 sLfVwuVdnRMA+lBbG8ofS/6TaDI3c+KcqNfENDUoCMQR2uFgaFQnPi/f4OvO6h7JJ8rcT
	 V/QMsficQ6snbBPTgWF8NRwOSDUi5GG/fy8ojKTsc1CIYa96Wu+p34kKknMtX+/knjA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791836880;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=YJfz+nvbaFreFa5lpJhDF+HquFYbT0t+8/6MQlWxZrw=;
	b=cMqsgG4z1Tod6w2yhZL4qmPJox9N0qf6/gNu1gBgyiHUQldANYqfAcwx9K1ZEDGPCiRA
	 IAttFoIrp3SK9bnfoT2Y6pTyuuXbi8n1QaJOXhra7R2QaH9wNOetd2RzI3ho5X+voZwVR
	 5bgkRap03th4HlSuVOEsPfDhmZUU26qA29lSgCbBDJF9z7dxQsy5D1KYpVx/zMLXyd/Mo
	 7oDXyq5iYFtprVboFhPq43/vyAdv3ZRYcmZIf98aU9rCbQ4HRz6I0kVzyX7vviv9E9A8s
	 5dmkcdsme+Gp5TSKdQDC1kTx9gk6wwantApHBAWpjwrYwXd3nylczRcGeYimnh+Eirw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F23F80424
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 22:27:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44F23F80424
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dde225a000bf00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/875@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/875@alsa-project.org>
Subject: Topic/pr410 bass speakers
Date: Mon, 12 Oct 2026 22:28:01 +0200 (CEST)
Message-ID-Hash: IMUCSXJGD5WOQZYXZVSCRDIVVN3Y4PKG
X-Message-ID-Hash: IMUCSXJGD5WOQZYXZVSCRDIVVN3Y4PKG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IMUCSXJGD5WOQZYXZVSCRDIVVN3Y4PKG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #875 was opened from CSVincentS:

Follow up of #533.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/875
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/875.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
