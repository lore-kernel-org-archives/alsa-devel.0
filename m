Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB215EF3717
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:58:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D69E360280;
	Mon,  9 Mar 2026 12:57:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D69E360280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773057488;
	bh=KTN9zqsPBZXmLFVvSEJKqCxK4eB5dr8m1pPbm/GE6Ys=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aClyhVNfFNC+nxka5fip7b9h9Di9Zw/rN5RJpMdmXo8H1oAW5wuvYOjCH7boDQxDf
	 aM7ew8m+kQsplRFQwO809OJQlKE+GjibyprSw4wUvOvtX0nM8T5Tl8yNwG+3L55h8Y
	 hb4wgu4nQBIHedCdpEhfgw5ZbmgVgcUvlDUatupI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6368F805F3; Mon,  9 Mar 2026 12:57:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCBF0F805F3;
	Mon,  9 Mar 2026 12:57:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E58E7F80571; Mon,  9 Mar 2026 12:57:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A0605F80071
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2026 12:57:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0605F80071
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189b2a59ae270000-webhooks-bot@alsa-project.org>
In-Reply-To: <189b2a59ae008400-webhooks-bot@alsa-project.org>
References: <189b2a59ae008400-webhooks-bot@alsa-project.org>
Subject: Add UCM2 profile for Lenovo Legion Pro 7 16IAX10H (ALC287,
 Subsystem ID 0x17aa3907)
Date: Mon,  9 Mar 2026 12:57:25 +0100 (CET)
Message-ID-Hash: YZMQMBALXQYBDNYQP2OZ7GCKGEKHJQIB
X-Message-ID-Hash: YZMQMBALXQYBDNYQP2OZ7GCKGEKHJQIB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YZMQMBALXQYBDNYQP2OZ7GCKGEKHJQIB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #717 was opened from someoneKeith:

Hardware
- Machine: Lenovo Legion Pro 7 16IAX10H
- CPU: Intel Core Ultra 9 275HX (Meteor Lake)
- Kernel: 6.17.0-14-generic
- OS: Ubuntu 24.04

Audio codec
- Codec: Realtek ALC287
- Vendor ID: 0x10ec0287
- Subsystem ID: 0x17aa3907
- Card ID: PCH

Problem
Internal microphone not detected at all.
No UCM2 profile exists for this subsystem ID.
`pactl list sources short` shows no internal microphone source.
Only USB audio and monitor sources are listed.

Pins detected (via hdajackretask)
- Pin 0x12: Internal Mic
- Pin 0x14: Internal Speaker
- Pin 0x17: Internal Speaker  
- Pin 0x19: Black Mic, Left side (jack)
- Pin 0x21: Black Headphone, Left side

Request
Please add a UCM2 profile for Subsystem ID 0x17aa3907
to enable the internal microphone on this Lenovo Legion model.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/717
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
