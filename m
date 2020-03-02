Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD61C3F2D2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:48:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D99222B48
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q9W3vmM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D99222B48
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BFC816A1;
	Mon,  2 Mar 2020 11:47:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BFC816A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583146117;
	bh=zqXEUu5q7AWEGLTc7soBCHee8ADB4oKrwDY5nWZPVR8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9W3vmM1ec85DEAe5CI5MX0gAu4Qn8MUgPoOn8E0Kl7z6EfQuZ67JByrwlE95Obns
	 dWZvxOT5ZMig720EPaFpdftXzpyvVg15k0ugwkey3r9jqicd1UNwR7Q0rpbNKc1BFy
	 85QV5Rqy5KbvXYmqon81Er56L/qoB/pEgyEFA8SE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B398CF801EC;
	Mon,  2 Mar 2020 11:47:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 363E0F801ED; Mon,  2 Mar 2020 11:47:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 42F8EF80131
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 11:47:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42F8EF80131
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583146061636600018-webhooks-bot@alsa-project.org>
References: <1583146061636600018-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: add support for i386 build job to workflow of Github
 Actions
Message-Id: <20200302104745.363E0F801ED@alsa1.perex.cz>
Date: Mon,  2 Mar 2020 11:47:45 +0100 (CET)
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

alsa-project/alsa-gobject pull request #9 was opened from takaswie:

In lxd repository for Ubuntu Cloud Images[1], Ubuntu i386 container
is available for applications of Intel386 ABI.

This commit uses the container to test build for Intel386 ABI in
workflow of Github Actions.

I note that no official Fedora i386 container is in dockerhub
registry[2]. It's needed to find the way to build application for
Intel386 ABI on AMD64 architecture (perhaps multiarch) if we are
going to support it.

[1] https://cloud-images.ubuntu.com/releases/
[2] https://hub.docker.com/_/fedora

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/9
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/9.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
