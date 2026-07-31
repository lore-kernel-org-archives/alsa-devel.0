Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A297C55165
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:23:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5135C601F7;
	Fri, 31 Jul 2026 02:23:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5135C601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785457425;
	bh=bu2zBhPxILvD53kvTZZpkTf97zOVYpm4Pmkj2SZXyCs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=iekJwoxkoF/B9PXnWxy0TtlUmJuOX1CjEJJeLcGQpX8pMYRen58VQYLOiwXKQFKi3
	 yDisvlWPy+1Z9cEXHf589MzQwaxKykuZ2I4PFlDJckTSjkEBb8aBaCEjsJ1kZoIsQF
	 HEVofPQi72LEtkqCp8smTPjCduTtglmI2vCuLwHY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11370F805FC; Fri, 31 Jul 2026 02:23:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9970FF805F9;
	Fri, 31 Jul 2026 02:23:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29F4AF8051F; Fri, 31 Jul 2026 02:23:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785457383;
	b=RyLPKbJLwhh/yKhPHDNrdXAuDwKiaa0jMmYE/GudRjmhYnM4xvh9ZldpVV3lQkO8xS1E
	 4UEcjk0nt+pjeUuCtZhaDM9/Iw6j/KxB8ksS7B8L/MF55IETm9fjwR+eXpcSfrRtFKeFb
	 SBbPDSWNvdHNWEZPKHWniKR2HrS9IIK/gM04/SMXw9SBRV+lVdz8frZ5A/xwd67NYAEfY
	 l1uuEZXMX8ik8wdgxYqNVUYWfy/m+9eiQj4+Q/CSHqZHrU/Q6h/YNsWJ3ewlbxoanWeS5
	 gtdtYuxfS6j4K7n0400+YPvK6vOzYeOvLvKnyfZpiNTz0K+K5TprvIKdDFMVRQLTOlw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785457383;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=bu2zBhPxILvD53kvTZZpkTf97zOVYpm4Pmkj2SZXyCs=;
	b=ac++fqEHOEFdCjHkbTdk9T4D9ImG5mlaB5I+ABdoVxixtKTQK1PidiYdrVGH6P8Ej8CZ
	 KTMLpJxxwl7bBRPr+slYKgJsSYddi5xcDoiqyBk7e9sWPf58Q9AYyU2QJkuEfQjHL7Lwr
	 G4zSM74HDLbw9ERsQojlA4HYvd1FGCt5Ue40ienP7S4j4Cfq8EAX5UOyHcAXH4aa0Wa8f
	 E+bn18zuMy4PTf+v0rs9AHpeger3DJI2+FDPIiVCZLFgrc0AXTl4pObD/LXHZSMmpT1X/
	 aSAXo5571Do6f1Di8dyCq6CAHZtLtBdiPc0kg9UFUgeGjJaCEAqvy2KmRxTFP/v4AAw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5ADFAF8014C
	for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2026 02:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5ADFAF8014C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c7380776d13e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/822@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/822@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: T14s: add Microphone Mute LED
Date: Fri, 31 Jul 2026 02:23:04 +0200 (CEST)
Message-ID-Hash: 2KMR42SYAFBHO376GZG75SN4FBKDUTHI
X-Message-ID-Hash: 2KMR42SYAFBHO376GZG75SN4FBKDUTHI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2KMR42SYAFBHO376GZG75SN4FBKDUTHI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #822 was opened from sre:

Add support for the Microphone Mute LED in the Keyboard's MicMute Key, which is exposed by the lenovo-thinkpad-t14s EC driver that landed in the 6.18 kernel and uses the "audio-micmute" trigger by default. This works by creating a virtual capture switch and binding the LED to it.

Something similar should be done for the speaker mute LED, but I'm not sure how that is supposed to look like. The Speaker Mute LED automatically toggles when the Speaker Mute Key is pressed, so it seems to work without explicit handling. But it can get out-of-sync, if the mute status is modified in software without using the key.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/822
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/822.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
