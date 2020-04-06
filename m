Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A8C2BA17
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 00:48:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EA42072A
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 00:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cv+77iE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EA42072A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB35C1607;
	Mon,  6 Apr 2020 02:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB35C1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586134111;
	bh=Z5/OyYhiqyQtIxLr8+oJ7DFemyISjWa382zQvxcPvyY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cv+77iE8NDPyYg7wCZxlzatjHluRn55g109r8bWQT+yDPALLwXU8thjg7nRMM0shL
	 hDlwrkWGLWrd/FTcECfXebottphQpnT8VJmUtG9dhbL5+LOC1VPADWHiWa2q9UtPmY
	 gFjjXd3RQXkUi0d6s5tsWXn2J9MFqkaH+3k1o/gs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DF3DF8015A;
	Mon,  6 Apr 2020 02:47:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E365F801D8; Mon,  6 Apr 2020 02:47:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B2DCBF800E4
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 02:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2DCBF800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1586134056404263973-webhooks-bot@alsa-project.org>
References: <1586134056404263973-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: misc fixes
Message-Id: <20200406004740.4E365F801D8@alsa1.perex.cz>
Date: Mon,  6 Apr 2020 02:47:40 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #13 was opened from takaswie:

This patchset is misc fixes.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/13
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/13.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
