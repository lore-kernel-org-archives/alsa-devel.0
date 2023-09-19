Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370A6CD343E
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 06:18:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78A0BA4D;
	Tue, 19 Sep 2023 08:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78A0BA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695104296;
	bh=gen9Eg5/lOHEU47aBTDljNyUjwXWXrUGulZgBK1TLHI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T1e5OKGcO7p0B/QxYw9lSkWpeMPr20jw12KsY+dpj4NwGAMk7KDtnvXOR5ZuzBLuL
	 oSx8NbunJZtk6L6G6VJ3bf+0sSyoznQDtW62lR/G8o/YYtXtO1HhUvfMpA56jSNmDU
	 3TlGTCSIPaqKKI/suuMGoZ+w3hJDF/lU75JjqHeA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75A5BF80552; Tue, 19 Sep 2023 08:16:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 30B84F8025A;
	Tue, 19 Sep 2023 08:16:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2972AF8025A; Tue, 19 Sep 2023 08:15:47 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id D46F3F80125
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 08:15:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D46F3F80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695104140919287920-webhooks-bot@alsa-project.org>
References: <1695104140919287920-webhooks-bot@alsa-project.org>
Subject: Gapless support
Message-Id: <20230919061547.2972AF8025A@alsa1.perex.cz>
Date: Tue, 19 Sep 2023 08:15:47 +0200 (CEST)
Message-ID-Hash: WIDLDR4XZNTZ7EIEIDLBUFSUM3COZUZR
X-Message-ID-Hash: WIDLDR4XZNTZ7EIEIDLBUFSUM3COZUZR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WIDLDR4XZNTZ7EIEIDLBUFSUM3COZUZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #23 was opened from mohsRafi:

This branch will  add gapless playback support while switching audio track files.

For gapless playback use case where each track differs in encoding new codec parameters that need to be propagated to kernel is done via set codec parameters for next track API

Request URL   : https://github.com/alsa-project/tinycompress/pull/23
Patch URL     : https://github.com/alsa-project/tinycompress/pull/23.patch
Repository URL: https://github.com/alsa-project/tinycompress
