Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF39E9E2F8
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:02:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8933960217;
	Wed, 11 Feb 2026 13:02:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8933960217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770811354;
	bh=kbLCRSLMtiQPxJIHlyLlnhrdA6kF5eN5WoLmnZQEPD4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=I6fnc5hfNxEUz43NFf//l3s8Vwnu81Hc2YtkVAjZW3WzIttntmVLsv/1ekwWg+P+Z
	 agy6Dck528UjezOtP9AW3QXUuFfFGwyqsPHyPHvIzOzxFY4NUJye4R6XzvRmvzF9wT
	 NBHQ/jmT+ytkX/UQ6/Vp9cE8WnTzkjK5FkQVIBeU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2DBDF805F2; Wed, 11 Feb 2026 13:02:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E6029F805F6;
	Wed, 11 Feb 2026 13:02:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68850F8049C; Wed, 11 Feb 2026 12:59:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B65ACF800BD
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2026 12:59:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B65ACF800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18932f6348ca5c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/665@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/665@alsa-project.org>
Subject: ucm2: sof-soundwire: Add support for CS42L43B variant
Date: Wed, 11 Feb 2026 12:59:51 +0100 (CET)
Message-ID-Hash: YVQHCMPWNBR4XD7EVNREJLPCR44J5AKG
X-Message-ID-Hash: YVQHCMPWNBR4XD7EVNREJLPCR44J5AKG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YVQHCMPWNBR4XD7EVNREJLPCR44J5AKG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #665 was reopened from mstrozek:

>From UCM point of view CS42L43B codec adds 2 new decimators and removes a control to change Decimator 1 mode from base CS42L43. Thus reuse CS42L43 files, and guard the CS42L43B additions behind a condition that the new Decimator controls exist.

Link: https://lore.kernel.org/all/20251219100235.1247053-1-mstrozek@opensource.cirrus.com/

Set as Draft PR until kernel support is merged.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/665
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/665.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
