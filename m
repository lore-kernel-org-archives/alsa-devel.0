Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967DCC10DAA
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596AA2080C
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iub7Xp6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596AA2080C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9395516F5;
	Wed,  9 Sep 2020 09:26:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9395516F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599636444;
	bh=/Wxyb0KqAoC8XqMZijnfNnHitVIRM1F6mL8VemjtvCw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iub7Xp6wrE+YEq5LIfEEytUkYADZIV6qjJ9IyWftHZPQ5w1Hpry+fr+23GJihVgqK
	 GIa+h52np6iRAQ3gyW4hpinVWyLsQe0MpyI07owcQu26nzaC/fdmvBWAj0fYTVqTQu
	 pLEwEyo2EGRKmxBjfMEA+U9LE+x5GFEQJg/Qj/dc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25DBEF8021C;
	Wed,  9 Sep 2020 09:26:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F15CDF80227; Wed,  9 Sep 2020 09:26:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 31CD3F800FD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 09:26:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31CD3F800FD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1599636381247245073-webhooks-bot@alsa-project.org>
References: <1599636381247245073-webhooks-bot@alsa-project.org>
Subject: Spdx tags: Use PSDX tags for this project
Message-Id: <20200909072631.F15CDF80227@alsa1.perex.cz>
Date: Wed,  9 Sep 2020 09:26:31 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/tinycompress pull request #7 was opened from vinodkoul:

Add SPDX tags and remove the license text, Also adds SPDX tags to files which have this missing

Request URL   : https://github.com/alsa-project/tinycompress/pull/7
Patch URL     : https://github.com/alsa-project/tinycompress/pull/7.patch
Repository URL: https://github.com/alsa-project/tinycompress
