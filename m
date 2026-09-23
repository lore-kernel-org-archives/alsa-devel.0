Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21A7C98302
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:12:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E56F7601E1;
	Wed, 23 Sep 2026 07:12:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E56F7601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790140359;
	bh=ZYy5cTEreuQmajIGaR/VpiBkTMBPrRi00U/nK1GjA8w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=P7BYZ7R9xOW1EXkUmSINv4Ntj+hvgp2LpXqBTMf+3YbeYaHo2UXVyzF7KeMQXeLek
	 /PvUadRD7kDr380/sO9zWY72Z7qw3qiWRIcLLF+K/goSv2cS8sfvzTpUWLA3nK156S
	 wuIRVh1tYkO2Rcp3eh+eeT9cEtRW03aHYNL0cVkU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53D57F805FC; Wed, 23 Sep 2026 07:12:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F776F805FB;
	Wed, 23 Sep 2026 07:12:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A41DDF8051F; Wed, 23 Sep 2026 07:11:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790140316;
	b=k0uTDwDEWqkLyIWQVZLROEg8qwpnMClfiPbg+dXBWYSopsaRgKqGS/wNURPy33ib00yh
	 NjAeAhYQIAspVL2U+XaPdpOLLMggnySAxIxatWh8ofq62GasOf1VnVuDD0QZgeVbf+ouU
	 xDcQrFQAOqBEivwzZwkV5zAusnGPmHZ+7x06wdRQnP0KDLMuhqaW+Zj9PIwZcTarworXA
	 WrjxMwS7HOXtpu5FUAICtGITs/PLk63jI8RCsZVYx/8lr9pCQs1che3UZBNtXvi73NZi0
	 g+Wmsrrn0B85xoDwM6SH47NuH4dAeuIm6dan2PBWpLx6HpbqZ7j+BPmLL0OsIho8Eog==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790140316;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ZYy5cTEreuQmajIGaR/VpiBkTMBPrRi00U/nK1GjA8w=;
	b=Wg896zxw6/OGKrxojmFK+tO2YGJennrFPS+/QahNX9yUYyFnTpgndBUnSFngwO+jybJN
	 pcfm3tf2dKSpEDz55VKfpXb+4X5aM1yva5BIpQMUemWUBd6yqejW0smXl4rCBcZ4F7uGt
	 e7HVDgZZXAjBQurumetVSBT2SLF9xCkguQj7g9yQydMj3lgkDp7hR0wkMlqZeIGvMlq0B
	 uphJx9HwQdJI83QFOen3oT3i1GepZp66wXPPAPRP58RqgZY4mpUjUWwf9k7/8+xwuJdrE
	 DGKMohQUzV3ZNvLt4XsXuJ7MbEtp3TKJZHdUYGmb4u6QDVeX3+ShIaOaTJGOvu1pw/g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C9FACF80246
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2026 07:11:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9FACF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d7db21d44d6f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/860@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/860@alsa-project.org>
Subject: ucm2: Qualcomm: open up HP Omnibook support
Date: Wed, 23 Sep 2026 07:11:57 +0200 (CEST)
Message-ID-Hash: KKINPKGVW6WXLGOGYHL5STKSPVKVKQGT
X-Message-ID-Hash: KKINPKGVW6WXLGOGYHL5STKSPVKVKQGT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KKINPKGVW6WXLGOGYHL5STKSPVKVKQGT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #860 was opened from jglathe:

It was specified for Omnibook X, but apparently all Omnibook aarch64 models use the same config. That would include Omnibook 5, 3, the g1 models.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/860
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/860.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
