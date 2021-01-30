Return-Path: <SRS0=4A4t=HB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEAFC433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 12:08:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E372464DDC
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 12:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E372464DDC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 742681657;
	Sat, 30 Jan 2021 13:07:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 742681657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612008493;
	bh=ntooOsHYR/ef4kQtwA5PW555c4Eh+jx1jewxpz0mxJk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajIR4j4XJkj0gyh33gnYBIg1tGuyfBsHr4UDuPMdC7VpCssFu1xE0s5PZG5oBz7nN
	 CLFfoyGC80MmK0eyeDHCUEpMzbafwx8yTOaqXo4Fo2qs1bsau38290SUz9R5YqIF0u
	 mQmdgbX2/mSqbAaTOOH7udwr0/7sSm+1lxFwysNU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1A26F80158;
	Sat, 30 Jan 2021 13:07:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6F3AF8015B; Sat, 30 Jan 2021 13:07:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 591DBF800BE
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2021 13:07:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 591DBF800BE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1612008436778192997-webhooks-bot@alsa-project.org>
References: <1612008436778192997-webhooks-bot@alsa-project.org>
Subject: Extend card search paths
Message-Id: <20210130120720.A6F3AF8015B@alsa1.perex.cz>
Date: Sat, 30 Jan 2021 13:07:20 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #76 was opened from lumag:

On Qualcomm platforms is is typical for a single kernel module to support several sound cards. Add support for using `ucm2/module/${KernelModule}/${CardLongName}.conf` as a use case config file.

See https://github.com/alsa-project/alsa-ucm-conf/pull/70 for the reference.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/76
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/76.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
