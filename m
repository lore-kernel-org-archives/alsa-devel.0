Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388FACA9ED5
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:57:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0C6E60206;
	Mon, 12 Oct 2026 08:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0C6E60206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791788267;
	bh=XaXyglQbhXLxkbdOJFZm2kEndseh26CnCh5WIEiz6+o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hFI0fV0mkAYbPvx6wDbfouUPnS5RwEZllxSeHFR2V3u+fY+slyLfeLLiZjIhO34iy
	 wtjACutq+dNeHlbZ5qUXOZrMSMn+M6PJ6vhNVMFqjl7xjeSuKRiY06JJBlwEtX3hS1
	 9X6ZQK+qDS77qYSdJIeGJUDf+Ox54HXJaomUKx4U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23852F80603; Mon, 12 Oct 2026 08:57:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B996F80602;
	Mon, 12 Oct 2026 08:57:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74F1CF80526; Mon, 12 Oct 2026 08:57:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791788227;
	b=lxFYAW/AH9RfiEinr6f/l/Lt9eaMekfzfG4JG77z/PitaXAlTFYH9roXVjqtZe1YsVgU
	 w/xuE2ViJyOHFx9tUmEzxM+nm6gXNwTUYE7l2kIx19Mx3Qxd0TDoCQkZA0Z10xZhgjmxM
	 8pFAg1dmejxWrPQEbj/8psAzAMQCjSmOKZQVcUPkNfR1aLME+7IWTL70DZwcF0nGiQZxQ
	 rraJ9JZn/R7wrPHWWF8lhM0mnNWLeg/of6TSxW70B0baIuS9MV0H4h1vebtCbw6Vzl6zp
	 a49nzsrR5ZenteA0zRPWXRoLsNBAAFgYm96uugPnU23IZeK9yDsTnhq/yymk/lm6mvA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791788227;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=XaXyglQbhXLxkbdOJFZm2kEndseh26CnCh5WIEiz6+o=;
	b=X5+kZ8Tzc9SkrUR0oQeyyqcjoTZ6VSzote78jfxsyEmbwhkcgSPagIKQiGtTGYITZgKo
	 qe5Jc4/VCf4qwH1qQIdBw6sCWOba2/pdzA9nxpN9KhOJ0oSeRWqCAb7mEaIIlSB47tB1m
	 cIJJDC7fdfH9uh0Ts/jIJC3MTVTq7d9ONoy3LZ7IqPIQ8VlKBlETx8KMdfaWIwX0o18nP
	 IhwGc5DkYv6BKyVLy2ZSdFgOBZ90TjQu6Jirx2jDb9DRqdhjiKw/Gfqu5otbT42PJgRm0
	 Dvo6EvdkHNyDt0Zvd0xQRvweI4HArsqAD5LobEc9MyghXSEXsAc+Xl/QtqVgr2OEQ2Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 50AB6F80100
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 08:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50AB6F80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ddb5e6022ac800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/874@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/874@alsa-project.org>
Subject: ucm2: Qualcomm: add HP EliteBook support
Date: Mon, 12 Oct 2026 08:57:08 +0200 (CEST)
Message-ID-Hash: EZZF7ABQXAUGSYAMDBUFZKVNBPARWV4K
X-Message-ID-Hash: EZZF7ABQXAUGSYAMDBUFZKVNBPARWV4K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EZZF7ABQXAUGSYAMDBUFZKVNBPARWV4K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #874 was opened from juergh:

The EliteBook series is just a higher-end version of the OmniBook and compatible. Confirmed working on a EliteBook 6 G1q.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/874
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/874.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
