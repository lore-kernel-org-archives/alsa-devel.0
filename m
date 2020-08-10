Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65248C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 07:05:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BA320734
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 07:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vZ7XExAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BA320734
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84C7A15F2;
	Mon, 10 Aug 2020 09:04:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84C7A15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597043099;
	bh=Mirimd+tvIUVMZpawvb5b2SzyzL84zTWV8E8ljRi0oQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZ7XExARvK8+tfKMvF9uCck7ogqnpjUQ9JhyxmDIBF7xv0Rd31+HXe+wbJpprf0/E
	 WNnerigJ1HpOzMP0OtO2HS8wl1en+1+k5OHkHutFqio8XcKwgupn8NNYLpIxhRuf1D
	 DU2ZEGRD3MQmOhK6RefX3jcfMaqJcwJCYM5FvwDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17DE6F801DB;
	Mon, 10 Aug 2020 09:04:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0062BF8022B; Mon, 10 Aug 2020 09:04:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 77564F800BC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 09:04:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77564F800BC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1597043044215922117-webhooks-bot@alsa-project.org>
References: <1597043044215922117-webhooks-bot@alsa-project.org>
Subject: Accidently deleted alsa folder
Message-Id: <20200810070408.0062BF8022B@alsa1.perex.cz>
Date: Mon, 10 Aug 2020 09:04:07 +0200 (CEST)
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

alsa-project/alsa-lib issue #77 was opened from themagicalmammal:

I deleted alsa folder accidently and not mic doesnt work.
Even after using alsa command.
I searched and tried to apply many stack-overflow solutions but nothing helped when I try to use mic on pycharm it doesnt work it yields this error

```
ALSA lib conf.c:3916:(snd_config_update_r) Cannot access file /usr/share/alsa/alsa.conf
ALSA lib control.c:1373:(snd_ctl_open_noupdate) Invalid CTL hw:0
python3.6: src/hostapi/alsa/pa_linux_alsa.c:1454: BuildDeviceList: Assertion `devIdx < numDeviceNames' failed.
```

While External recorder works

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/77
Repository URL: https://github.com/alsa-project/alsa-lib
