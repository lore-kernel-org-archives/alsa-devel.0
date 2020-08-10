Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B52C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 04:27:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EE020734
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 04:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k/ug+jZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EE020734
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7390D15F2;
	Mon, 10 Aug 2020 06:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7390D15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597033643;
	bh=DrzdwhY44gqBm31TvcdiwW8TnIoWCMru2KHCA9g3cx0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/ug+jZ5QCXxZSzcjzatOvOwp8EZ9Ox/BoxIgDLwP8gIHdQN1mrySv0qMtcrMnlO9
	 iHfHi9WPItMklWwl07jfsWJkCztwWMPW5m0JAl6g/CVvIV4sML34O9yypUYhpHXLtX
	 P5ithyf/E44ioObM76zYuR5ohCZ6dtXNxRqCwXos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E523F80085;
	Mon, 10 Aug 2020 06:26:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 583F0F8022B; Mon, 10 Aug 2020 06:26:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 63DD6F80085
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 06:26:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63DD6F80085
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1597033583603136063-webhooks-bot@alsa-project.org>
References: <1597033583603136063-webhooks-bot@alsa-project.org>
Subject: Low volume with chtmax98090 (Toshiba Chromebook 2/Swanky)
Message-Id: <20200810042629.583F0F8022B@alsa1.perex.cz>
Date: Mon, 10 Aug 2020 06:26:29 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #45 was opened from reanimus:

It looks like the UCM configuration for this board is the Chromebook Asus C300 one, but the volume levels set by default are far too low. It looks like when Pulseaudio loads on my system, it follows the initialization steps and results in a really low volume, as the Speaker is set to 27/100 and one must manually set the alsamixer levels to fix it. I could have a periodic task reload the volume state, but I find it better to override the UCM configuration manually and tell my package manager to ignore changes to that file during upgrade.

Naturally, this is a bit of a nasty solution. It'd be nice to have an upstream fix in case other stuff is changed for this.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/45
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
