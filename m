Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB0EEC01CC
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:13:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21D3C601F3;
	Mon, 23 Mar 2026 12:13:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21D3C601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774264395;
	bh=rOBxBxKCyaDJfo4Xrya91f8Mg/Vdj9lE58l2W4TJyZ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mH8oCL71P4LacLHSKG1mkXUF1W1SkNe3BfZwrr88u/p9SnlqeTy7gntfgmDpMN+Xv
	 IGg0rc90MUHfwt2UB+HQylTjMxyXw9ZciLiF2f8SQIq6OTuE1/csy9uo9drJTWOBi2
	 s5aXbCsywtw3oa/SgHyA6k8mpPAHvIHu6gYU9PQY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F51EF805EF; Mon, 23 Mar 2026 12:12:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA307F805E9;
	Mon, 23 Mar 2026 12:12:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B073CF80496; Mon, 23 Mar 2026 12:12:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A304F800FE
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 12:12:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A304F800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f7405e5e2b200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/731@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/731@alsa-project.org>
Subject: USB-Audio: Scarlett 18i20 fix ADAT capture channel count for Gen 1/2
Date: Mon, 23 Mar 2026 12:12:29 +0100 (CET)
Message-ID-Hash: X6JPH5BNUDS6WGQLXR7OVAQKG3KJKT32
X-Message-ID-Hash: X6JPH5BNUDS6WGQLXR7OVAQKG3KJKT32
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X6JPH5BNUDS6WGQLXR7OVAQKG3KJKT32/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #731 was opened from codeurge:

The Scarlett 18i20 Gen 1 (0x800c) and Gen 2 (0x8201) have 18 capture
channels, but the ADAT Optical Input device ("Direct 2") unconditionally
maps 8 channels (indices 12-19). Channel indices 18 and 19 exceed the
available capture channels, causing WirePlumber/PipeWire to reject the
UCM profile with:

```
spa.alsa: Error in ALSA UCM profile for _ucm0003.hw:USB,0 (Direct2):
  CaptureChannel6=18 >= CaptureChannels=18
spa.alsa: Error in ALSA UCM profile for _ucm0003.hw:USB,0 (Direct2):
  CaptureChannel7=19 >= CaptureChannels=18
spa.alsa: Errors in ALSA UCM profile for card Scarlett 18i20 USB
```

This conditionally sizes the ADAT capture device based on
`DirectCaptureChannels` (already set per generation in the main conf):

- Gen 1/2 (18 channels): 6-channel ADAT capture (indices 12-17)
- Gen 3+ (20+ channels): 8-channel ADAT capture (indices 12-19)

Uses the same `If` conditional pattern as `Scarlett-2i-HiFi.conf`.

Tested on a Scarlett 18i20 Gen 2 (USB1235:8201) with PipeWire 1.4 and
WirePlumber on CachyOS (kernel 6.19.9). UCM profile loads cleanly with
no errors after the fix.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/731
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/731.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
