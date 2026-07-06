Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2760EC43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:30:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A204260224;
	Mon,  6 Jul 2026 16:30:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A204260224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783348218;
	bh=z6xHBo8XH0IohqPNQRveFdfORxI3UR7KjmJjlEJ4fzs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VHB8T5RbQH8j2sn+Uw0jP6S9QDos07TwuvnuMUOestGUVcIfLQ2QBaVJE3z1ibN+k
	 lB7ZsO7tJowBiakS7TGslApFttL4j6HkF7zcfd4Ptlbi+dVC4KlUk28QdUdChiHYfu
	 vT7lTSUn1U9Z3pLgsx3Gn1B8+raMx+4I/OfIXQ8A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E0D2F8061E; Mon,  6 Jul 2026 16:29:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 12F33F8061F;
	Mon,  6 Jul 2026 16:29:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 971DDF804FF; Mon,  6 Jul 2026 16:29:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783348163;
	b=Pe2vHjRzjnNG4LCdoMlzrfLBtHYPKh1YU66hqf02UO/Y8+Vf0LFzV7Z2dWKbneayaneu
	 45kWxNhAJrWSljtVyG6igEOf0ti49sZYEht9RvDp1v4y4kdy3jhcCcRTR2XMHmsl48fbb
	 RtLyLGxczRI2/xiWTfXB6YfgBmdes7SkPFoJEMs04lc2u+A40fMdIGUcS88QwSRutzCCT
	 Bghqh+HoWAcUKT5Bz0eZUwbLN98/8AH9C+TsVknXT/YH08kVc1ko2O5+T5ijf+4FPFGyB
	 S78JGH7SIZu86l2rmm4pl38ujXd35GcFTFOoN+tRW+eKVpVlRH+QaUtMy7xzvzLqrrg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783348163;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=z6xHBo8XH0IohqPNQRveFdfORxI3UR7KjmJjlEJ4fzs=;
	b=LeKv1JLAo4OY0aMf3o58jKCKApdbBDIKwTQp0rxprUecriyjUhBCbw4BpHgLH9kJjyAc
	 qt+K4wpnnBBpz9MHhjqcwDh/f6KBq1IQDzT/vjdMOnrN9eGTslsiWkL6DotAxW5XySD1G
	 p5AJyz2rTz0fJyg0q915xW9Yl49wHbC5kXImqzpS/rosN+3L0exKXn4Z5MsECaYaEn5iY
	 F+RMbMZrPPQx1lwsuA5AINUcD2jPW5On5euCWuqucxCLnNmLz1nRDB9Jm1Me9uO71gI/S
	 KL3nJ92EwNXKElhV+Bl2GFV0nJK7pNAZcGouQWHvcsm1aXLdQt9uwClQnxwL6pFRUgA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 15B14F8025A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 16:29:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15B14F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfb9b4517a7600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/806@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/806@alsa-project.org>
Subject: rt721: enable capture switches by default
Date: Mon,  6 Jul 2026 16:29:23 +0200 (CEST)
Message-ID-Hash: ZADNZKYCYW3AP5DHYLE2S6AUGHDLFB3F
X-Message-ID-Hash: ZADNZKYCYW3AP5DHYLE2S6AUGHDLFB3F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZADNZKYCYW3AP5DHYLE2S6AUGHDLFB3F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #806 was edited from BenSharir:

Enable FU0F and FU1E capture switches in the RT721 init sequence.
Without these, DMIC and headset microphone capture is muted by default.

This matches the behavior of rt712 and rt713 codecs which both enable
their capture switches in init.conf.

**Hardware tested:**
- ASUS ProArt PX13 HN7306EAC
- AMD ACP70 SoundWire
- RT721 codec
- Card components: `cfg-amp:2 mic:acp-dmic cfg-mics:1 hs:rt721`

**System:**
- Fedora 44
- Kernel 7.0.13-200.fc44.x86_64
- alsa-ucm 1.2.16.1-1.fc44

**Before:** Microphone records silence; `amixer` shows:
- `rt721 FU0F Capture Switch`: off,off
- `rt721 FU1E Capture Switch`: off,off,off,off

**After:** Microphone works; switches enabled by default.

Fixes: #805

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/806
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/806.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
