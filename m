Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA474C4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Oct 2023 19:19:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01CD4A4C;
	Sun, 29 Oct 2023 20:18:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01CD4A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698607160;
	bh=7I5OLuIkNXDkPFVH/uJQgPPb60UnXDLe9H59o8ZoUwk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BKSxfUk9z1CfkTUU9V+YirwKjZzK2ouf3zxVhEm/lZfLwJajdoihO0CQevs90wdBo
	 otcsWUgwdNq05bxGc88ZI5jJsbQRZB95siyEm5GgtazbW2DwuVFlH6me6TFw/akJ3O
	 GC+sszD1p5mhHzoEvOFPVnRntkSe2/mPwNJAaZ14=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 875B7F80166; Sun, 29 Oct 2023 20:18:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BA1DF8020D;
	Sun, 29 Oct 2023 20:18:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C44C9F8020D; Sun, 29 Oct 2023 20:15:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FAB9F80166
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2023 20:15:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FAB9F80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698606951015890837-webhooks-bot@alsa-project.org>
References: <1698606951015890837-webhooks-bot@alsa-project.org>
Subject: SPDIF output of ASRock X670E with ALC4080 didnt work
Message-Id: <20231029191556.C44C9F8020D@alsa1.perex.cz>
Date: Sun, 29 Oct 2023 20:15:56 +0100 (CET)
Message-ID-Hash: HHLCFV3GMANDLBLQOY77I6V3QOGJBNDZ
X-Message-ID-Hash: HHLCFV3GMANDLBLQOY77I6V3QOGJBNDZ
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HHLCFV3GMANDLBLQOY77I6V3QOGJBNDZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #364 was opened from jonasdutra:

http://alsa-project.org/db/?f=43bba1198f548f906c597d1f2e15ff5f6df58a60

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/364
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
