Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DE0C88E53
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:51:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAFE4601FE;
	Tue, 15 Sep 2026 13:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAFE4601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789473069;
	bh=p18qBO8Xe/5cu+/+ZVGWn/7P9vc5MUQ3ypc+mZ3pIgQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hFDwuNcawO7NMohyCFgjFPXUdyd9l9x4BBMxkAFWY0wcC0yAJmGgv4+C39gAwg+NU
	 GsI4xsJ/jxs4ixGslCN2GS2OE0HnjcVqJZZKEGSOBHRlQ4rQL7KE3sDbo5c47lFsml
	 CGfxQfz88DOdzJStF/5xU5+v+I+YaUaz65SZXMa8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14BF4F805FC; Tue, 15 Sep 2026 13:50:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E793F80602;
	Tue, 15 Sep 2026 13:50:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 275B6F80588; Tue, 15 Sep 2026 13:50:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789473027;
	b=BiVFer7t6RkX+BjUC4lzisxfuvtB3K8IGHy0+ehKntIlULwqm6WMcHAv63F+J/4fE7ah
	 EaxN7lIZEgW3PhglcV3vrPgSCVTuuxwvEbhCn9l0lUx539PVhh897aXoEoUVpVO116Diy
	 jlQkVAv+y2SApV+ce5iUt0SSZPg7/qcujdLPdk43OW+1fE9Iqws1/jO+y8NRvAVymxQ5h
	 I3yY0O3xKwqkt/Tqy26BB4OVykCMNQY681dlyTNjGk9AV+/iBMdwT90FnkIl+2NyTYsTK
	 QyUeAD/RqYZoTbT85xbqVxpStbb/Od8vySO7oLey33CS9vHXColn1nLOhZpsWhAOf1A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789473027;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=p18qBO8Xe/5cu+/+ZVGWn/7P9vc5MUQ3ypc+mZ3pIgQ=;
	b=DmsoHz/UdvPIoGVw2OC8YdMkbP4AZsewbpW2OLTUUJZg5fT5urJeppOhvJGqaSA1Y+/K
	 loUiswwptPHl9kvaUinww+eR8qC6lUCaLbCbfZ4N8bKmx17vEJ24gslQUiOrGYjeUXGPE
	 /MItRL03gNOPPw+I30B4trIw3Xc00QPpnmgSpb0ICbVVKxDKx56SgGfITA+M+nPY7eMvt
	 gn6ptQO0ECYsltmvytESZtwdGGfDfVe/jJBmvgkMMC2vYSRxTCFon6e7TOJg6FF8nCBF0
	 nDJWgxEmYYTAaLBllnWIH8aMKrhDqIq6DSiBZioAwA+mKpZKzd5PdbvdJmhnsn5FxaQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 72532F80217
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 13:50:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72532F80217
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d57c3c6a708c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/525@alsa-project.org>
References: <alsa-project/alsa-lib/pr/525@alsa-project.org>
Subject: async: fix snd_async_del_handler for TIMER type
Date: Tue, 15 Sep 2026 13:50:28 +0200 (CEST)
Message-ID-Hash: 6DGIJC33W5C6DFBBUM3XHYWYH7BAMGBF
X-Message-ID-Hash: 6DGIJC33W5C6DFBBUM3XHYWYH7BAMGBF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6DGIJC33W5C6DFBBUM3XHYWYH7BAMGBF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #525 was opened from LilyKing2026:

## Problem

`snd_async_del_handler()` has two switch statements that handle `PCM` and `CTL` handler types, but not `TIMER`. When a TIMER type handler is deleted, both switches fall through to `default` and trigger `assert(0)`, crashing any program that uses `snd_async_add_timer_handler()`.

## Reproduction

On Ubuntu 26.04 (alsa-lib 1.2.15.3), running `selftests/alsa/utimer-test`:

`global-timer: async.c:166: snd_async_del_handler: Assertion '0' failed.`

`Aborted (core dumped)`

## Fix

- Add the missing `SND_ASYNC_HANDLER_TIMER` cases to both switches in `src/async.c`
- Include `timer/timer_local.h` to access the members of `struct _snd_timer`

## Testing

After rebuilding and installing alsa-lib, `utimer-test` changes from FAIL to PASS:

`# PASSED: 2 / 2 tests passed.`

Request URL   : https://github.com/alsa-project/alsa-lib/pull/525
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/525.patch
Repository URL: https://github.com/alsa-project/alsa-lib
