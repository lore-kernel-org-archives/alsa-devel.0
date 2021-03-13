Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873AC433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 00:08:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6492964F70
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 00:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6492964F70
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1383218A2;
	Sat, 13 Mar 2021 01:07:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1383218A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615594129;
	bh=8dD3Ae6KzFF1dIAJ4wbFmNkIO6nXj2EmWdKTADKz2ko=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFR0f0B0xTqhaUm01wcfsKhdZD0tYT6rtX/lO1CUFuoEJD0ZO7SoMpZT72vlNWfc5
	 rhDCwick+Uy8es844Q+53fE7QQsn1Knbz+Juc5X52xPgUftuqSuOntCf6YP3IMSWc4
	 WGKmGDbU5D9SUAs2+GrKqyVAn8my2ZDWyyf0/xvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DB9EF8016C;
	Sat, 13 Mar 2021 01:07:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF381F801D8; Sat, 13 Mar 2021 01:07:54 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 104B9F800BF
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 01:07:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 104B9F800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1615594064864351988-webhooks-bot@alsa-project.org>
References: <1615594064864351988-webhooks-bot@alsa-project.org>
Subject: alsa_snd_pcm_hw_params() on Ubuntu 20.04 started returning an
 unexpected -ENOMEM
Message-Id: <20210313000754.DF381F801D8@alsa1.perex.cz>
Date: Sat, 13 Mar 2021 01:07:54 +0100 (CET)
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

alsa-project/alsa-lib issue #125 was opened from philburk:

This seems to be a regression in a recent release.

It was reported on the PortAudio GitHub repo. See here for more details:

https://github.com/PortAudio/portaudio/issues/526

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/125
Repository URL: https://github.com/alsa-project/alsa-lib
