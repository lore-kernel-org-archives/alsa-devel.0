Return-Path: <SRS0=08+G=M7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8CEC4338F
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Aug 2021 17:26:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0255060EE7
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Aug 2021 17:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0255060EE7
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1C731661;
	Sun,  8 Aug 2021 19:25:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1C731661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628443563;
	bh=WtWyowJ6QssC1JRzO09YtP61HrwFbm3mKIpkjYJPuY0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=srr1FUoIhjJgTvmoKN3X2YlFnrmdCXGBKS03MjhBn8DKotObTVQOn1DOhkfjeUvD1
	 sjA4V+yIgwALfNgYahx5yy9BbPHxdx/BqCt1U+lMzn/9UqtKCJxEFR+ENISqte+Dd4
	 5td4BaHtAT/KNAnCxRsAcpcLqde1dVXsaZijToGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57797F80279;
	Sun,  8 Aug 2021 19:24:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59D97F802A0; Sun,  8 Aug 2021 19:24:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 17654F80245
 for <alsa-devel@alsa-project.org>; Sun,  8 Aug 2021 19:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17654F80245
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1628443463847054958-webhooks-bot@alsa-project.org>
References: <1628443463847054958-webhooks-bot@alsa-project.org>
Subject: undefined reference to `_snd_module_control_empty'
Message-Id: <20210808172431.59D97F802A0@alsa1.perex.cz>
Date: Sun,  8 Aug 2021 19:24:31 +0200 (CEST)
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

alsa-project/alsa-lib issue #168 was edited from madebr:

When linking `aserver` of libalsa 1.2.5.1,
the following linking error appears:
```
/usr/bin/ld: ../src/.libs/libasound.a(control_symbols.o):(.data.rel+0x8): undefined reference to `_snd_module_control_empty'
collect2: error: ld returned 1 exit status
```

libalsa is built as a static library.

Full log:
[libalsa.log](https://github.com/alsa-project/alsa-lib/files/6951192/libalsa.log)
(this is using the conan build recipe at https://github.com/conan-io/conan-center-index/tree/master/recipes/libalsa/all)

Thanks

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/168
Repository URL: https://github.com/alsa-project/alsa-lib
