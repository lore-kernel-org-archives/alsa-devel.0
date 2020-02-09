Return-Path: <SRS0=eYvk=35=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D7C35242
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 03:10:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306E620714
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 03:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B0/vzLMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306E620714
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F93B169B;
	Sun,  9 Feb 2020 04:09:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F93B169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581217844;
	bh=A6lOHWKlUHo8iHJwLrGhybq5uVoBvmXryOSK2StHWNk=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0/vzLMhHifb9kIEZMCzK6Mm61StC2W8XHQAcmuQSUg+p5p7XaQk7o+/x5pE1ObBn
	 zsGFsxiqSv9n24MN7WWnsCB4j/Mfhpcw8up6EqibhHKsLT2WDgSBNmOrltaSYqsn2q
	 hfYnvbGNNZ4w1FIKeGFuCpllNa9IYXj1887ziJec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA729F8012F;
	Sun,  9 Feb 2020 04:09:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCC47F80145; Sun,  9 Feb 2020 04:09:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A629F800E7
 for <alsa-devel@alsa-project.org>; Sun,  9 Feb 2020 04:09:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A629F800E7
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1581217784833240032-webhooks-bot@alsa-project.org>
References: <1581217784833240032-webhooks-bot@alsa-project.org>
Message-Id: <20200209030951.DCC47F80145@alsa1.perex.cz>
Date: Sun,  9 Feb 2020 04:09:51 +0100 (CET)
Subject: [alsa-devel] alsa-gobject: fix workflow of Github Actions to clone
	requested repository
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

alsa-project/alsa-gobject pull request #7 was opened from takaswie:

Even if any pull request is triggered, in 'build_in_ubuntu_on_lxd' job
of 'Build test' workflow, upstream repository is cloned and requested
git hash is checked out. However this fails because the hash is in
requested repository.

This commit fixes the workflow so that requested repository is cloned.

Fixes: 8cb6715aab65 ('Add support workflow of Github Actions')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/7
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/7.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
