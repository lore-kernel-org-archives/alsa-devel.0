Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C7C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 04:13:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF6161185
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 04:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF6161185
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6B1A16C0;
	Thu, 17 Jun 2021 06:13:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6B1A16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623903235;
	bh=BvVAqJSQlix/SUgqpWoGdxG3S3QKQrAqaXP8u+Qca4E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJVRqGH4LFaG7f1d31jXy8YJimkn6gFIliM2yLvFtooVicbGmNMMxVzvMqaqGQsba
	 3diCanhXF6jcEMQLexHAFxpNzB8rrE6JKn3t06RPeBoUPPehtzDbLMeGvI/zJdwBUI
	 Vkh47KTjl8kRTWV5BKtGg+twwKKpw8ysVbYEnI+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 087EBF80171;
	Thu, 17 Jun 2021 06:13:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAD4BF8025A; Thu, 17 Jun 2021 06:13:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 48BD7F80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 06:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48BD7F80148
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623903169197036028-webhooks-bot@alsa-project.org>
References: <1623903169197036028-webhooks-bot@alsa-project.org>
Subject: HDA-Intel: add Boost volume control for Headset Mic
Message-Id: <20210617041302.EAD4BF8025A@alsa1.perex.cz>
Date: Thu, 17 Jun 2021 06:13:02 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #101 was opened from jason77-wang:

Ubuntu Linux users complain even they set the input volume to maximum,
they still can't record sound with a pretty satisfied volume, they
need to run commandline commands to adjust "Mic Boost/Headset Mic
Boost/Headphone Mic boost" value to increase the input volume.

That is because the current ucm only defines "Capture Volume" to
control the input volume. Here we add Boost control, then users could
adjust both "Capture Volume" and "Boost Volume" through Pulseaudio and
Gnome.

BugLink: https://bugs.launchpad.net/bugs/1930188
Signed-off-by: Hui Wang <hui.wang@canonical.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/101
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/101.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
