Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A09CD6E57
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:30:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4056F60237;
	Tue,  2 Jun 2026 20:30:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4056F60237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780425055;
	bh=DzxRcWHgtGDrdGOCCDCWouXhvpGeaCfrTAkqu4ANKUU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GsIQ+xdA4+txixpoHPQ7Hxi5HgkE5KHDWE7ovfF3+UOn+KWDdSiChJOQydtRFI1Rq
	 I4fvC7iQNLT5lSqkHY0AWSzWBYeT5oCZNRIIT/hVY9OuYLZXCFhSB2i7Wda9kFpYGg
	 8NLFq9qOgu1u47IWNXWwZYR64U+R/viMcey3xjE8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C8C0F805F9; Tue,  2 Jun 2026 20:30:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29A29F80510;
	Tue,  2 Jun 2026 20:30:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE4A7F80553; Tue,  2 Jun 2026 20:30:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 40225F800B0
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 20:30:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40225F800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b5571ccaa1c600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/38@alsa-project.org>
References: <alsa-project/tinycompress/pr/38@alsa-project.org>
Subject: wave: add <time.h> missing header inclusion
Date: Tue,  2 Jun 2026 20:30:10 +0200 (CEST)
Message-ID-Hash: LVG2QX73HSUNXKXTXQB6AFFQEQN6PADK
X-Message-ID-Hash: LVG2QX73HSUNXKXTXQB6AFFQEQN6PADK
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVG2QX73HSUNXKXTXQB6AFFQEQN6PADK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #38 was opened from bkuhls:

When compiling tinycompress with some libc other than glibc (e.g. musl libc), compilation fails with the following error:
```
    In file included from wave.c:11:0:
    /path/to/gcc/sysroot/usr/include/sound/asound.h:404:18: error: field 'trigger_tstamp' has incomplete type
      struct timespec trigger_tstamp; /* time when stream was started/stopped/paused */
    [...]
```
According to POSIX, "struct timespec" is defined in <time.h>. See: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/time.h.html

This patch fixes this build failure by including <time.h> prior <sound/asound.h>.

Request URL   : https://github.com/alsa-project/tinycompress/pull/38
Patch URL     : https://github.com/alsa-project/tinycompress/pull/38.patch
Repository URL: https://github.com/alsa-project/tinycompress
