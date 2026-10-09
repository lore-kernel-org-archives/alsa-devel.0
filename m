Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D3CA6019
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:01:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B581601FA;
	Fri,  9 Oct 2026 15:01:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B581601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791550902;
	bh=iED8NM8/MUPtdkWk2aTyM0YUZsrhhvxAgbIc1Wy7SAk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IBGR8Lem/1AyI2O+KiLWP2hNgeFOGWq3zJQWXAXfeCd6fTrxTiXn79S3hJSo2J1ge
	 uoUmbmI+/BcPkNvPssVNywHcp6XT1EVJJ2mY+01dBXmRTeTeSb4bNeF6MTT/ehTdM9
	 45Ooes+6B4y513Fd0nsbwJfTT+Xw2X8priwXlDsU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9E10F805FD; Fri,  9 Oct 2026 15:01:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9940BF805FA;
	Fri,  9 Oct 2026 15:01:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93A3AF80557; Fri,  9 Oct 2026 15:01:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791550862;
	b=n3kIOaD63U62vuNzUseWiCqrAzVqGpDRo8kfnoUkYQqhJVQHsP3G/4rBMqC6UNQ+zlUM
	 kjOnIVhAOzMO2QxfEOfDBwjsFMk5sy1U4BHQTvg7Kq1/KwH9gZnAT9zLFQ/t/bfLcg0bm
	 nNT0d8hrumB6YtJicvMP1tBI8gGci5MMEbv1yERyxz20ADai9du7O+2+D4cENo0ksvoSR
	 HNBnyq/EwMEV47RNuldzdI2HaijhQ1kCYHr11eO2kPyxE2uD2q9fYq9vC7ucuqaexPPKv
	 YdQZ0LT2fPrlXkEgfKA9B1vqugDryh3p6iBaW353wFg41WfvR6YAvm2yhuGvhLFNEMw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791550862;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=iED8NM8/MUPtdkWk2aTyM0YUZsrhhvxAgbIc1Wy7SAk=;
	b=SPiKdU4RsGw8xQp4JztF2s+If4egRIC6D1mvROU1ALGoFReFzLNWfzxoE8PkFX+csYdQ
	 uC+MrpQOUUMez7GUiE+gn+6a0PwBM2fNflPHHJ2PiOXNmLW0OrP+JzW5Zzz9h5GfDinri
	 nX6jrLPXJufCBILwvkeWgsyZ5LWQO1veliD1DkfYIPOsPuxR4xl/6TqmD2VLfZBe7MY3o
	 CTDveYtcefIV8HOq3q0P0dcg5oObFokybHvVweW45tYS4syC5HSqYM/QJbLeWAziD4dyY
	 y8YHrM66r0W8jEMTP1MZOh4YUIEiFmDe8gKahYyQ+CfcVLePbLQkIRnIgHoi0/bBSNA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E3699F8026A
	for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2026 15:00:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3699F8026A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dcde02a0542e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/337@alsa-project.org>
References: <alsa-project/alsa-utils/pr/337@alsa-project.org>
Subject: topology: alsatplg: add double-expansion for global defines
Date: Fri,  9 Oct 2026 15:01:02 +0200 (CEST)
Message-ID-Hash: OOZKDNWE4ZQNBYSSAI43U3OWMDMW4ZYO
X-Message-ID-Hash: OOZKDNWE4ZQNBYSSAI43U3OWMDMW4ZYO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OOZKDNWE4ZQNBYSSAI43U3OWMDMW4ZYO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #337 was opened from kv2019i:

Add support for following definition for global variables:

  IncludeByKey.SDW_DMIC_PCM_CHANNELS {
    "1" { Define { SDW_DMIC_CHANNEL_CFG $CHANNEL_CONFIG_MONO } }
  }

This doesn't currently work as the pre-processor merges the nested Define into the global define registry as a STRING value ("$CHANNEL_CONFIG_MONO").  Later, during object attribute expansion, pre_process_object_variables_expand_fcn finds the variable in the global defines and returns immediately with that unresolved string.  The caller then passes "$CHANNEL_CONFIG_MONO" to the token encoder, which cannot parse it as an integer and silently substitutes 0.

Add support for double expansion for such global defines. This is similar to how local variables are already handled (see commit 0029ab7cc7c7 ("topology: Expand attribute references inside $[] expressions")), and will help to reduce repeated IncludeByKey statements in topology files.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/337
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/337.patch
Repository URL: https://github.com/alsa-project/alsa-utils
