Return-Path: <SRS0=QEGn=OO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF6C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 13:48:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF4D6105A
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 13:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BF4D6105A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D018D15F2;
	Fri, 24 Sep 2021 15:47:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D018D15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632491319;
	bh=boT82Ych7HuDrroJNMr3BeNPsJ0NtQACx+Xc59vx+xY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oeq1DjTy7ga+peLHJW9IcGb0WdT0AA4GMLZzrKbHtmUTZ1xqK7qFi/4rB0PdeKOP7
	 SAjiICZqyRZFwBU/W0Dmk+gw1bIeIpgUzfeIqJaF+Eo2yqVZ/K9eXhew2jqLcfrsn8
	 gPRIJ5q75JK1Vqj7aJnVNngYfspXJjoQWPlpfpjs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2008BF8025D;
	Fri, 24 Sep 2021 15:47:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9C7AF802A0; Fri, 24 Sep 2021 15:47:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A99CFF80246
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 15:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A99CFF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1632491252754193068-webhooks-bot@alsa-project.org>
References: <1632491252754193068-webhooks-bot@alsa-project.org>
Subject: include a sample `alsamixer.rc` file?
Message-Id: <20210924134746.E9C7AF802A0@alsa1.perex.cz>
Date: Fri, 24 Sep 2021 15:47:46 +0200 (CEST)
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

alsa-project/alsa-utils issue #112 was opened from int-e:

I think it would be useful to include an example `alsamixer.rc` file; see https://gist.github.com/int-e/25bd77d4e59531fad7d48bfaf1fc1046 for a candidate.

In particular this example replicates the default color theme, making it easier to adjust (say, replace `default` by `black` to get sane colors back in terminals with bright backgrounds). The default keybindings are also replicated but that's probably less useful.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/112
Repository URL: https://github.com/alsa-project/alsa-utils
