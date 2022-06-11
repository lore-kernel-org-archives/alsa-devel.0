Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8177EC43334
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jun 2022 16:22:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B89A317FD;
	Sat, 11 Jun 2022 18:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B89A317FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654964556;
	bh=aAJdAsA5taWS9D1G/+QaT24uCPHJLu7iEGi7Yrfyvo4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VnfVAOlscGmXuiEbrUs5Uhs3pPhk971lfO8k7gxpmBTn6Yf3ml0XA/VDerhmrDGwd
	 wh1BUguCMXsNSs+oX4QnzvyTzSZNjY8ujiIF7VipDvre67kVRx6LZVvBIGrNEbb50g
	 eywU75qrE8rbX8qksVVbFJP35UPUtuY/x2qdaLnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C839F80238;
	Sat, 11 Jun 2022 18:21:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA7FBF800E5; Sat, 11 Jun 2022 18:21:45 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7E71BF800E5
 for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2022 18:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E71BF800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1654964502936983109-webhooks-bot@alsa-project.org>
References: <1654964502936983109-webhooks-bot@alsa-project.org>
Subject: 1.2.7 aplay doesn't compile
Message-Id: <20220611162145.EA7FBF800E5@alsa1.perex.cz>
Date: Sat, 11 Jun 2022 18:21:45 +0200 (CEST)
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

alsa-project/alsa-utils issue #153 was opened from LoneFox78:

I'm getting this error:
```
Making all in aplay
make[1]: Entering directory '/mnt/pkg/pkgmk_work/alsa-utils/src/alsa-utils-1.2.7/aplay'
gcc -DHAVE_CONFIG_H -I. -I../include  -I../include   -s -Wl,-s -Wall -O2 -march=native -ftree-vectorize -pipe -MT aplay.o -MD -MP -MF .deps/aplay.Tpo -c -o aplay.o aplay.c
aplay.c:44:10: fatal error: alsa/use-case.h: No such file or directory
   44 | #include <alsa/use-case.h>
      |          ^~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:495: aplay.o] Error 1
make[1]: Leaving directory '/mnt/pkg/pkgmk_work/alsa-utils/src/alsa-utils-1.2.7/aplay'
make: *** [Makefile:461: all-recursive] Error 1
```
The configure script already looks for that header, but I guess someone forgot to add the corresponding <code>#ifdef</code>s in this file.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/153
Repository URL: https://github.com/alsa-project/alsa-utils
