Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40EC2D0A3
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:41:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83AF206C1
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o+k6iynJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83AF206C1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45CB7167C;
	Wed,  4 Nov 2020 19:41:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45CB7167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604515311;
	bh=Ud3KrgE4jvpNGafd8zwQNa4Tg8hVZdHYsDgHHkx0Rbw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+k6iynJjw2WBsyaVRS55BlcU7j7ybs2+xSoe0EJUPLs8Q8vDhkGBMJ8dlTMDU0Vi
	 YjtVh80eeCiSEq4ZL01vP+Mcickl1vQdyqYn/BPa0AV0R1OglTvQAuuoPgQwdDvbl9
	 lMu3Q2es5f9Mp53tEzB+lvlRs+oKAHMtDPJ/z/EE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7DECF80232;
	Wed,  4 Nov 2020 19:41:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FAA5F80234; Wed,  4 Nov 2020 19:40:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 10CE1F800EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 19:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10CE1F800EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1604515251505948067-webhooks-bot@alsa-project.org>
References: <1604515251505948067-webhooks-bot@alsa-project.org>
Subject: [Feature Request] Add option to change Audio Mixer Source node (0x0c,
 0x0d, 0x0e etc)
Message-Id: <20201104184059.4FAA5F80234@alsa1.perex.cz>
Date: Wed,  4 Nov 2020 19:40:59 +0100 (CET)
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

alsa-project/alsa-tools issue #3 was opened from kevinsmia1939:

Hello,

I am looking for linux audio tool that can change Audio Mixer Source node, 0x0c to 0x0d for example.

HDA Analyzer can do this (right side in red circle of screenshot)
https://i.imgur.com/UcELkjU.png

But HDA analyzer use python 2 and some other depreciate python modules and since I reinstall my machine (openSUSE TW), I lost the old packages (install old packages manually does not work for some reason).
https://www.alsa-project.org/main/index.php/HDA_Analyzer

I tried HDAJackRetask, but could not find the option or feature to do it. 
However, HDAJackRetask is the closest thing to HDA Analyzer, so I think it would make sense to ask for this feature here.
If there are already tools that can do this (other than HDA Analyzer) please tell me.

Thank you.

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/3
Repository URL: https://github.com/alsa-project/alsa-tools
