Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831FAC46CD2
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:25:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78EF0E68;
	Tue, 30 Jan 2024 14:25:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78EF0E68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706621123;
	bh=82bXq1s6neKI9hvEogi5P4PiiEQYn7dKcptB4o2TfZU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=W+A1XafbH5BF31Gq9QvFR8xFlpyMG+uqF75ZtcYoAHFnTxuMM+wd1crd6WM+eE/ZR
	 Wrn0LBuW+7GzkxkYNjg6RW+NT8t8jKlOVBW+2+4FhUiCJy5mpGCoxU7GmtrgK/8Pmf
	 GPQQdOniH4ZBQiGQ0v+2Asbzo660bKdg8P3FQ4ss=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA5D4F8057E; Tue, 30 Jan 2024 14:24:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B08CF805AB;
	Tue, 30 Jan 2024 14:24:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39094F8055C; Tue, 30 Jan 2024 14:24:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A8612F8020D
	for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2024 14:24:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8612F8020D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1706621080760969400-webhooks-bot@alsa-project.org>
References: <1706621080760969400-webhooks-bot@alsa-project.org>
Subject: Linking failure when using separate builddir
Message-Id: <20240130132445.39094F8055C@alsa1.perex.cz>
Date: Tue, 30 Jan 2024 14:24:45 +0100 (CET)
Message-ID-Hash: IU7J75HNXZ6V3LQKPFGG2XMQ5J5P5F6S
X-Message-ID-Hash: IU7J75HNXZ6V3LQKPFGG2XMQ5J5P5F6S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IU7J75HNXZ6V3LQKPFGG2XMQ5J5P5F6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #382 was opened from jpalus:

If `$(builddir)` is different than `$(srcdir)` linking of `libatopology` fails:
```
$ mkdir builddir
$ cd builddir
$ ../configure
...
$ make
...
/usr/bin/ld: cannot open linker script file Versions: No such file or directory
```

`alsa-lib 1.2.11`

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/382
Repository URL: https://github.com/alsa-project/alsa-lib
