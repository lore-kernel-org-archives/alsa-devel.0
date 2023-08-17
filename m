Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D5BC05052
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Aug 2023 01:29:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 868F282A;
	Thu, 17 Aug 2023 03:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 868F282A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692235750;
	bh=Wvl+GCOGrYnRQ0GAUIB5omPwHzLwMm3lV3eMCpsUiOI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oiOIdAC2DoF60hoBTjnKou/tpBi8wdz1A25tM3qZ3dEdYEzGtq45/MLHQP3YS2lMJ
	 4ehs6xPj7lWnZ6gd8ZCDRJqfVlIZGgvTuckmUlQP+ZAaa4h//H5A0rB7QahQnJ9tvk
	 C5C8Uccc6CF5OFfRpOwJpUiiXhXWW26J0C9TYfXM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 61D13F8016A; Thu, 17 Aug 2023 03:27:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23E2DF80272;
	Thu, 17 Aug 2023 03:27:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEBEAF8016D; Thu, 17 Aug 2023 03:27:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 32619F80027
	for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2023 03:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32619F80027
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692235650588474035-webhooks-bot@alsa-project.org>
References: <1692235650588474035-webhooks-bot@alsa-project.org>
Subject: SplitPCM: Fix Device variable in SplitPCMDevice macro
Message-Id: <20230817012738.EEBEAF8016D@alsa1.perex.cz>
Date: Thu, 17 Aug 2023 03:27:38 +0200 (CEST)
Message-ID-Hash: EC3RELAXKLRRECXMLSP5XLSWLPI67NGF
X-Message-ID-Hash: EC3RELAXKLRRECXMLSP5XLSWLPI67NGF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EC3RELAXKLRRECXMLSP5XLSWLPI67NGF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #339 was opened from WeirdTreeThing:

Currently, the variable name is dev instead of Device as the comment would suggest, update the name to fit the comment. Also, the variable gets ignored due to it getting set to nothing right away, remove that line to allow the variable to work as intended.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/339
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/339.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
