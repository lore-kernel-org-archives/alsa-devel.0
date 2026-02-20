Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3465C5518F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Feb 2026 11:40:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D41856021D;
	Fri, 20 Feb 2026 12:40:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D41856021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771587608;
	bh=s9Pm6o86b3AByAF9BmIpLlHSi8OSzaPy+nNW1wwy0ds=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CLelheu7753+zYITDqF+evXK4beryJXu52uDOBeJRa7ZCqVW4YsbLM7HrWDj6O3Yt
	 OZQdAfdTmE+4fIDhdMq1on9raOjTyqPngghiIpmYxfOkx9S5nDH6WuxskNfcHi901w
	 Cz0LfeFF+KCDDkc3Jx39LJ5CWddaGWCEnagHjw0Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82C97F805DF; Fri, 20 Feb 2026 12:39:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C95CF805EB;
	Fri, 20 Feb 2026 12:39:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEC75F8026A; Fri, 20 Feb 2026 12:38:52 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1285DF800F3
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2026 12:38:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1285DF800F3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1895f1766c757300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/496@alsa-project.org>
References: <alsa-project/alsa-lib/pr/496@alsa-project.org>
Subject: fix discards const from pointer target
Date: Fri, 20 Feb 2026 12:38:52 +0100 (CET)
Message-ID-Hash: 3V2BB3CVY5TNPITFXUCJ75W2P6EJOOO4
X-Message-ID-Hash: 3V2BB3CVY5TNPITFXUCJ75W2P6EJOOO4
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3V2BB3CVY5TNPITFXUCJ75W2P6EJOOO4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #496 was opened from heitbaum:

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr, strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers into their input arrays now have definitions as macros that return a pointer to a const-qualified type when the input argument is a pointer to a const-qualified type.

https://lists.gnu.org/archive/html/info-gnu/2026-01/msg00005.html

fixes:
```c

../../../src/seq/seqmid.c: In function 'snd_seq_parse_address':
../../../src/seq/seqmid.c:449:24: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  449 |                 if ((p = strpbrk(arg, ":.")) != NULL) {
      |                        ^
../../../src/ucm/main.c: In function 'snd_use_case_get_list':
../../../src/ucm/main.c:2396:22: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 2396 |                 str1 = strchr(identifier, '/');
      |                      ^
../../../src/ucm/main.c: In function 'snd_use_case_geti':
../../../src/ucm/main.c:2721:22: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 2721 |                 str1 = strchr(identifier, '/');
      |                      ^
../../../src/ucm/main.c: In function 'snd_use_case_set':
../../../src/ucm/main.c:3038:22: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 3038 |                 str1 = strchr(identifier, '/');
      |                      ^
../../../src/ucm/ucm_subs.c: In function 'strchr_with_escape':
../../../src/ucm/ucm_subs.c:832:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  832 |                 s = strchr(str, c);
      |                   ^
../../src/conf.c: In function 'snd_config_hook_load_for_all_cards':
../../src/conf.c:4446:51: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 4446 |                                         char *s = strchr(driver, '.');
      |                                                   ^~~~~~

```

Request URL   : https://github.com/alsa-project/alsa-lib/pull/496
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/496.patch
Repository URL: https://github.com/alsa-project/alsa-lib
