Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3BBEC01A2
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:00:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7D88601F6;
	Mon, 23 Mar 2026 09:00:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7D88601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774252816;
	bh=/HAXoxe1IPWbMULXP9YmSKWpXCSS+vswmZVtmrzQzDY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kOXZf8kSJd2M1bKvMxv0djISD82FQaT84HN59LwQBRdYHUodWwp1IzaPfeH4Qz2QK
	 yC74A+IwyiL8iottMSeZttQ58feBrT+3QOE2fsIkqqVvU2gNKu64P6OhHVCD9msNsX
	 7Xxui013445+7lAfl/A+olUORGYCa0rXxG93h56s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B6A5F805ED; Mon, 23 Mar 2026 08:59:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A124DF805EC;
	Mon, 23 Mar 2026 08:59:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 134BFF80496; Mon, 23 Mar 2026 08:59:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DF9DF800C1
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 08:59:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DF9DF800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f697dafeb1c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/730@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/730@alsa-project.org>
Subject: ucm2: da7213: Fix mic capture in HeadphoneMic2 use case
Date: Mon, 23 Mar 2026 08:59:30 +0100 (CET)
Message-ID-Hash: QQODOEZNERHAATYJGVRHDUKYIA6OHXAH
X-Message-ID-Hash: QQODOEZNERHAATYJGVRHDUKYIA6OHXAH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QQODOEZNERHAATYJGVRHDUKYIA6OHXAH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #730 was opened from QTI-Quill:

Set Mic 2 Volume to index 4 (+18 dB) and Mixin PGA Volume to index 10 (+10.5 dB) for sufficient microphone capture gain.

Remove headphone output controls (Headphone Volume, Headphone Switch, Mixout DAC switches) as these belong to HeadphoneEnableSeq.conf and should not be duplicated in the capture sequence.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/730
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/730.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
