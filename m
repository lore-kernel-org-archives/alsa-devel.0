Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DF6C43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:34:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E93560216;
	Mon,  6 Jul 2026 15:33:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E93560216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783344843;
	bh=x9d9y30jl3b83NlggadSQ1UBT4YBs7TlLqsGrU11Dfc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KTZQs8Ah9i9gwYIzHLRVvmbbapAR05ME5K/kGKwhx+gS/38ZncZxvAG++n28mKnA0
	 Pf1UaNPNQITq3hQ17gXhxsMEUXzY4BTP95LAVKYpDFvZTSVgtddrbAihYCiboUP1XL
	 Ol2INYfdKG3hDPL6N6E3lZYORXzhfdIAXFSrI5VA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B476FF80600; Mon,  6 Jul 2026 15:33:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29F6FF80601;
	Mon,  6 Jul 2026 15:33:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C533EF80524; Mon,  6 Jul 2026 15:33:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783344798;
	b=SrXZEGAOHAQSQVWW7830fJmvHhDltifktqjgZxA/j1cbIn1lHVdE+haKDwjYXsgvRDNe
	 qDvE5tVmAMBqRddWkbiTT65frt0Wwf7JqOEhX9/qEItVGqEbqqywXhJmxfIYpXjUXUTK4
	 Zq0QEJXZL9pgBGZskohsCbgq81rg/Y7udN7ZADnHtMS0E5QumSuve5NllD2gcHo/rWcxd
	 /Dxl2glXQh++LIV8EAp0dSYfC5jSLWRsz7r+zd7mY2JA4wyOoWR/UxZj4ec8j4UDvWuvf
	 SiOwKGgM49dTSGUKiLtuTrHL9fIYOkyte+6M2BdLqNgLuNQQrtO0X42pvQXi9jTKzYw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783344798;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=x9d9y30jl3b83NlggadSQ1UBT4YBs7TlLqsGrU11Dfc=;
	b=jJqFiiQE8IkjFkzTc7iWLhJZX/+bnHukvpo4oqyCHCla8HavC/9pXujkhvKJ0SwzkX/D
	 jfbzpiPloCMyAl4ZIcZ2ISBzXybqKk1ksS4JIa8OKPZN1QC6/Orb9WzAtps1ET8+6I98A
	 9bv2DaVglWZGfuf0DZRslgdCKRarT1abP0695MQOtgQzrTtFQ3kvU3GNLNzgo3uQDosSF
	 qW5TBfSs/sEeYlABFQVLZCp9piJE1WBALo///9NRU/E3VtFz6KSIz7P0gRMrKZ8wAQ6aD
	 P3JugkHghYNy/x5aZ6YJ673SfQwd1+u7jQNvQE+Ay6Knf6QXFGHwjytSZ6riKLQ1QrQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 05392F801F7
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 15:33:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05392F801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfb6a4d2686f00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bfb6a4d2407600-webhooks-bot@alsa-project.org>
References: <18bfb6a4d2407600-webhooks-bot@alsa-project.org>
Subject: rt721: capture switches (FU0F/FU1E) default to OFF on AMD SoundWire
Date: Mon,  6 Jul 2026 15:33:18 +0200 (CEST)
Message-ID-Hash: MWTKQSRYE37D7JDVW7P43JWM37CZXVKT
X-Message-ID-Hash: MWTKQSRYE37D7JDVW7P43JWM37CZXVKT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MWTKQSRYE37D7JDVW7P43JWM37CZXVKT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #805 was opened from BenSharir:

The RT721 codec capture switches for ASUS ProArt PX13 (AMD SoundWire) default to OFF, which mutes the DMIC microphone.

**Symptom**: Microphone records silence despite being selected in the system settings.

**Cause**: The following ALSA mixer controls are off by default:
- 
- 

**Proposed Fix**: The UCM profile should enable these switches by default in the HiFi verb.

**Hardware**: 
- Laptop: ASUS ProArt PX13
- Chipset: AMD ACP70 SoundWire
- Codec: Realtek RT721

**Workaround**:

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/805
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
