Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C988DC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Jan 2022 01:44:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE3011AC1;
	Thu, 27 Jan 2022 02:43:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE3011AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643247862;
	bh=I8GZ48CJ2WGu2zjtEi6KZSVKuHOtXWkz4rH/2jIFMPg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfCEk2xcTmPb2iPRxBjC3Lr7O2IXEj9hJCaf8/vFe5idsbipIXUTxwKsPXPK1NT71
	 FU9dZMK0TtJGEWRA+olJHoKZqQTnZL3QhSpyJihlpTC4CDBXKcqm9eGMEqIhOxXnb4
	 +qlg6NgqKEaKl7a6u1+9PSlk/o3eEeDWW5MNw1NY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34D58F8047D;
	Thu, 27 Jan 2022 02:43:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AB93F8049C; Thu, 27 Jan 2022 02:43:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C7389F800C8
 for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2022 02:43:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7389F800C8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1643247802228596926-webhooks-bot@alsa-project.org>
References: <1643247802228596926-webhooks-bot@alsa-project.org>
Subject: Fixes for attribute value validation in the topology pre-processor
Message-Id: <20220127014329.9AB93F8049C@alsa1.perex.cz>
Date: Thu, 27 Jan 2022 02:43:29 +0100 (CET)
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

alsa-project/alsa-utils pull request #138 was opened from ranj063:

This PR fixes 2 issues:
1. Allow variable definitions within included conf files
2. Validating attributes after expanding the variables

Request URL   : https://github.com/alsa-project/alsa-utils/pull/138
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/138.patch
Repository URL: https://github.com/alsa-project/alsa-utils
