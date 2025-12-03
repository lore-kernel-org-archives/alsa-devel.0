Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F88D12688
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Dec 2025 00:03:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4808A60212;
	Wed,  3 Dec 2025 01:03:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4808A60212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764720213;
	bh=Ql0k73fy4bPuIpRRU70gAWPoNNKp9sEF5fJ/OQOK740=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ctOjVjNkbgJMDvshk0qI/ZMzAWbJ5Zc/Y3i+LuKRFyFgyTS44Xg4iKqK6JYiBXaBy
	 /oi/p0B/qCcQPWNOPHND5tB/h6hw/dwO4LyX7hJmkbTajh3/89rZO/CFpkDVOG7DDg
	 dQBGAuvCji04lLHdBvsZFccoTIFHb5GajPIdGHnA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DEB49F805BA; Wed,  3 Dec 2025 01:02:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC4A9F805D6;
	Wed,  3 Dec 2025 01:02:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A007F8051D; Wed,  3 Dec 2025 01:02:47 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A873F80269
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2025 01:02:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A873F80269
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187d8ba3e6164b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/651@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/651@alsa-project.org>
Subject: Add Audient iD14 MK2 support
Date: Wed,  3 Dec 2025 01:02:47 +0100 (CET)
Message-ID-Hash: NOZ6K5WDCPAD7PNNEJSYZ67FDAIU4K3A
X-Message-ID-Hash: NOZ6K5WDCPAD7PNNEJSYZ67FDAIU4K3A
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NOZ6K5WDCPAD7PNNEJSYZ67FDAIU4K3A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #651 was opened from VolanDeVovan:

Add UCM2 configuration for the Audient iD14 MK2 USB audio interface.

  Device: Audient iD14 MK2
  USB ID: 2708:0008

  This is a minimal configuration exposing only the main analog I/O:
  - Microphone/line inputs (2 mono channels)
  - Headphone and monitor outputs

  Full 12-channel capture (ADAT, S/PDIF, loopback) is not exposed.

  Playback devices:
  - Headphones (priority 200)
  - Line1/Monitor 1-2 (priority 100)

  Capture devices:
  - Mic1/Input 1 (priority 200)
  - Mic2/Input 2 (priority 100)

  Tested on NixOS with PipeWire.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/651
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/651.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
