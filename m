Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E932ECCA46C
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Oct 2026 01:14:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B051B60202;
	Sat, 17 Oct 2026 03:13:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B051B60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792199646;
	bh=MLWUEg+w2Si9d22iQ8aP8ojcLc9oT/yWQKU18cpGjn4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nT0pKz1+GYf/CH89XklhuV5pRlGQxPbhg0gBYVIyNX798sgLLF/bcASl7GpGFp5HB
	 crHlPaLi/NmvzDfL3jvAhM2vGpZgl4l06qfV5NduGvlkJ3CxSt6zfTgvYYy25icaKI
	 S7lJjRjWL7afoIA8NBzlfZeOKVGccTXraKgPgEa8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D63A0F805F8; Sat, 17 Oct 2026 03:13:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DCF5F805F7;
	Sat, 17 Oct 2026 03:13:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8995EF804F2; Sat, 17 Oct 2026 03:13:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792199604;
	b=KlT4WBlbjjqMpx/tI8OtJJnRb0RC0Wl4mgAKmNyxNHmFAv/QW+tax6g8yT2lYSe2AJGe
	 IQMGGBy/LFEqyehpoEjiXO5QAj3+kEQ5VsR5udL7ilj7hWERw+8n39+hBg5q/ktuYTTTM
	 P0KGcrO8O6bPIfTJsYE2ZbcWN3mIroHXLmNZNIPxulktcItSi+bkdalq9p2JSnfNdvalt
	 y3EC4NFgy4aYYitCiNggfugul7DbV0Iyy8pwfQsNBnbub+dwrAtMHxFY7tbSvXKaMqyJV
	 5CC2VVC9xmgYw3mOmQAfr0kF29okByzEYbrlXB04P49ZeGfX6F2K4xPnhUL6Jy2dw1Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792199604;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=MLWUEg+w2Si9d22iQ8aP8ojcLc9oT/yWQKU18cpGjn4=;
	b=BwMrTDRW5xCzVJBzDoDtgDcYZfIipkqvYYzMBlQzhJzsMGtW/z5xLEnciWDABiFTLHrq
	 tAGOI56Ukg2C8joCcvFPeXdZZ+6/tBZW6IsxIvMGTwyFJsO9UsBiAFrHRtZRHIou273ln
	 1SufmxT93xXvOiMVnjm42XmR+vOvzql62VLjEzIISepJcBq5eh9ulZmHqIjpE/C1ZpoZp
	 8c2kV5UHwhsJvRQrY70hMpyisex7pC98yVNwn+nTjszAvOLgR4yReV5w6PVv/BmoYwCNl
	 Amn/BP1w3P9tfiJLttmUrycW/yzihEOoB8VfTruGKUiPXyfiqu7M5hCij15p43IT3WA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E058F8024C
	for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2026 03:13:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E058F8024C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18df2c0afffe5d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/882@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/882@alsa-project.org>
Subject: USB-Audio: Steinberg UR44: support the non-class-compliant mode
Date: Sat, 17 Oct 2026 03:13:25 +0200 (CEST)
Message-ID-Hash: P66VDPWXIE4TZKVRRB4SCXNP65UXTQ24
X-Message-ID-Hash: P66VDPWXIE4TZKVRRB4SCXNP65UXTQ24
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P66VDPWXIE4TZKVRRB4SCXNP65UXTQ24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #882 was edited from peterix:

With its [CC MODE] switch off, the UR44 enumerates as 0499:150e and has six playback channels instead of four: DAW Mix 1, DAW Mix 2 and an FX Bus that feeds the built-in REV-X reverb (the channel order was checked with the device's own meters). Match that id, split the playback PCM from 4 or 6 channels, and add an "FX Bus" device when the FX Bus exists.

The Direct use case is defined inside the condition, as UCM evaluates Macro before If blocks.

I'm working on fully reverse engineering the UR-44 tools in both CC and non-CC mode and reimplementing a Linux version of them. This is in support of that work.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/882
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/882.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
