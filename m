Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE44C0044D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:33:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAE620674
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="itm/kOGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAE620674
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DF2216C1;
	Mon, 16 Mar 2020 23:32:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DF2216C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584398009;
	bh=51jYDR2ZjKAfVv/Sdg9b56O4h6BwL3IlnWS9Hq5UAEU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=itm/kOGHjXrfEVi3ZLqOea3P9TX+mM5bkko2Vlo6x/h9QUi1Tf83m6iVxeVNNJHsx
	 on9G3FuHsKx+zDhpHfjmJ+VVzoy9dgVmVY4++zqdM4pqM7xVEcKusFs6LONMtVH9xG
	 D+C/w/liLiAWWeuxDIlhhpz1LKZ2jOyua0c88sso=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5D4DF80110;
	Mon, 16 Mar 2020 23:32:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F1D5F8015B; Mon, 16 Mar 2020 23:32:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A4D56F800D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 23:32:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4D56F800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1584397953813324928-webhooks-bot@alsa-project.org>
References: <1584397953813324928-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: initial UCM2 version
Message-Id: <20200316223237.3F1D5F8015B@alsa1.perex.cz>
Date: Mon, 16 Mar 2020 23:32:37 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #17 was opened from plbossart:

Add conditional inclusion of sections

This goes with the kernel PR https://github.com/thesofproject/linux/pull/1889

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/17
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/17.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
