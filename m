Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F45EC197A0
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Nov 2023 20:54:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EAA884B;
	Thu, 16 Nov 2023 21:53:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EAA884B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700168057;
	bh=y1pZ6V7UNxhxgrMvBL7YDlaqEEkm0HOkzYE9UDCAl8A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FIZ4vUM90D6ULQaBYA8fYrLoA2kNrquXggBqCXEyIeuiGOQqug9qaqrAGYgw8VWix
	 JojqeiOSMq68mOEREYi3o8ZvCgfYL55xgEKCcAqxLp7xjX36efoBIU2Mq+ML51lCWz
	 +7b2l2sP5Ks+8eT1wmlMxjDk5SOqnqGWRRWdQ5MA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1668EF80549; Thu, 16 Nov 2023 21:53:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A87F4F80152;
	Thu, 16 Nov 2023 21:53:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62698F801D5; Thu, 16 Nov 2023 21:52:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 346F0F80152
	for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2023 21:52:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 346F0F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1700167972428574562-webhooks-bot@alsa-project.org>
References: <1700167972428574562-webhooks-bot@alsa-project.org>
Subject: ucm: fix TOCTOU race condition
Message-Id: <20231116205256.62698F801D5@alsa1.perex.cz>
Date: Thu, 16 Nov 2023 21:52:56 +0100 (CET)
Message-ID-Hash: SBOJJOULGNCJ5QJJIRBVMGWAWUXUIA5Q
X-Message-ID-Hash: SBOJJOULGNCJ5QJJIRBVMGWAWUXUIA5Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SBOJJOULGNCJ5QJJIRBVMGWAWUXUIA5Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #367 was opened from szsam:

Separately checking the state of a file before operating on it may allow an attacker to modify the file between the two operations. Fix by calling readlink first. If that fails, then path should not be a symbolic link and we call open() followed by fstat(). open() with O_NOFOLLOW will return an error if the file is a symlink.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/367
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/367.patch
Repository URL: https://github.com/alsa-project/alsa-lib
