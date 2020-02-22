Return-Path: <SRS0=t3YC=4K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E42C35671
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Feb 2020 19:29:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796C206ED
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Feb 2020 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BGEyjXpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796C206ED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F61816B8;
	Sat, 22 Feb 2020 20:29:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F61816B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582399796;
	bh=MJS5P/hGKVI6eQ6a9/M8dVxRVtckvw4it5dbYh14/Ho=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BGEyjXpk/dCuCxF1CsoHcwynFHlg8c4bpnnxbNPvcK2VyR/lKS7tlgfDTyFyz2E7q
	 U5ZNuF37Ox205+73tEJN4STwvsFNKMxQncb60SoC1T4sCzy7BMLr6usam0NRzpHZ7c
	 BLPKoLfkD3McR7qRDahY+iC6BtbaxxBJZ38rG3I4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B258F80145;
	Sat, 22 Feb 2020 20:29:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AC1EF80148; Sat, 22 Feb 2020 20:28:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2D566F8011D
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2020 20:28:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D566F8011D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1582399732574770927-webhooks-bot@alsa-project.org>
References: <1582399732574770927-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.2 breaks Shovel Knight, 1.2.1.2 is still working.
Message-Id: <20200222192858.7AC1EF80148@alsa1.perex.cz>
Date: Sat, 22 Feb 2020 20:28:58 +0100 (CET)
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

alsa-project/alsa-lib issue #27 was opened from DarkWav:

So, today after upgrading to alsa-lib 1.2.2 I noticed the game "Shovel Knight" does no longer launch.
Any Ideas why this could be happening?
Sadly steam or the game executable won't provide any usable debug info :( .

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/27
Repository URL: https://github.com/alsa-project/alsa-lib
