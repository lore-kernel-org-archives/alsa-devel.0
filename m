Return-Path: <SRS0=laVZ=N3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587AFC433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Sep 2021 22:52:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F4660F14
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Sep 2021 22:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62F4660F14
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AFCE17C3;
	Mon,  6 Sep 2021 00:51:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AFCE17C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630882361;
	bh=D/FCYb0mmxQIwJqeg2pJlRzdb2mmtfjJlzCUkFSAWng=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LR7LMT3sY7aiO53Xm+6RKOWeIX5IXMYcFGgjr04n0KVIcBfXCbP9iSMPlrWxhCR+z
	 1cMHI3a8yYkzdSytAmteIMp9KxesWLRhdx4CGJPBCcEBdTiNJh5U7RK9ZjUKoB4LMY
	 aZYQcxLfQngQDav04mEDyjP0YNvCNtCTiLc3gW2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7516F80171;
	Mon,  6 Sep 2021 00:51:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC11EF80253; Mon,  6 Sep 2021 00:51:47 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1CDCBF800B5
 for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2021 00:51:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CDCBF800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1630882295199177980-webhooks-bot@alsa-project.org>
References: <1630882295199177980-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.5 and 1.2.5.1 fail to build with --enable-static
Message-Id: <20210905225147.DC11EF80253@alsa1.perex.cz>
Date: Mon,  6 Sep 2021 00:51:47 +0200 (CEST)
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

alsa-project/alsa-lib issue #177 was edited from pjbroad:

This build successfully:
`./configure  && make clean && make`

This fails to build:
`./configure --enable-shared=no --enable-static=yes && make clean && make`

```
make[1]: Entering directory '/home/paul/el/el-build-scripts/linux-static/libs/alsa-lib-1.2.5.1/aserver'
  CC       aserver.o
  CCLD     aserver
/usr/bin/ld: ../src/.libs/libasound.a(control_symbols.o):(.data.rel+0x8): undefined reference to `_snd_module_control_empty'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:398: aserver] Error 1
make[1]: Leaving directory '/home/paul/el/el-build-scripts/linux-static/libs/alsa-lib-1.2.5.1/aserver'
make: *** [Makefile:405: all-recursive] Error 1
```
`gcc (Ubuntu 11.2.0-3ubuntu1) 11.2.0`


Building static worked find for 1.2.4.  Hopefully someone can help resolve this.  Let me know if you want me to try anything.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/177
Repository URL: https://github.com/alsa-project/alsa-lib
