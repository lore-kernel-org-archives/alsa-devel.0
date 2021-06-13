Return-Path: <SRS0=P1jl=LH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C81C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 19:58:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E681861245
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 19:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E681861245
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F8211753;
	Sun, 13 Jun 2021 21:57:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F8211753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623614298;
	bh=E2JEtqVmnggsz6jnVf/2WlQURSUafNIQHCPPZ1hz66E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oVT3GUxuCIVa87+EfZR0X7Xpx0BG5Ajy/BvowtmrpHOKIX+Z+8gFvg0d1SJ2ZjUQo
	 n9CSewj5i1O4kDTUgQLZE/N5VybuwzDn58F9AH6suhgrG+ErWLL1G0aY69jS68sX2q
	 wRuKPIFAC6chr2Af3tkVttwDUn00UP0jtOsV7Q4Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2046FF800FB;
	Sun, 13 Jun 2021 21:57:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0852BF80165; Sun, 13 Jun 2021 21:57:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 49AECF800F7
 for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2021 21:57:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49AECF800F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623614235852114916-webhooks-bot@alsa-project.org>
References: <1623614235852114916-webhooks-bot@alsa-project.org>
Subject: Some minor fixes for Topology2.0
Message-Id: <20210613195726.0852BF80165@alsa1.perex.cz>
Date: Sun, 13 Jun 2021 21:57:26 +0200 (CEST)
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

alsa-project/alsa-utils pull request #98 was opened from ranj063:



Request URL   : https://github.com/alsa-project/alsa-utils/pull/98
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/98.patch
Repository URL: https://github.com/alsa-project/alsa-utils
