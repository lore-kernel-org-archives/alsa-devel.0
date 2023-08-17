Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC472C27C7A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Aug 2023 11:15:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1EB4846;
	Thu, 17 Aug 2023 13:14:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1EB4846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692270931;
	bh=qS2I3UG0F4Q43sYPZZEBhKU6wJX2b3FDd65X9Xae4cU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WaDKLgkc2uKjf3MPRnlJnLPhNiNbvR7ojinW2VCb1bHwGP2aZpS72VrGQSN8lT80z
	 kbGA/p6/n7OKgm10et9P5y9PH5Ka7Ty6HO6I/Q0bGHEg/m7dvAor9770AHwxrzd6sW
	 O2hmhb2TM5hKG9WFyY5B21Q+kw5vU201YOdPkZ3o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F232AF800D1; Thu, 17 Aug 2023 13:14:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9227BF80254;
	Thu, 17 Aug 2023 13:14:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3BB7F8016D; Thu, 17 Aug 2023 13:14:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FC69F800D1
	for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2023 13:14:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FC69F800D1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692270848532021999-webhooks-bot@alsa-project.org>
References: <1692270848532021999-webhooks-bot@alsa-project.org>
Subject: Fix 'errno undeclared' compile error with older gcc versions
Message-Id: <20230817111410.C3BB7F8016D@alsa1.perex.cz>
Date: Thu, 17 Aug 2023 13:14:10 +0200 (CEST)
Message-ID-Hash: 7XR3J6UW5QOERIEU4TTCKFYCNQ76PNID
X-Message-ID-Hash: 7XR3J6UW5QOERIEU4TTCKFYCNQ76PNID
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7XR3J6UW5QOERIEU4TTCKFYCNQ76PNID/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-gobject pull request #83 was opened from michele-perrone:

It looks like errno.h has to be included explicitly when compiling with older
gcc versions. This issue was encountered on the following system:
- Ubuntu 20.04 LTS
- Linux 5.4.0-156
- gcc 10.5.0
- Meson 0.53.2

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/83
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/83.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
