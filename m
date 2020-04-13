Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC800C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:27:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BA320692
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sGoOpS9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA320692
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D862816A2;
	Mon, 13 Apr 2020 18:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D862816A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586795238;
	bh=ZtSw/ynOZlGCFCEBSdGGsERaRW2z/mdeXGM18Qw7qq0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGoOpS9ghCnr1hD42MP8R+aLIu9JRL0+aIxrGI8kxj3+SWoNoJ6hAHcpPAwoBG8uM
	 8pwzYi1223sBSs7FhzRscy3t2UWNkvnqx2bbPe2wenZtLW8It6E8VLwkg4N1mt/LQL
	 uyGvkea/Qqzbo2sPYmBUJgfMyzB+oQe+JRmS+5VU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87E69F80264;
	Mon, 13 Apr 2020 18:26:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E7C9F80266; Mon, 13 Apr 2020 18:25:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id ADEB9F8025F
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 18:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADEB9F8025F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1586795156453360081-webhooks-bot@alsa-project.org>
References: <1586795156453360081-webhooks-bot@alsa-project.org>
Subject: SOF support for Baytrail/CherryTrail
Message-Id: <20200413162559.3E7C9F80266@alsa1.perex.cz>
Date: Mon, 13 Apr 2020 18:25:59 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #20 was edited from plbossart:

Add symlink and simple test to reuse legacy settings as is.

tested on Baytrail/Asus T100TA only with SOF and legacy drivers, all other platforms are just based on same changes.

sof-bytcr-rt5640 is here:
 http://alsa-project.org/db/?f=6f8be0520e2bbda94cb744ce66232174feec03d4

UCM validator seems to have problems with the conditional statement?

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/20
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/20.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
