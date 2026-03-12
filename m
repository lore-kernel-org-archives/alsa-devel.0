Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217AD106ACE4
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:38:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D28116021B;
	Thu, 12 Mar 2026 21:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D28116021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773347902;
	bh=kupP2v3VBKO+6DHE3enK3/NpCqzEnC4b+SbEYKT/mr8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=H2HbHqo805hTZY/x5ZzMPh13rqnqbC39kV5OevH8C5CdhRYptbHoaH9LqiN/P3Lmd
	 ZgDKubRzo7dbE59j6Pygq5K+bKWN0ACkd5Jjyh4Zlrp5KEv86Dzz0OUplIdtIbKGQR
	 ox/4huA/NdAf7lQau/v9jd0r21eLqFBEGOkSeeD0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B51BCF805F8; Thu, 12 Mar 2026 21:37:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EBE94F805EA;
	Thu, 12 Mar 2026 21:37:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2176F8045D; Thu, 12 Mar 2026 21:37:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AFDCF80095
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2026 21:37:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AFDCF80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189c327b570b8b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-python/pr/19@alsa-project.org>
References: <alsa-project/alsa-python/pr/19@alsa-project.org>
Subject: don't decref borrowed references
Date: Thu, 12 Mar 2026 21:37:41 +0100 (CET)
Message-ID-Hash: PTTXOD4VFR5FHPGN5WS2AJWURTEFL6A7
X-Message-ID-Hash: PTTXOD4VFR5FHPGN5WS2AJWURTEFL6A7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PTTXOD4VFR5FHPGN5WS2AJWURTEFL6A7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-python pull request #19 was opened from florolf:

This has always been wrong, but since Python 3.14 restructured some memory management code in https://github.com/python/cpython/commit/5716cc352940a5f8557a8191e873837aa619498a, this now causes Python to segfault:

```shell-session
$ cat a.py
from pyalsa import alsamixer

m=alsamixer.Mixer()
m.attach()
m.load()
e=alsamixer.Element(m, 'Master')
e.set_volume_tuple([0,0])
$
$ for i in $(seq 1 100); do python -Xfaulthandler a.py || break; done
Fatal Python error: Segmentation fault

Current thread 0x00007f01f2854b80 [python] (most recent call first):
  Garbage-collecting
  <no Python frame>

Current thread's C stack trace (most recent call first):
  Binary file "/usr/lib/libpython3.14.so.1.0", at _Py_DumpStack+0x4d [0x7f01f233731c]
  Binary file "/usr/lib/libpython3.14.so.1.0", at +0x13c250 [0x7f01f233c250]
  Binary file "/usr/lib/libc.so.6", at +0x3e2d0 [0x7f01f204d2d0]
  Binary file "/usr/lib/libpython3.14.so.1.0", at +0x21960d [0x7f01f241960d]
  Binary file "/usr/lib/libpython3.14.so.1.0", at +0x219187 [0x7f01f2419187]
  Binary file "/usr/lib/libpython3.14.so.1.0", at +0x26bf38 [0x7f01f246bf38]
  Binary file "/usr/lib/libpython3.14.so.1.0", at +0x28ff64 [0x7f01f248ff64]
  Binary file "/usr/lib/libpython3.14.so.1.0", at Py_RunMain+0x37a [0x7f01f245e59a]
  Binary file "/usr/lib/libpython3.14.so.1.0", at Py_BytesMain+0x3b [0x7f01f2457c6b]
  Binary file "/usr/lib/libc.so.6", at +0x276c1 [0x7f01f20366c1]
  Binary file "/usr/lib/libc.so.6", at __libc_start_main+0x89 [0x7f01f20367f9]
  Binary file "python", at _start+0x25 [0x55f22cd3e045]

Extension modules: pyalsa.alsamixer (total: 1)
```

This PR fixes all instances of this behavior in the code base.

Request URL   : https://github.com/alsa-project/alsa-python/pull/19
Patch URL     : https://github.com/alsa-project/alsa-python/pull/19.patch
Repository URL: https://github.com/alsa-project/alsa-python
