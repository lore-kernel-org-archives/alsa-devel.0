Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDCC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:51:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0B72242C
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kY+IH4p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0B72242C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95CEC1704;
	Tue, 20 Oct 2020 01:50:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95CEC1704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603151487;
	bh=yx9nOctFFFm1dMN27KMlOUBsUNbY6vnza5PuYV06bVQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kY+IH4p5j+ZQf3Ael+sctepsJs/1IYPuuzsWAwCPkIG2UNfXuXjobEyY/bl1tmeoD
	 E/0SVQNr2bbQ+zpgh+9NBr4tuE9ATAkA1xJ8SmIM7psuBKXs6X/taiRtgyzPtmh4/J
	 uWczcLJuebx5Wbm8qrDlGTVCKy3mRUPnMwPmN35A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24A4AF801D5;
	Tue, 20 Oct 2020 01:50:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAC7DF80247; Tue, 20 Oct 2020 01:50:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E8457F801A3
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2020 01:50:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8457F801A3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603151427982718945-webhooks-bot@alsa-project.org>
References: <1603151427982718945-webhooks-bot@alsa-project.org>
Subject: ASoC: error at snd_soc_pcm_dai_trigger on acp_rn_pdm_dma.0
Message-Id: <20201019235034.EAC7DF80247@alsa1.perex.cz>
Date: Tue, 20 Oct 2020 01:50:34 +0200 (CEST)
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

alsa-project/alsa-lib issue #88 was opened from JcdeA:

I am on Artix and this has been an issue for a while. Pauvcontrol shows Dummy Output as the only output available.

https://www.reddit.com/r/archlinux/comments/e73u68/dummy_audio_output_after_update/  
I saw this post and downgraded alsa-lib-1.2.4 to alsa-lib-1.2.3 and it works perfectly now. 

 I tried all of the solutions on the fourms, but none worked except downgrading. Seems like a issue with the latest version.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/88
Repository URL: https://github.com/alsa-project/alsa-lib
