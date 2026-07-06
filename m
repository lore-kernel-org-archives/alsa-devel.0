Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED28C43458
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:55:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0751360220;
	Mon,  6 Jul 2026 18:54:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0751360220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783356909;
	bh=EXeKHJc5wUvsGwl4iuvAeZ5ITfmziI8IqzpSyGObaGU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ABHcaNu66eL18TbKBiSn9H+BQRLWOkPcnfqwVf7RC1thla0o4DS8jh0LoD5f1IbYG
	 iqkMeycoQXXwCWRljKQgQAQQJC57H8qlkI22trCtwF4pVPi1Gw6BxlMEyJhjoJmlEp
	 jTONWOsbnKoGUboBU78gRahxOBO0Bi7qT2th9QNU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFC9EF805FB; Mon,  6 Jul 2026 18:54:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6B82F805F6;
	Mon,  6 Jul 2026 18:54:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBF88F80524; Mon,  6 Jul 2026 18:54:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783356870;
	b=pmdXi+mLiBvC0E+qO3AODZ99YJFqC3gGfSwdyQDVpRMP2NQ1mmfQLbcGzG8Skxu3IZb/
	 L3qTWukiaB8dd4yS+jbdyCjj4k2pE+caiRGXjcPuu6lEgiKb8pPsN9902zPvIh4dyb7E5
	 SFxNvCca6jpBtKRPiM4nA8qPPVtKEInr9jcepbgEK65PWA92CjcJ2l53h+at0p/RqmS0X
	 tJdy4Myn1mOfF2YPz7uqxzBhuGy7Y0dHGt6aZc/TH0GSevuZCYcAm8nZg8Vqa40EoxibE
	 fAAe+U18FUb03qNhD6dzfQAXW64qRb7Q3QAsSDkR/06rBasHa76ZUs5MUZ+YGLKmgBg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783356870;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=EXeKHJc5wUvsGwl4iuvAeZ5ITfmziI8IqzpSyGObaGU=;
	b=LPA9clvzPq1a4lZD34e4DvTGI5KiBV2tyA26z+85Q2TzATWz71IrOLbi6C5lIPcaSSLc
	 lUEPsVtuH7Vr1cFQGW14P/iPrjtKYbob/H9OWmhK4KZKx+s2t3guaQw3EylQuYxY7Hk8J
	 jeFlIp4N5dkN7604heV/FQpLL3tCDAulZ0GJdynfuxooUDQKDgbSanXemsCqWLq20z0Bj
	 y6HH9U9YZzDhidfUtCxIfn4J3Tv1hUsyruAxEIHC6EONumRRTtghVey5oMT9B6SzNb5uF
	 HvlH7fRRFBubFgrGCsPQqPsquSZuypmS09M0MOkqESCI47v7XkVFp9DVDeqX9fpaSHw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 35A7EF801F7
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 18:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35A7EF801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfc19f97971100-webhooks-bot@alsa-project.org>
In-Reply-To: <18bfc19f978b7a00-webhooks-bot@alsa-project.org>
References: <18bfc19f978b7a00-webhooks-bot@alsa-project.org>
Subject: Realtek ALC245: Built-in speakers cannot be selected while headset is
 plugged in
Date: Mon,  6 Jul 2026 18:54:30 +0200 (CEST)
Message-ID-Hash: BIJRWQKA6T3CPDMWZF2EU4CXEU7UF6OY
X-Message-ID-Hash: BIJRWQKA6T3CPDMWZF2EU4CXEU7UF6OY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BIJRWQKA6T3CPDMWZF2EU4CXEU7UF6OY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #807 was opened from SSolarite:

## Hardware & System
* Machine: VICTUS BY HP 16.1 INCH GAMING LAPTOP PC 16-E0000 (2V8Z8AV)
* Audio Chip: Realtek ALC245
* Distro: Arch Linux
* Sound Server: PipeWire/WirePlumber

### Description
The UCM2 configuration does not expose an option to change to the built-in laptop speakers while a headset is plugged in, specifically, it splits both Speakers and Headphones into two profiles:
<img width="404" height="148" alt="Image" src="https://github.com/user-attachments/assets/e23fafc1-dccb-4c2c-af02-d3ea3c2923df" />

It only shows up once the headset is unplugged:

Headset in:
<img width="454" height="444" alt="Image" src="https://github.com/user-attachments/assets/fe636fe5-6e35-4bb1-bca0-97dc58f9714e" />

No headset:
<img width="460" height="450" alt="Image" src="https://github.com/user-attachments/assets/da2b7b6f-c145-465a-a1d1-699e02359d2f" />

I have also tried the Pro Audio profile. It shows these two, but none of them work. Record test
<img width="453" height="444" alt="Image" src="https://github.com/user-attachments/assets/5061600b-39a2-4149-8815-101bc21cd141" />

 `sound-test` plays through both the headset and speakers. The speakers can be toggled using `amixer -c2 sset Speaker [on/off]`

### Expected Behavior
Both the built-in speakers and headset should be selectable options without flip-flopping.

### alsa-info.txt
[alsa-info.txt](https://github.com/user-attachments/files/29711854/alsa-info.txt)

If this happens to be a configuration issue on my end, please give me steps to fix it.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/807
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
