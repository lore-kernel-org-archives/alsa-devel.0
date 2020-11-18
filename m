Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0817AC56202
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 10:12:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E9C22210
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 10:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ciP4ghch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E9C22210
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA6AD172D;
	Wed, 18 Nov 2020 11:11:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA6AD172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605694338;
	bh=BgcAqdo7MYdwsSMHKZqz/3q3vSyuLzpwVg4tONTlAUs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ciP4ghchpylYN78ExAvA+rexsDOCsAUKFvIfaRAynJWKJ8UYClPs1bI/FFxjksfNM
	 BKZR+hjY+orTCEHi8fIpYiHY4aLyGThUT3DvbkO0QUBujR0eJzWJAfS3xFKwOdRp43
	 snO1QQrOdEY/zndJR+TJfNjppmsbe/uQ43MFWBa8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35047F80168;
	Wed, 18 Nov 2020 11:11:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E966BF80168; Wed, 18 Nov 2020 11:11:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2241DF8010A
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 11:11:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2241DF8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605694272096045017-webhooks-bot@alsa-project.org>
References: <1605694272096045017-webhooks-bot@alsa-project.org>
Subject: snd_pcm_hw_params_set_period_size_near() bug???
Message-Id: <20201118101126.E966BF80168@alsa1.perex.cz>
Date: Wed, 18 Nov 2020 11:11:26 +0100 (CET)
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

alsa-project/alsa-lib issue #99 was edited from YangangCao:

it's my fault, no big deal

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/99
Repository URL: https://github.com/alsa-project/alsa-lib
