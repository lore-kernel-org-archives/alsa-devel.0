Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22006CA0EED
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Aug 2025 03:57:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 833F660293;
	Thu, 28 Aug 2025 05:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 833F660293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756353464;
	bh=0cZTM0txWtUaNjKBZ0UletxuWCLQgV8L6WEIjKz+YMo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JkRAGWWbBSApqa2aDmR3ovFkVfQquMdWlMMcGQ71bQka2oiVK+GP61bdsSMmyRhhQ
	 OZgTlFAwbxmfuSVoMUFE15w/krcQzgZQmv7tcnQXlCNm+srvFD1/252jOgBlo4jXjH
	 qdc09t134wBktv0og/kQl3164r3w0wCJsFIVKr3g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C633F805C8; Thu, 28 Aug 2025 05:57:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BF78F805D4;
	Thu, 28 Aug 2025 05:57:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B537F8028B; Thu, 28 Aug 2025 05:56:54 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 83153F80072
	for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2025 05:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83153F80072
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185fd21f68c6a700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/607@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/607@alsa-project.org>
Subject: ucm2: MediaTek: mt8391-evk: Add alsa-ucm support
Date: Thu, 28 Aug 2025 05:56:54 +0200 (CEST)
Message-ID-Hash: 4YUN2SHKOWMYU65CNOOZI745O2254EJ3
X-Message-ID-Hash: 4YUN2SHKOWMYU65CNOOZI745O2254EJ3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4YUN2SHKOWMYU65CNOOZI745O2254EJ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #607 was opened from zoran055:

Add alsa-ucm support for the MediaTek mt8391-evk platform.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/607
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/607.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
