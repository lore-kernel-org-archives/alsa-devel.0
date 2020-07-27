Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96878C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:56:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA662074F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="haogfgbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA662074F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D33371697;
	Mon, 27 Jul 2020 20:55:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D33371697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595876188;
	bh=//OS3JsKt6ZUrrKjB0epCCS4y1cmbp4Rex54kph1ANk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=haogfgbNcj1D11bc5vdkBbSBXiT99Cn7YWiBiTKqDdmphA8hyBU/zbNigHB37oVz/
	 j/YuwdhSGLM9g4OL/cUuasJXHHjPm01/9DW6i8XoE/am4Nb6Zr0zuqyEjPycLcS2E3
	 yyFrMz2JxHfyTAudl4wDr1DnMWdbxTUHcQhtkvLc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CCACF80158;
	Mon, 27 Jul 2020 20:55:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D01F4F80171; Mon, 27 Jul 2020 20:55:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BE3F6F800DE
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 20:55:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE3F6F800DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1595876129414383888-webhooks-bot@alsa-project.org>
References: <1595876129414383888-webhooks-bot@alsa-project.org>
Subject: headphones detected but don't show up in alsa mixer,
 no audio on ubuntu 18.04
Message-Id: <20200727185536.D01F4F80171@alsa1.perex.cz>
Date: Mon, 27 Jul 2020 20:55:36 +0200 (CEST)
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

alsa-project/alsa-lib issue #75 was edited from rbavery:

Here is my ALSA info: http://alsa-project.org/db/?f=dd3d1d8a9fa0020900a0adc03bc6adfaf1f77ee5

I tried following these remedies (including reinstalling alsa, reloading, restarting computer) but nothing has panned out: https://support.system76.com/articles/audio/

Any help or suggestions are appreciated

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/75
Repository URL: https://github.com/alsa-project/alsa-lib
