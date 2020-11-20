Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93EAC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 18:16:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EC82242B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 18:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bQMnqo94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EC82242B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E37831720;
	Fri, 20 Nov 2020 19:15:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E37831720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605896200;
	bh=QYf+eEclZnRa5HwARVW77K3bT/hojgGsgxeezor0fdE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQMnqo94fHRcp4zvAsRLQriNzP+iV47BjvHGUzoGPJ5yaEH4N+Y1MpeXXAXOFSemF
	 DMftZWxkWO3Dw3E534aW4cCMiAAPu0Z5qUr+s80x5/hgqRRJ/pMArNDy152dVwiasJ
	 qXiWZaHw7Yqrj1QReMttPfUKCc+hOFNR05ke5vxs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57593F80168;
	Fri, 20 Nov 2020 19:15:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18F6DF8016C; Fri, 20 Nov 2020 19:15:48 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BDE0CF80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 19:15:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDE0CF80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605896143622390032-webhooks-bot@alsa-project.org>
References: <1605896143622390032-webhooks-bot@alsa-project.org>
Subject: Sm8250 v1
Message-Id: <20201120181548.18F6DF8016C@alsa1.perex.cz>
Date: Fri, 20 Nov 2020 19:15:48 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #62 was opened from Srinivas-Kandagatla:

This patchset adds support to The Qualcomm Robotics RB5 Platform Audio ports.
RB5 has 2 WSA881X smart speakers attached via Soundwire, HDMI and a DMIC0 on the board.
All the audio related patches are merged in ASoC tree.

Also to note that the driver name and long card names are fixed properly on all new and old machine drivers so that we can organise the ucm2 directories correctly. That is the reason for moving sm8250 out of Qualcomm folder.
Thanks,
srini

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/62
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/62.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
