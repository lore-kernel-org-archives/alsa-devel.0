Return-Path: <SRS0=oKMh=DZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D1C433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 03:36:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564DE2087C
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 03:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FA2F+Bsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564DE2087C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7755517F2;
	Sun, 18 Oct 2020 05:35:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7755517F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602992158;
	bh=EUjkVWR3b+l5nNhA6mB1AtIevCqK1J74I2H74RF/Fwg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FA2F+BsyTEydaHo6kJ0rz3IY0VmKJmWSfdPywzGV09BP3DLIoLy2MTFTJuaqND6Wy
	 djIfxU6Ez13op5HZ8Zn6RqBvQG0Letxk5vyaTBvc6tMaPqGMdlDBcT1CDRCy7uKhph
	 dnPg6AakJHeVFP7RT8B2X4hDQoiJMTdfBYwpc9Ak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09B42F80226;
	Sun, 18 Oct 2020 05:35:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AA8BF8024A; Sun, 18 Oct 2020 05:35:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A13B9F80111
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 05:35:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A13B9F80111
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1602992104416914940-webhooks-bot@alsa-project.org>
References: <1602992104416914940-webhooks-bot@alsa-project.org>
Subject: =?utf-8?q?arecord/aplay_man_page_should_separate_the_options_into_three_l?=
 =?utf-8?b?aXN0c+KApg==?=
Message-Id: <20201018033507.2AA8BF8024A@alsa1.perex.cz>
Date: Sun, 18 Oct 2020 05:35:07 +0200 (CEST)
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

alsa-project/alsa-utils issue #65 was edited from jidanni:

The arecord/aplay man page should perhaps separate the options into three lists
1. ones that affect recording,
2. ones that affect playing,
2. and ones that affect both.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/65
Repository URL: https://github.com/alsa-project/alsa-utils
