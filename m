Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B92C47084
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 10:21:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A67610C8
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 10:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A67610C8
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B3A7823;
	Mon, 24 May 2021 12:20:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B3A7823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621851661;
	bh=9PhHXZTSBzSJs1jPHee5oYSpo+uQ/QtKIuXvwPd3Te0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2/vHNE3p+TSNVDuDJVQHnXFr2r/5P4N/sJUQGZzGrPlQhvYHAe2Ch3ykkAJGkaQ9
	 w2VJ+Vw82ayX6jZy0c3OT25PzLR07qzrcby7YxkMZ0j0PkbAtGUAqzjiD/9z6AdoUz
	 AJjgj+K4HnZtw59PurbvY88T4ZcLq6Z89oj02nHI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9B3AF8021D;
	Mon, 24 May 2021 12:20:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA323F8022B; Mon, 24 May 2021 12:20:08 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7A883F80149
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 12:20:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A883F80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1621851601852592945-webhooks-bot@alsa-project.org>
References: <1621851601852592945-webhooks-bot@alsa-project.org>
Subject: Add UCMs for Google Asus Nexus 7 and  Acer Iconia A500
Message-Id: <20210524102008.CA323F8022B@alsa1.perex.cz>
Date: Mon, 24 May 2021 12:20:08 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #92 was reopened from digetx:

@perexg As was discussed previouly at https://www.spinics.net/lists/alsa-devel/msg126382.html I'm opening PR with the UCMs for  Nexus 7 and A500. Both these devices are supported by the mainline Linux kernel. 

You're right that Tegra ASoC driver doesn't set card's name properly. In particular I found that we need to set the card's `driver_name` to `tegra`, then UCM get a proper lookup path.

I rebased UCMs on top of the recent alsa-ucm-conf master and switched Nexus 7 UCM to use generic RT5640 UCM. Everything works great once the card name of the kernel driver is corrected. I'll send the kernel patches ASAP for review.

Nexus 7 alsa-info: https://alsa-project.org/db/?f=0a29f1dab39ec5b33e01215dee42dbfd1dbbf08e
A500 alsa-info: https://alsa-project.org/db/?f=bde4f7938a39b1d26904b414969fc811e726242f

The alsa-info is taken using the updated kernel ASoC driver.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/92
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/92.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
