Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DBC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:57:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5922225F
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YC0UT4oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5922225F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D33016EE;
	Mon, 19 Oct 2020 19:56:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D33016EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603130232;
	bh=j1ijFFa2cvkc779EcoxJzWQ08aRNLYv/RMaQ7BsucCI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YC0UT4oMm63ADN7o6Zi+xsVBz/DC4SEOckWtv93lm6ocyYTiskngGQ2Zz8g40KcQS
	 YcpiQWuonU1XI6Ubq4RG8yIuipWI2X6mVIXuTe2IOinm8YFKHpPNlgc8naxvgCOm3m
	 U6v/oCts4zw5NMuHcgXKyA73e1R/uiZUZvtdnHHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F335EF801D5;
	Mon, 19 Oct 2020 19:56:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59DBFF80247; Mon, 19 Oct 2020 19:56:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E0F95F801A3
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 19:56:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0F95F801A3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603130174879039049-webhooks-bot@alsa-project.org>
References: <1603130174879039049-webhooks-bot@alsa-project.org>
Subject: No sound after upgrade from 1.2.3 to 1.2.4 (Xiaomi Redmibook 16 II
 Ryzen Edition)
Message-Id: <20201019175620.59DBFF80247@alsa1.perex.cz>
Date: Mon, 19 Oct 2020 19:56:20 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #55 was opened from deponian:

Hello.
Yesterday I have upgraded Arch Linux on my laptop with `pacman -Syu` and after reboot I've had no sound from built-in speakers. I had downgraded all upgraded packages and started upgrading one-by-one with reboot after every step. I have found out that upgrading `alsa-ucm-conf` package from `1.2.3-2` to `1.2.4-1` is causing the issue. If I understand correctly my laptop has something called `Family 17h (Models 10h-1fh) HD Audio Controller` which is using for output and `Raven/Raven2/FireFlight/Renoir Audio Processor Stereo` which is using for input. After upgrading to `1.2.4` I had had only broken output, the input (microphone) was working correctly.
I have attached two outputs of `alsa-info.sh` to this message: one before and other one after upgrade.
[alsa-info-1.2.3.txt](https://github.com/alsa-project/alsa-ucm-conf/files/5403794/alsa-info-1.2.3.txt)
[alsa-info-1.2.4.txt](https://github.com/alsa-project/alsa-ucm-conf/files/5403796/alsa-info-1.2.4.txt)
I hope it will help.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/55
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
