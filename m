Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D8C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 13:35:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7215E23A80
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7215E23A80
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D735B177E;
	Fri, 18 Dec 2020 14:34:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D735B177E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608298532;
	bh=xQGTbknmsZocTInP4eAQ+C1dob+lgAar1JuBFuCFhNM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQVBg+QgImqq+QTuV3BdnWzfyZg1/QHVz1HrB1AvaVP1rk8w6IZPP00lo6vXWvKpE
	 6e4/EgJrjsalQjZUY4UlBTT9Mr75ky5ROB+zGWOgzbGlfm2Falrz25glh5Bip3CYI0
	 1RMXHPjc24PlRdeABZXWKjAUon4aYf8tkkYJoCrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F45F80103;
	Fri, 18 Dec 2020 14:34:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3DDBF801F7; Fri, 18 Dec 2020 14:34:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3DF98F80103
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 14:34:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DF98F80103
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1608298475372586966-webhooks-bot@alsa-project.org>
References: <1608298475372586966-webhooks-bot@alsa-project.org>
Subject: Move SDM845 out of Qualcomm folder and add C360
Message-Id: <20201218133440.F3DDBF801F7@alsa1.perex.cz>
Date: Fri, 18 Dec 2020 14:34:40 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #70 was opened from Srinivas-Kandagatla:

With driver_name fix in sdm845 machine driver  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.10&id=3f48b6eba15ea342ef4cb420b580f5ed6605669f 
/proc/asound/cards get populated correctly with proper driver name and card long name. With this in place we should be able to rearrange sdm845 directory to be inline with others and reuse some of the common code.
Without this all the sdm845 based machines will get a generic ucm description which will not work, one of such instance is Lenovo C360 Laptop. This patchset also add support to Lenovo C360 support

Thanks,
srini

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/70
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/70.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
