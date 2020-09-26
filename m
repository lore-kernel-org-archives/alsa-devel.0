Return-Path: <SRS0=yvFc=DD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47AC2D0A8
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:03:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A66221EA
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h4sQx+f4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A66221EA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54B7B1940;
	Sat, 26 Sep 2020 15:02:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54B7B1940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601125383;
	bh=3PFG3N7XwK6O4p1fn6Zp0ZDTTM5E9MZj+kTkguS9S00=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h4sQx+f47esO3DubcIj/QzWCDzJ5lwDobJE7ylocV+6aRWN5oag5lBLcUukR2PCES
	 COElON4Xgs6DDObgKZ7royooxk1QQxWDojFjTWzivK5Y1EtDvQZCWDO4N7NOYhYlbU
	 WYIaiXaIFvCJKTstRR73FqP51XW6ZjTSQNVydANA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4D3EF80229;
	Sat, 26 Sep 2020 15:02:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55BE8F80229; Sat, 26 Sep 2020 15:02:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E8C9EF800FD
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2020 15:02:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8C9EF800FD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1601125327433012009-webhooks-bot@alsa-project.org>
References: <1601125327433012009-webhooks-bot@alsa-project.org>
Subject: Ability to set ALSA PLUGIN DIR,
 etc. at runtime via environment variables
Message-Id: <20200926130211.55BE8F80229@alsa1.perex.cz>
Date: Sat, 26 Sep 2020 15:02:11 +0200 (CEST)
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

alsa-project/alsa-lib issue #82 was opened from peanutbutterandcrackers:

Hello there,

I would like to request a feature to set things like `ALSA_PLUGIN_DIR` etc during runtime using environment variables. Currently, these seem to be set-able only at build-time, or by using a `.asoundrc` file.

Or, if something like that is already possible, please do point me to the relevant documentation. Thank you very much.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/82
Repository URL: https://github.com/alsa-project/alsa-lib
