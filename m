Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EA1C5DF7D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:48:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25E8660298;
	Fri, 21 Aug 2026 11:48:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25E8660298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787305716;
	bh=B00oAKE4TF7RwXbtahbaJTzL/B3d2jNTfYpR7Dsmd8U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZaS3tG+Xp7Qdk9cJUxdGdrZdZmtZp0FwAGG672Kk21ow3lfouWuaG00+P741+pojT
	 UgYMTdGR45sLUE+9Lc4kS4FPo+NZ09xqHdusRbFsIlizBQeYgSD1P44qsxEh6MQagm
	 3Q+J8M9LkBCCWZ9cOS2CK0lWYC4PC/0xTzJ4XZOo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EF1DF805F1; Fri, 21 Aug 2026 11:48:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 69236F805FC;
	Fri, 21 Aug 2026 11:48:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69156F8051D; Fri, 21 Aug 2026 11:47:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787305674;
	b=CXMSaXGv6WnZEuXboQcD31Y1pkAZxsKTqwV/0aF9vq+aRO3ix0jRD56Ge+RRuLAyw0w2
	 knPhwFq/TagiD/YFY2oSYre5z38k1t5Fah1iMfObhLHTOS6OG6jAwNka0enp3oO5XI7qx
	 xNixIKvQatpItm3T/UTut94mP+HchRU9zmLK7NmkJ2FBgXfGVvCeEXIVxTRVI+bE/8L7d
	 emnvf1AD2pEVOW+kkeonUW5mhMkrCmPp4rdxqYuS8Dwkxrv9TLuTejPTlw/BxJE3ceBey
	 Pc4GUhRw0Qnyu0aKjqXl+aQB+9ptQdz5Tx0AcqquOH7QNBwBknDbwLZlYTeotzqkVow==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787305674;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=B00oAKE4TF7RwXbtahbaJTzL/B3d2jNTfYpR7Dsmd8U=;
	b=J4LWrc19wRjPCI0LG6Vx+lw52A3m0Ou14tma1ox6eK26lpw9cw3X8UV0P3SAJSrL+UA9
	 L4jwffpb7QoSnk54dfVfmk7rLJlvfKKk/U8mwxhs40zVImOEVqqDccyZZA5oenlngciQ2
	 mXY5cyqZZwfs1dv31IHdKAR33CuDwwymI5VKPs1gFevhhEwUTZPlejCcVgdrXxpmlsYGI
	 zS3qn1NgwpXKsOJiV2MiPufruXGGMy84Zqwh6b+CZobkpgNGpeTmKJHs3lyKQWN+XwULA
	 CDhNKUcJy9MDLKwXBsA0Yk+Ux+xDYRwYz5qzxqxz37Ge3n//iPw3YGorSo6B/24vJRg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 55939F80246
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2026 11:47:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55939F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cdc90a3355f300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/521@alsa-project.org>
References: <alsa-project/alsa-lib/pr/521@alsa-project.org>
Subject: pcm_file: retry write(2) on short writes in safe_write()
Date: Fri, 21 Aug 2026 11:47:55 +0200 (CEST)
Message-ID-Hash: OE5J2LGT57DTQD7YWDSY24X6YMO4ECCT
X-Message-ID-Hash: OE5J2LGT57DTQD7YWDSY24X6YMO4ECCT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OE5J2LGT57DTQD7YWDSY24X6YMO4ECCT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #521 was opened from Krishnanand-G:

Fixes #63.

The file plugin drops audio when its output is a FIFO but not when it's a regular file. Looking through pcm_file.c, safe_write() only retries write(2) when it returns -1/EINTR. On a pipe, a blocking write that's interrupted by a signal after part of the buffer already went through returns the partial byte count instead, not -1. safe_write() passed that short count straight back, and snd_pcm_file_write_bytes() treats "wrote less than requested" as a reason to stop and return success, so the rest of that period's samples never made it out.

That also matches why regular files never showed the bug: a write to a file rarely blocks long enough for a signal to land mid-syscall, while a write to a FIFO sits blocked waiting on a reader constantly.

The fix is small: make safe_write() keep writing until the whole buffer is out or a real error comes back, instead of stopping on the first partial write.

I wrote a small standalone repro outside the tree (pipe with a small buffer + slow reader + SIGALRM firing during the write) to confirm the mechanism before touching pcm_file.c. With the old loop the writer reliably loses most of a 512KB buffer (~12KB gets through per run); with the retry loop all 512KB gets through every time despite the same interruptions. Also ran a full `./configure && make` of the library to confirm it still builds clean.

I didn't have a real FIFO consumer / hardware set up to exercise this through actual aplay/arecord, so if anyone hitting #63 wants to try this against their original setup, that would help confirm it end to end.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/521
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/521.patch
Repository URL: https://github.com/alsa-project/alsa-lib
