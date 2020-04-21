Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA320C54FD0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:18:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C772206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i8qc/0/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C772206D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7A8E167F;
	Tue, 21 Apr 2020 13:17:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7A8E167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587467914;
	bh=reuHpvU5C8p1ABHi7V1ZEz585x9wE1J0QwZoTFDKtZc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i8qc/0/4X2HF1r+EakupJifRj05Z94lUVAFb1NQ5Pch7ji+dTwZEIacKpd6IAZ1I7
	 nfC7YDa9cyRxYFC5RV44d7+jiSrEU830xmKMhYnDTRqcEWsnIXwSymjLB3uXbnFuPa
	 oosdaodhjMcKZscpUMtmVK9IZjxNjp3CLmABiGiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D819F80143;
	Tue, 21 Apr 2020 13:17:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4742F801EC; Tue, 21 Apr 2020 13:17:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CB8A4F800E7
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 13:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB8A4F800E7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1587467852976934910-webhooks-bot@alsa-project.org>
References: <1587467852976934910-webhooks-bot@alsa-project.org>
Subject: Add support to SDM845 based platforms
Message-Id: <20200421111741.D4742F801EC@alsa1.perex.cz>
Date: Tue, 21 Apr 2020 13:17:41 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #22 was opened from Srinivas-Kandagatla:

Add Support to two codecs WCD934x and WSA881x and two platforms DragonBoard DB845c and Lenovo-YOGA-C630-13Q50 that use this codec.
For ucm-validator to pass this PR depends on config files PR "ucm-validator: add config files for DB845c and Lenovo-YOGA-C630-13Q50" to alsa-tests

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/22
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/22.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
