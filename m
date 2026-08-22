Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BDCC5DF97
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Aug 2026 23:30:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 738766023B;
	Sun, 23 Aug 2026 01:29:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 738766023B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787441398;
	bh=a+CNgKRqBD5jjW0D8gE4b1fo8LWdGQcFgdAPnbx10FM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lr9BqbLH1gs4HFtiVfr+3yTrv3fHrOG0y9vFzBzOx9E6LvRJHFEuXY8k0gs+dWSsw
	 5nNatT6bRR0rGtjIHrTCdLTsh+fwmJcQ/nPKFfvk1KUwabCj28xG2UooXb83S3qV7Q
	 i5L1dTvvMFplWi9cV6QxL5aH7b2nQqLJdm7MAghQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E85B9F805FD; Sun, 23 Aug 2026 01:29:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27867F805F8;
	Sun, 23 Aug 2026 01:29:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37BC0F8055B; Sun, 23 Aug 2026 01:29:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787441353;
	b=bxra9mB2k1e7y68M5+KtmfkjZ84lq0CxPmnwI55a5bRIhKEOVoIgPzmnB1IpCrA0EEnC
	 Oafbd36p2l1vXl67VM7wGCX2RvBqoKdc3lnESFgLyKcWEEeR5PUX1d/hLcu5wneVl3Mk8
	 yVP/8ocVynYyWUasF6AvVisMMe08f4ohfAs9L32Jj27tAxpbY/1eDUEUGELBS7hptBPRy
	 dEGjExbNYa6FD0RAzTM8zLbMDMHiJRunxrHKLJ899R9Bx6nyzollHhoqtycPFDFvgNUQP
	 cleehDjIa8KgOhBEsk1Q9KgK23oBu4ug8ontWRPbDouJ7OvliLKSmY/oP+wH1UFt2/A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787441353;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=a+CNgKRqBD5jjW0D8gE4b1fo8LWdGQcFgdAPnbx10FM=;
	b=l/FR+dIM6KFj4zmDhTcM08+JxfLBaFZHWo8txDB1MyvwaGOUomueTeDogxrIPvoNIYLN
	 XO6eLmdPvBc9Wf1R3SWcP118Jn0AKJfmZJzT+lv3bRDMU4mxlpuWxrh2YqQJ54cbbbHOB
	 eCViSHRF7eeFW8Voary0RTZh8Z3VuJoKlS4Q9KqhL6t7dVLgIp2jAviYK4Vk9WCUjf05O
	 M6I9+89z2K8W2vIlAkuYMQU5tBVZHiTmm/g4dteOQBypPyv/63YGdf/V6bQPJmdGBdTKO
	 3+a7XmInhE5gl7NwhaYnRg5xNwMY0QU2o3VS8nFWg0jIRTQo3BlPo5glNWi4lADx/AQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 707A5F80075
	for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2026 01:29:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 707A5F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ce44706ab81900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/835@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/835@alsa-project.org>
Subject: USB-Audio: add Steinberg UR44C profile
Date: Sun, 23 Aug 2026 01:29:15 +0200 (CEST)
Message-ID-Hash: 7PK36DW7V6HQ7Z4OELP6HAKYNPKPZVHM
X-Message-ID-Hash: 7PK36DW7V6HQ7Z4OELP6HAKYNPKPZVHM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7PK36DW7V6HQ7Z4OELP6HAKYNPKPZVHM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #835 was opened from polyv0x:

## Summary

- stop matching the UR44C to the incompatible four-playback/six-capture
  UR44 profile
- add a dedicated six-playback/eight-capture UR44C UCM profile
- expose split HiFi PCMs for DAW Mix 1, DAW Mix 2, FX Bus, Direct Out
  1-6, and Streaming L/R

The channel layout comes from the device's USB descriptors:

| Direction | Channels |
| --- | --- |
| Playback | DAW Mix1 L/R, DAW Mix2 L/R, FX Bus L/R |
| Capture | DIRECT OUT 1-6, Streaming L/R |

This retains ACP's Pro Audio profile while also providing working HiFi and
Direct UCM profiles instead of only falling back to ACP.

## Testing

- `ucm-validator2`: `make configs` passes for the complete configuration tree
- `alsaucm -c hw:0 dump text` loads the profile against the connected UR44C
- WirePlumber 0.5.15 / PipeWire 1.6.8 exposes:
  - HiFi: 3 sinks and 10 sources
  - Direct: 1 six-channel sink and 1 eight-channel source
- activated HiFi and verified every split node was instantiated, then switched
  back to Pro Audio
- no UCM or channel-count errors in the WirePlumber log

[alsa-info for the tested UR44C](https://gist.github.com/polyv0x/8b95168b5705d141a9910d56a979be78)

Fixes #799

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/835
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/835.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
