Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3CFC36010
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:28:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BEF2601E2;
	Thu, 27 Mar 2025 17:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BEF2601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743092911;
	bh=NjhK0m86sjKt/LJmMOvmmLpGIUYeb1sWKesNT0ulw/Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TmCwHr2tIwh8w6K7eMqJRZn6f1vECC2xWpk4EICQEu8765NCo3Mqtg2kso3UHdASr
	 7CrjuTiYAfe5VNDZLAJwuusJCONsH5qT0+8FigreVTobf+/N+thTFtp3JUyA5hmVep
	 zqtmWgJj5icmvN7eLopCFqT5x8FX29SUm3zYthjg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D181FF805C4; Thu, 27 Mar 2025 17:27:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 856F4F805C2;
	Thu, 27 Mar 2025 17:27:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 753FAF80533; Thu, 27 Mar 2025 17:26:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D477F800D0
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2025 17:26:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D477F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1830b5a4f159cd00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/536@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/536@alsa-project.org>
Subject: USB-Audio Add Roland BridgeCast One USB-Audio.conf
Date: Thu, 27 Mar 2025 17:26:23 +0100 (CET)
Message-ID-Hash: 55UD5JEL3NEHWPPQJRSF7VOM2IQ2TXOR
X-Message-ID-Hash: 55UD5JEL3NEHWPPQJRSF7VOM2IQ2TXOR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/55UD5JEL3NEHWPPQJRSF7VOM2IQ2TXOR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #536 was opened from Simon99de:

Add Roland BridgeCast One
uses the same config as the bridge cast v2 as it has the same outputs and it worked in my test.

0582:030d

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/536
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/536.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
