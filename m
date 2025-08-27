Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D52CA0EFF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:39:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3156560292;
	Wed, 27 Aug 2025 17:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3156560292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756309148;
	bh=aeVGeTGTKNmHxmfAffAgwnNvKvo0D2V9yDQ5uFY83/4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DsaSPXfwB/9cKl+MYaxHX4y2w7RVIXJHyUJLSEivKVNVYKn3p9dtUZXtfxrYnHGpH
	 X5764brsUJeTIYVRPxmCzNZzneYHNm3xqjoFxdbyO712ub7gsxEn865/2ekySz7sf9
	 PmOyolSYgrgUgtARTVPHGOblv5RrI3XYetfnB0JQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEF49F805D5; Wed, 27 Aug 2025 17:38:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C22F2F805CB;
	Wed, 27 Aug 2025 17:38:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85EF4F80495; Wed, 27 Aug 2025 17:38:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B8B9F800DF
	for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2025 17:38:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B8B9F800DF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185fa9cd986f6900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/606@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/606@alsa-project.org>
Subject: Add UCM for RME Fireface UCX
Date: Wed, 27 Aug 2025 17:38:04 +0200 (CEST)
Message-ID-Hash: TGT6MXJRMSL2YJ6ETSDMKBAKKJ6JOILB
X-Message-ID-Hash: TGT6MXJRMSL2YJ6ETSDMKBAKKJ6JOILB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TGT6MXJRMSL2YJ6ETSDMKBAKKJ6JOILB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #606 was opened from vascosantos:

Adds UCM for RME Fireface UCX (heavily based on RME Fireface UCX II config).
Device is assumed in CC mode.
#605

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/606
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/606.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
