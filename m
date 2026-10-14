Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086E2CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:06:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57CD1601DC;
	Wed, 14 Oct 2026 19:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57CD1601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791997559;
	bh=wwbrmSiRSs87Lu8Tn7aKv/DGNLC2rb9J+hxTkuuJ/UI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=o/cHBQKECPJRo7Mh766F4Zwk2XJwrvbVGx/fbGK9pVQ+3HwJvYvfX8ItIpSBcZPYN
	 qtkmzi22wCImKsG7lY4e63SXVgG+ylF89sV2tRfG1SFfjfSCaxhs0QZhyAW44PlrzP
	 +5TgQbb1Ai9p7TGGREE0wunNmNxUEp6BduxFNoKI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F216F805F2; Wed, 14 Oct 2026 19:05:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59B3AF80601;
	Wed, 14 Oct 2026 19:05:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E46DCF80448; Wed, 14 Oct 2026 19:05:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791997520;
	b=IPKhXgxyEnWEMsz1SOv3YkhDwvSw6fd9aWl6Zuv/LkD+m4Fwn7L9BhRYH5d+QrWxwd3p
	 q8A+p2qWGopikrAA9ncPq43TfJhhxB5BxOjMVCqXLEbem9x8ofgv/OuBuFxxWu8o+Aeu7
	 0R1bEAPgmBzrwk/CU6Jh/erE5kxURpT8722eYVhuRmxJgkXqY+V6e53o3cF0pQuOujzhO
	 f2FSOVWPm3XpgtxA6+e5a2QI4ciMZex8fXOQ2xZn918+nuxwu3xuQcn2vSiFiQ2QK+1RK
	 SugltzQTFDql7QkFLBU/TsMUZk1e4VARzPCL7PvC5F3uk63BEv4bLxF0IDrWkFufwbQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791997520;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=wwbrmSiRSs87Lu8Tn7aKv/DGNLC2rb9J+hxTkuuJ/UI=;
	b=e2wi+qZub2muLHzYt8co9CG4dbZFIt2fdwbljlcR2zB3f147qh+bFhkAd0+9UUgRdlG/
	 sXX0LR9/bRmX25wa5FZy8DDgl8Y5Jx40a5Ef8TSZoCpG35pNSt1Ls1B7pLlcpIYRHNvx/
	 bGd5B4EC56SwI8M0FA+sTrVS3E3YYNad+DWLE5qjuS0XYvbIiYJaCM/raeq8eM8MGd5ZX
	 XYFUnnVVF4d5JlfKK/bYNPDapCcFvqbZeU8X46+5l+6JTZi9yGLloweFuKO7QK3fOCUCL
	 UMBuP63iYBek2WPgD0mFGUtoEU7m9B8FZfAYfgJ+d6i+JfWLPqoJnnARp2RfGIGfuDQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 14C40F800E4
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2026 19:05:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14C40F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de743fab29af00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/880@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/880@alsa-project.org>
Subject: ucm2: Qualcomm: Thinkpad T14s speaker mute LED support
Date: Wed, 14 Oct 2026 19:05:20 +0200 (CEST)
Message-ID-Hash: K46HSBTRT6YUUDO7FOQXEC4JWKPDLVCR
X-Message-ID-Hash: K46HSBTRT6YUUDO7FOQXEC4JWKPDLVCR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K46HSBTRT6YUUDO7FOQXEC4JWKPDLVCR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #880 was edited from sre:

The T14s Gen6 Snapdragon has an LED in the mute button to signal that the speaker is muted. The kernel driver for the embedded controller exposes it as `/sys/class/leds/platform::mute` with trigger set to `audio-mute`. At the same time the hardware toggles the LED state when the mute key is pressed (independent of the real audio state) giving a fake suggestion of things working correctly.

This series properly attaches the speaker mute state to this LED. To be functional, it depends on a kernel driver change for the speaker amplifier exposing a mute control knob. All handling has been implemented in a way, that using a kernel without this feature will continue to work as before.

Kernel Patch: https://lore.kernel.org/linux-sound/20261014-wsa884x-mute-support-v1-1-74d98d79e635@collabora.com/

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/880
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/880.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
