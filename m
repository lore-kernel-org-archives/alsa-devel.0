Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD281C43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 11:22:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45D7F6021A;
	Sun,  5 Jul 2026 13:21:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45D7F6021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783250525;
	bh=Y3k8CxNYzNyKthkedfawQNsFPD50CaIRpUzlo+GCEx8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bOqXz3BThk1a54+Tw+s+E5Jpa3T7stxKpjB3CyLLVtII4KJiIOHmYI/TrCSrJM6x5
	 ms1OHjX3eWXz0Lx2rgg+0VOXm6TGqIc+VJ+kfvB+WlMQCs0qoQyNjRZ5XWG6DVMOYv
	 JDQBiPCnKe9/J7rfC/xPAl5auLc4OM7X/M2lz2Hc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99C2BF805FC; Sun,  5 Jul 2026 13:21:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 548A9F80600;
	Sun,  5 Jul 2026 13:21:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60BDDF80526; Sun,  5 Jul 2026 13:21:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783250483;
	b=ri2x6yg/0Tb/oKIrE54ql0mvnMECinD6Ag7MRdiVAa4acES5E7Zxo6s4QypsHkuITZkF
	 XgpZYhi/cl+tRr5kdQLJ+5XzCSlVLCvFGsTcUFv2D+M52t9zBqwQDeSsmoz+zZxYzp87J
	 aXccpoeyPc8Y1SM+XFhe99fUw9shwN92vMN9mm9RRCgzdoECu0kIRudrc++FmycdihtjR
	 GYquSsMMmwdFvWIc4E0ctuHkpmZbiIPjoDhRl9hWuNtcWMOmuCJIf1/aWrXLbP1DS90gX
	 AdPIHom1NwlZwShOqYHV0q7nTnpgjq18rq3AuyMgyeJIy2Nyp8WUgZK5GSPQA7til2A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783250483;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Y3k8CxNYzNyKthkedfawQNsFPD50CaIRpUzlo+GCEx8=;
	b=dPn1jncZLiKKyu6WcunthMGQT+1+26KnmU8oLWhCx0PILeQjwMLf5M/5zMr0HteObhwG
	 dn5X8sdBeW9dQKNLYC1mxRqbhUw1w1tGrs0PA3ert+1Kqxs6eV40UfrTfiJNOxkvL6wgR
	 WpW8cxAah/vESncO2rTjH/XYvOXBuZaMKw6YvdGlUVtNVuCrpuCuVWLnsdVFIwX0DZCI8
	 kaxTs4Ggc7CT8Q4HxKwpXnNcJqs60d6t8gH5meA7DbBCQWORIa2kik86kcRDJlKBvYMJx
	 K5SXb2tub4oUR9kRw/DmidiA7i+hcXOyQfyIiwzz62e+WR6kAK6trw/G1yBpO4ncM8w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BB6AF8026D
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 13:21:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BB6AF8026D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bf60dd6695ef00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bf60dd6688f500-webhooks-bot@alsa-project.org>
References: <18bf60dd6688f500-webhooks-bot@alsa-project.org>
Subject: [Security]FPE in alsa-utils axfer `wave_parser_pre_process
Date: Sun,  5 Jul 2026 13:21:24 +0200 (CEST)
Message-ID-Hash: 6ADJO7J3PSYAEHO36LD736KSJJFREEES
X-Message-ID-Hash: 6ADJO7J3PSYAEHO36LD736KSJJFREEES
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6ADJO7J3PSYAEHO36LD736KSJJFREEES/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #332 was opened from eglonnnn:

### Description

A floating point exception vulnerability in alsa-utils v1.2.15.2. When `axfer`'s WAVE container parser processes a crafted WAVE file missing the `fmt` chunk, `samples_per_frame` and `frames_per_second` remain zero, causing a division-by-zero in `wave_parser_pre_process()`.

### Impact

- Denial-of-service via process crash
- Any user processing untrusted WAVE files with axfer is affected

### Reproduction

All materials are available in my research repository:
https://github.com/eglonnnn/opensource-fuzz-vulnerability-research/tree/main/FPE%20in%20alsa-utils%20axfer%20wave_parser_pre_process

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/332
Repository URL: https://github.com/alsa-project/alsa-utils
