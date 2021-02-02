Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A42DC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 14:44:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1991864ED7
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 14:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1991864ED7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C940D1730;
	Tue,  2 Feb 2021 15:43:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C940D1730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612277064;
	bh=a/y048rnWEMuLGwuM0Ru91+3sqmcLUI4xyzR/lkD/zc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwgbDfz5tdKxadCvhkM7G/FTQp0qacxNpxor4lRNBt9W8TD3B3TEOMYHunkx1ar32
	 6HqC6Yo+VZga/k4Oi47vZSDhhFE3AiYYjxC/oKSmyVm7AmfnGlx1qMAClbf3+kC42O
	 z5HtoH3njSMpP8lJX7iE6lQw6ssIR+B8vejOCIWE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40279F80152;
	Tue,  2 Feb 2021 15:43:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B885F800E1; Tue,  2 Feb 2021 15:43:32 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1EAF4F800E1
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 15:43:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EAF4F800E1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1612277004197335005-webhooks-bot@alsa-project.org>
References: <1612277004197335005-webhooks-bot@alsa-project.org>
Subject: Hardware output loopback toggle buttons
Message-Id: <20210202144332.9B885F800E1@alsa1.perex.cz>
Date: Tue,  2 Feb 2021 15:43:32 +0100 (CET)
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

alsa-project/alsa-tools pull request #4 was opened from pfandl:

Hi, as promised in the sound/pci/rme9652 patch here are the user land changes which provide the user the ability to toggle the hardware output loopback functionality per output channel. I tried to hide the buttons for devices which do not expose the snd controls yet, but due to probably unnecessary struggle i cancelled that. Please let me know though should you want them removed for not yet enabled devices.

Request URL   : https://github.com/alsa-project/alsa-tools/pull/4
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/4.patch
Repository URL: https://github.com/alsa-project/alsa-tools
