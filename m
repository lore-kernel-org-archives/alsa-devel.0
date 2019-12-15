Return-Path: <SRS0=oJpy=2F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687ACC43603
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Dec 2019 23:13:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EE120726
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Dec 2019 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mlx4ZR4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EE120726
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3F641655;
	Mon, 16 Dec 2019 00:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3F641655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576451634;
	bh=89A7X/p0GDbdp5UU7oGifsGtMn7tvP8+x28VhaRxbHc=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mlx4ZR4gTBJ2dtMyNTdGaoGDoYDqnE3h57oLopEHd8O439iEyg24HStJKFy4fD7KJ
	 UGsv5Wix4bezbpSv943IUCtrDZsWO5rKbW9ZUFUkZ+6Xjwb5Vg8tFhFqnVM1MK5tXF
	 Drow4tfQBX4CjG0wKCloHLvhevqbPnsS+kMj0CMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A4FBF80260;
	Mon, 16 Dec 2019 00:12:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F45AF80264; Mon, 16 Dec 2019 00:12:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3F76DF8025F
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 00:12:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F76DF8025F
MIME-Version: 1.0
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1576451538989263058-webhooks-bot@alsa-project.org>
References: <1576451538989263058-webhooks-bot@alsa-project.org>
Message-Id: <20191215231221.9F45AF80264@alsa1.perex.cz>
Date: Mon, 16 Dec 2019 00:12:21 +0100 (CET)
Subject: [alsa-devel] Don't use 16 bit signed integers for sample rate
	conversion.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-plugins issue #5 was edited from crocket:

Sample rate conversion should be done with the highest resolution possible.
Once sample rate conversion is done, using S32_LE is meaningless.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/5
Repository URL: https://github.com/alsa-project/alsa-plugins
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
