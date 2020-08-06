Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4439DC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:31:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2B322D04
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BFRErP0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2B322D04
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D890165E;
	Thu,  6 Aug 2020 11:04:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D890165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596704725;
	bh=YCcZ0XzFwwmlBlGmUtqQ44yi0kdRmXS4B4ko9YPq75o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFRErP0XsGAz2EU6G0GamKd2OVEDZuHBEqlRdO/4kyFCVVP4V6epYrW/vcCeSlSce
	 U4MYRvIOWsZPDDH8z8ZJ4SomWvM2wNZyA8z1g8vD18RrcJQ2TZh0O7A9oReAnGcY5W
	 vkRadWJkTyq2fV1yQMCE8+OWdKltxk+KSJIATYKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28440F80150;
	Thu,  6 Aug 2020 11:04:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3258AF80159; Thu,  6 Aug 2020 11:04:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7C7FAF800B7
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 11:04:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C7FAF800B7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1596704665622306108-webhooks-bot@alsa-project.org>
References: <1596704665622306108-webhooks-bot@alsa-project.org>
Subject: Add support for Lenovo ThinkStation P620 Main Audio
Message-Id: <20200806090433.3258AF80159@alsa1.perex.cz>
Date: Thu,  6 Aug 2020 11:04:33 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #42 was opened from khfeng:

This add support for internal speaker and front headset.

We need two separate configs to let PulseAudio understands they are two
different profiles, so the headset's port availability won't affect
speaker's profile availability.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/42
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
