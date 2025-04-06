Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC7EC36002
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Apr 2025 14:07:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C48D61FE0;
	Sun,  6 Apr 2025 16:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C48D61FE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743948437;
	bh=uE+lZZzEaoATyyLd/vZ/fxLTYg+yUfpFN2TLXmKDO5Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oOE+Dh0ESOibkNwRFjVwTJ/ed6ZgYcqRnBzGB3tZMFlRBn1vpHE9gS/cmmTvxv3bq
	 PM+mc4u4tZ2CTlzEuTvshUVFucqXMAW4d0d5MVYQz7+JXbWvDrmPIdnsTOOWz3ccjb
	 M5kclSoHdqfMgrjhA/y+puH5y2XLkGQfNZukaRbk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FA0FF805BF; Sun,  6 Apr 2025 16:06:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC4C6F805C1;
	Sun,  6 Apr 2025 16:06:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBCF5F80116; Sun,  6 Apr 2025 16:06:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E31DF80073
	for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2025 16:06:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E31DF80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1833bfd032a5f600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-python/pr/17@alsa-project.org>
References: <alsa-project/alsa-python/pr/17@alsa-project.org>
Subject: alsaseq: Fix type check in set_time()
Date: Sun,  6 Apr 2025 16:06:23 +0200 (CEST)
Message-ID-Hash: PT7L3TDQPHCGPB27QOYEBFGCB4LO6OA5
X-Message-ID-Hash: PT7L3TDQPHCGPB27QOYEBFGCB4LO6OA5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PT7L3TDQPHCGPB27QOYEBFGCB4LO6OA5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-python pull request #17 was opened from ernestask:

SeqEvent_set_time() has fallen victim to the inverted get_long1() return value here, erroring out when called with actual integers.

Request URL   : https://github.com/alsa-project/alsa-python/pull/17
Patch URL     : https://github.com/alsa-project/alsa-python/pull/17.patch
Repository URL: https://github.com/alsa-project/alsa-python
