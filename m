Return-Path: <SRS0=xxPz=2E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0707C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 18:20:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F209020706
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 18:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XGPPut3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F209020706
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D00E1666;
	Sat, 14 Dec 2019 19:19:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D00E1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576347603;
	bh=rMGmXERq9rtE4d+veytBMho1AsUWbQkwmTKvm7i1hF0=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGPPut3bgxP4b+IllX8ed5+Gc/WNZ8rK91i097oA4OtfEXaSU1PCfEH2nVTmv68Lp
	 BAIq2+5anz1ONmw7Qu7DpXoXIl/WEMu//it9Yo4kZHNI98CvsxWjfO3VwLTPOD/V9V
	 jKmGm2+PskTh97OOVeL6mOIHYKOZCyiUrrpJxwEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E82EDF801D8;
	Sat, 14 Dec 2019 19:19:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F308F8020C; Sat, 14 Dec 2019 19:19:11 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9E976F80139
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2019 19:19:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E976F80139
MIME-Version: 1.0
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1576347545656913996-webhooks-bot@alsa-project.org>
References: <1576347545656913996-webhooks-bot@alsa-project.org>
Message-Id: <20191214181911.4F308F8020C@alsa1.perex.cz>
Date: Sat, 14 Dec 2019 19:19:11 +0100 (CET)
Subject: [alsa-devel] Code Example for Playing Sound in the Background
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #17 was edited from leimao:

Hello,
I wrote a simple C++ player based on alsa-lib which allows me to play `wav` files. I wonder if there is any convenient way to modify my code so that I can play the the `wav` file in the background and the main program is executing something else, say, a `while` loop. 
Edited and Updated:
I tried to use `std::thread` and `std::async`, I was able to play the sound in the background. I looked at the header file of alsa-lib, it seems that alsa-lib natively supports playing sound asynchronously. I wonder how I could do it easily.
Thank you very much.
Best,
Lei

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/17
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
