Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324B0D2502F
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Jan 2026 14:58:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C3BA601A6;
	Sun, 11 Jan 2026 15:58:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C3BA601A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1768143497;
	bh=4YsA7/ZoUCBdz4f64AIXIi5R6vVYZu6hz4am1YIC7ro=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LjqpfP/oAqvls9dXD1o3fIu6n8Gnp0Pt0okQ5F465jsGPdq0R+jhDuyD7TUtlWGYN
	 Jv2KPFMCJ9aOqy3ThPC5gqOBC0+dPuedj0PIt4Zf67HGbJFe2fgHVfdpJBVKmDP948
	 od4eO8X4vGBhri//okrgleHVufrE+1eJVxam3Eag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4ED8F805E9; Sun, 11 Jan 2026 15:57:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CDD3F805D8;
	Sun, 11 Jan 2026 15:57:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A0B6F80149; Sun, 11 Jan 2026 15:55:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7974EF80038
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2026 15:55:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7974EF80038
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1889b4f8ce467c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/684@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/684@alsa-project.org>
Subject: USB-Audio: Add support for UR24C firmware version channel
 differences, fix UR22C
Date: Sun, 11 Jan 2026 15:55:23 +0100 (CET)
Message-ID-Hash: DJDBKVMGHEZFPP4CNKXF2KBSQESWENWI
X-Message-ID-Hash: DJDBKVMGHEZFPP4CNKXF2KBSQESWENWI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DJDBKVMGHEZFPP4CNKXF2KBSQESWENWI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #684 was opened from jwlademann:

Steinberg UR24C has a similar change to the number of capture channels fot version 3 firmware. During implementation I found an issue with the condition used for UR22C which I fixed also.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/684
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/684.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
