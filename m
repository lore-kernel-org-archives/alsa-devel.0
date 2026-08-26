Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B26C5DF97
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2026 04:37:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B12FE6025A;
	Wed, 26 Aug 2026 06:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B12FE6025A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787719055;
	bh=x6fsCW8Srz2kw3/ypQqGDgBNyNdC7/qTKb+eWGVSerM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=E6ccbht1EoEiZ5YjrTyYhsce60TdaxS7sENE8tWY0uFu+tOs7ErcP3hX+PJCEYztj
	 4jj8niNgbMRBBZjMmOHVk/KsVz/SjcDgX5Q5+PjIDTRQZ3vD3djM4TVDqVbTqjmWdH
	 6eX2gHZEOoyvMcPYAi7xyMt5vGRwxyEtVM/FW1gc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4878F805F2; Wed, 26 Aug 2026 06:37:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5E06F80601;
	Wed, 26 Aug 2026 06:37:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4112EF80525; Wed, 26 Aug 2026 06:36:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787719010;
	b=hCG5tHt0gWf1QTWQAoCF465SCL4yhLZPlQZEElMJIG1iPfR1KOHsG0xlRpp2Cf1wc2Wh
	 qEHO7AR9MAa73gX1vGly9dVyw3oK1wnlHetYBzfFR8JgyWigALwyCe7rrO7ZAjdT0/IQ3
	 EqB1E9r8IihZzzP33VtFe45tRTjPIgZ/YQBH564dGekdutewaV1bFI1RU+igQFrEKq/HA
	 3LLm6FkXcG5m+L1wRRam1twToHA7A4hLXvu//MH4HbVkNuOR3qdEL61Ys7XSUlsdL5pg1
	 vtUCZw1DLiCNfPnCvtXV5Bvuqs8b1JvopqR+SvQ627QJRM5sTuAMkGyAphXAXoP7Kgw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787719010;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=x6fsCW8Srz2kw3/ypQqGDgBNyNdC7/qTKb+eWGVSerM=;
	b=AKRu3N8IwbZmNampmc42ETdj8SS3a/1ztP6915cM4rMeYyQpDP4tPZRprAFoTxLIB7Ow
	 xZTjHxMWk07DXSu1ibWPV8cgdd/kWu/h3whwv3Sow8FWD/fbyYpuLRK/Gzpy4oJMJNh/C
	 jF6HpfTZuoTIGVcuHgzjVAJsh8VPZPv6djMiADm9WBAtUGs2eUmnTXsDerXIZytpfEoxV
	 tG5TN3VQI7JhBBx2CSsDWyGC2MXrIPFGvfsAgV1xv6KrngmzmqL3Ngd2rLlqGtlJUAYB1
	 s1MFfeZyL2m3y/U1YPNE2Sqnu1OJWaYZRote2HFqEhOUwQLY/BGefqkI6AHsWpUFFxA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B2CEF800C1
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2026 06:36:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B2CEF800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cf40f763c62200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/839@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/839@alsa-project.org>
Subject: ucm2: sof-soundwire: add basic tac5572 support
Date: Wed, 26 Aug 2026 06:36:51 +0200 (CEST)
Message-ID-Hash: 2A6RARNHLCLQ3E24UD6AE5INWCTOQHHH
X-Message-ID-Hash: 2A6RARNHLCLQ3E24UD6AE5INWCTOQHHH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2A6RARNHLCLQ3E24UD6AE5INWCTOQHHH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #839 was opened from niranjanhyti:

Add support of ucm2 to Texas Instrument's tac5572 codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/839
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/839.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
