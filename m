Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C02FC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 20:20:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A9960F94
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 20:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01A9960F94
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE2771755;
	Tue, 10 Aug 2021 22:19:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE2771755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628626797;
	bh=vH0Sy0anl6Si9RrYUC3n7jXDZ3b1NorZPTWoYqpUCSs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eTuob2BFvZZbJWVHj7739izes+q93jMctBloc7lKAjiOxmlWxKv19sJZdCCEcg/qX
	 pphLx7lvpw0j7TT7RRz/EmC9sAhbGSlRhvul1FzUhUqAX7kQCiwpnxz8VzfkgrH1lv
	 dGIUuCrybCe6MU9Hm0bO086K3mR/lqkERa0TaGtc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 326CCF80245;
	Tue, 10 Aug 2021 22:19:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0FE6F8025D; Tue, 10 Aug 2021 22:19:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 48BCAF800C8
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 22:19:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48BCAF800C8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1628626741915877104-webhooks-bot@alsa-project.org>
References: <1628626741915877104-webhooks-bot@alsa-project.org>
Subject: Fix alsa-utils building error on NetBSD
Message-Id: <20210810201905.B0FE6F8025D@alsa1.perex.cz>
Date: Tue, 10 Aug 2021 22:19:05 +0200 (CEST)
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

alsa-project/alsa-lib pull request #169 was opened from triaxx:

The following errors occur at least on NetBSD 9.2 amd64 when building
alsa-utils:
include/alsa/output.h:75:66: error: unknown type name 'va_list'; did you mean '__va_list'?
include/alsa/error.h:80:25: error: unknown type name 'va_list'; did you mean '__va_list'?

Request URL   : https://github.com/alsa-project/alsa-lib/pull/169
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/169.patch
Repository URL: https://github.com/alsa-project/alsa-lib
