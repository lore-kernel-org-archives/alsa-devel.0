Return-Path: <SRS0=KBIP=AC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D413DC433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Jun 2020 17:05:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A9122249
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Jun 2020 17:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QIWklk9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A9122249
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 063D41616;
	Sun, 21 Jun 2020 19:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 063D41616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592759145;
	bh=aO2PqFOwpVTvEDqqOKIznBfSt9BaNwGhNLVYwaeGxqs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QIWklk9mh5obNtCyi5x1x/hBR4fWpdltO4WdCrDFvmn/9nhFe2ZDaisQSyKiz9hA1
	 HeZKf/OokTs7HG38M62WslvWCcbquFRu2C+q13ATt/AU0ZehNGV1YyTUtbEpeMiXv5
	 2IiS+BZA3uzHkOHcere2RvMZVZLyoW10tWKsiRNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80318F80218;
	Sun, 21 Jun 2020 19:04:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6891DF8023E; Sun, 21 Jun 2020 19:04:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7F0E4F800D0
 for <alsa-devel@alsa-project.org>; Sun, 21 Jun 2020 19:04:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F0E4F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592759085928977013-webhooks-bot@alsa-project.org>
References: <1592759085928977013-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: reorder documentation sections
Message-Id: <20200621170450.6891DF8023E@alsa1.perex.cz>
Date: Sun, 21 Jun 2020 19:04:50 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #45 was opened from takaswie:

For better documentation, this patchset reorders sections of ALSATimer/ALSASeq documentation.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/45
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/45.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
