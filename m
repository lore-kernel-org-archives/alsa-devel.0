Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5973C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 14:10:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477F0611AD
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 14:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477F0611AD
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2979B1661;
	Thu, 15 Apr 2021 16:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2979B1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618495821;
	bh=q5PfhF5TBvuXkuTtDOs+d50GpbELkxkDVj2Jqdz4ISg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oVZcGUucooQFS2BceYCypIcv0/P/ideVBj/H6gaXguISGeJXUfnEbVycTqhG5d18N
	 QB6moKuDO2riODeTIqlXrW8XfvYwrlg2UTBCylmI01uswUZgQaRyTh8Kcg2WyACb01
	 RTP5vTIkBmGRQcrgDmlTG1kGOyDXAn1bvmLMkRDc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9971FF8021D;
	Thu, 15 Apr 2021 16:09:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF0EEF80128; Thu, 15 Apr 2021 16:09:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 19563F80128
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 16:09:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19563F80128
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1618495764236035109-webhooks-bot@alsa-project.org>
References: <1618495764236035109-webhooks-bot@alsa-project.org>
Subject: SOF SoundWire: Improve dmic detection
Message-Id: <20210415140927.BF0EEF80128@alsa1.perex.cz>
Date: Thu, 15 Apr 2021 16:09:27 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #75 was edited from plbossart:

DMIC support seems incomplete for HDaudio (not handling all possibilities for cfg-dmics) and missing completely for SoundWire.

This is an untested draft just to get UCM3 feedback from @perexg and tests from @aigilea on an HP Spectre x360 device.

Edit: adding @kv2019i @RanderWang @bardliao and @libinyang for reviews.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/75
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/75.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
