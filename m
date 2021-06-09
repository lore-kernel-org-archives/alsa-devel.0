Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C328BC48BCF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 23:33:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAC560FDC
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 23:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAC560FDC
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C42316F2;
	Thu, 10 Jun 2021 01:32:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C42316F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623281596;
	bh=b5EJbf0NpZc49+mIQCQA6XvZ2F56CYXX0T5TNeE9oVA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zr7NHTmig4+CjY8IsAPBBz8v6n4yMb3ruK48hFQCJzWP4XGGYyq+p2AuGopYRd5S/
	 zaroBgVoJKgjWBkUUYr8D+IofK0gqXZTkypehN9JIx1bAAhTbXXlZffUsZLz0cigvt
	 xNuolwNc8Hj3p1kYhrX9apKbjRT4QZc0eYeJ5l3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B605F8027C;
	Thu, 10 Jun 2021 01:32:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 034F2F802A0; Thu, 10 Jun 2021 01:32:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7A1F7F80116
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 01:31:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A1F7F80116
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623281516928031921-webhooks-bot@alsa-project.org>
References: <1623281516928031921-webhooks-bot@alsa-project.org>
Subject: aplay change to use 16-bit samples by default is not backwards
 compatible and is not documented
Message-Id: <20210609233201.034F2F802A0@alsa1.perex.cz>
Date: Thu, 10 Jun 2021 01:32:01 +0200 (CEST)
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

alsa-project/alsa-utils issue #96 was opened from nwoeanhinnogaehr:

The change introduced in https://github.com/alsa-project/alsa-utils/commit/0c5948e98a6a8535c89b7bcab13017d7732181c6 breaks a lot of scripts and other programs I have which invoke `aplay` and expect the default sample format to be U8. While I think it's somewhat reasonable to make this change given that U8 is a rather low quality sample format, it's worth acknowledging that aplay has had this behavior for a very long time and many people probably don't expect it to change.

Given that the commit log seems to only talk about the case of `arecord`, I wonder if we could reach a compromise and keep the format as U8 for `aplay` and switch it for `arecord`, since users are unlikely to complain about poor sound quality when *playing raw audio* (surely they would take the time to get the sample format set up correctly before attempting to play raw audio).

Also, the man page has not been updated to reflect this change and still says that U8 is the default.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/96
Repository URL: https://github.com/alsa-project/alsa-utils
