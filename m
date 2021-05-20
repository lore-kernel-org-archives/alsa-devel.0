Return-Path: <SRS0=8dQ6=KP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A0C433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 20 May 2021 21:45:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9336F6135C
	for <alsa-devel@archiver.kernel.org>; Thu, 20 May 2021 21:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9336F6135C
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6407316AE;
	Thu, 20 May 2021 23:44:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6407316AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621547114;
	bh=S8RxCy9+2GZqhvuoC5xp/6j+XqNo78Z2oaDUSOP8hEU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZpOmZ6YOopDxIX4zCY5D+EPZOYwRGq2MzfnpIYOJWWMzTKpZ2e3wR7TvsaU4h4xrh
	 rKRIFvF18wKR4o1H+H6PEE6IZoF6rHbU1SVHP5V/2iC7H194iaANBhi/7qBYY2fuTV
	 nomfauPrQSwm0YUtY6ZQideCJANiboeYP/YWx2jk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1A83F8020B;
	Thu, 20 May 2021 23:44:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28E81F80217; Thu, 20 May 2021 23:44:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D5416F800C1
 for <alsa-devel@alsa-project.org>; Thu, 20 May 2021 23:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5416F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1621547055768846035-webhooks-bot@alsa-project.org>
References: <1621547055768846035-webhooks-bot@alsa-project.org>
Subject: Broken out-of-tree build
Message-Id: <20210520214422.28E81F80217@alsa1.perex.cz>
Date: Thu, 20 May 2021 23:44:22 +0200 (CEST)
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

alsa-project/alsa-lib issue #136 was opened from concatime:

Hi.
Due to missing headers, I cannot build alsa-lib if the build directory is outside of the source tree.
```
make[2]: Entering directory '/home/iemaghni/Code/tmp/build/src/ucm'
  CC       utils.lo
In file included from ../../../alsa-lib/src/ucm/ucm_local.h:41,
                 from ../../../alsa-lib/src/ucm/utils.c:33:
../../../alsa-lib/include/use-case.h:45:10: fatal error: alsa/asoundlib.h: No such file or directory
   45 | #include <alsa/asoundlib.h>
      |          ^~~~~~~~~~~~~~~~~~
```
Step to reproduce:
```sh
git clone https://github.com/alsa-project/alsa-lib.git
mkdir build
cd alsa-lib
libtoolize --force --copy --automake
aclocal
autoheader
automake --foreign --copy --add-missing
autoconf
cd ../build
../alsa-lib/configure
make
```
Thank you!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/136
Repository URL: https://github.com/alsa-project/alsa-lib
