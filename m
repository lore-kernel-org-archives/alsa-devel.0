Return-Path: <SRS0=ossE=5U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4762C2BA16
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Apr 2020 05:38:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A53206F5
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Apr 2020 05:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="amZzSP3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A53206F5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9DB81670;
	Sat,  4 Apr 2020 07:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9DB81670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585978690;
	bh=Ny0Shu1cTJGwBMcN37gZ+mlcLcxUnj7VWxh03EYpRmQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=amZzSP3qARyvMXoKlnOmvS+Ka8FDDGNLFqt/cW5y3xA0SGgK7lF0vT2mMtwnFqeCd
	 FKXz/tOCara0arP2Fm5JLwPvGS77812UoYISEfTSZVmGGcbDHDFmEDRZO6+n/knqsM
	 xJTBPtyz4zxy17BK1eqm/bAQT2hcGphaJe20MiFc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F0DCF80146;
	Sat,  4 Apr 2020 07:37:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E064F80148; Sat,  4 Apr 2020 07:37:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5D0DCF80131
 for <alsa-devel@alsa-project.org>; Sat,  4 Apr 2020 07:37:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D0DCF80131
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1585978625896482944-webhooks-bot@alsa-project.org>
References: <1585978625896482944-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: fix annotations for constructors
Message-Id: <20200404053715.2E064F80148@alsa1.perex.cz>
Date: Sat,  4 Apr 2020 07:37:15 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #12 was opened from takaswie:

Some constructor functions have redundant or invalid annotations.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/12
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/12.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
