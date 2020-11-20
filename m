Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA12C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 18:25:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD8824124
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jq1F/AGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD8824124
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59B0E1616;
	Fri, 20 Nov 2020 19:25:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59B0E1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605896751;
	bh=YfQbyfTOlz2D8d2aUNp6HftGDpenJCbAuVUVsr/Gl9Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jq1F/AGCIZFH0UZSjI31DZ7PjAgdpAToqbPvxdWePXGDA8HdkuSsA/YOVoaZD/9Ca
	 kJ7i5woJtNP8vobW/iEi83rEG5V3/VKVvTkCV0GTtxPYFECYDNfNGivSIzqymOwIbU
	 iSK8eL4t0eL+uhmEpUCmXQAsJwtYIX6K/Bj4HwAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADDE3F80166;
	Fri, 20 Nov 2020 19:25:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E010BF8016E; Fri, 20 Nov 2020 19:24:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9562EF80168
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 19:24:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9562EF80168
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605896696222091913-webhooks-bot@alsa-project.org>
References: <1605896696222091913-webhooks-bot@alsa-project.org>
Subject: ucm2: add support to for Qualcomm RB5 Platform
Message-Id: <20201120182459.E010BF8016E@alsa1.perex.cz>
Date: Fri, 20 Nov 2020 19:24:59 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #63 was opened from Srinivas-Kandagatla:

This patchset adds support to The Qualcomm Robotics RB5 Platform Audio ports.
RB5 has 2 WSA881X smart speakers attached via Soundwire, HDMI and a DMIC0 on the board.
All the audio related patches are merged in ASoC tree.

Also to note that the driver name and long card names are fixed properly on all new and old machine drivers so that we can organise the ucm2 directories correctly. That is the reason for moving sm8250 out of Qualcomm folder.

Thanks,
srini

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/63
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/63.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
