Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A14C64EC4
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Mar 2023 04:52:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFBA218B1;
	Thu,  9 Mar 2023 05:51:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFBA218B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678337542;
	bh=xMpw4VuUMO7U1Zkkhq1YlSPStGXK1l5I03bIABext24=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WHIeA6d4w/MlF+uFpBVOMNsE8kkbaiudAVFDwnwXJmgQNLhUtnj+ExlBAxZYNOxNB
	 XJKHqmvco/V1BhLYYranMeyneIA9Fp+TAEaMQFVMwgg4onVyGEi/bFSZcZEXRI1U6k
	 jfizSSjkfU3v0y+g/6Ivh7+FLPbsrQM1BpcZFmo4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B919EF8042F;
	Thu,  9 Mar 2023 05:51:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0458DF8042F; Thu,  9 Mar 2023 05:50:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A9AB1F800C9
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2023 05:50:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9AB1F800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1678337444192708492-webhooks-bot@alsa-project.org>
References: <1678337444192708492-webhooks-bot@alsa-project.org>
Subject: Failing to link with lld 16,
 version script assignment of 'ALSA_0.9.5' to symbol 'alsa_lisp' failed:
 symbol not defined
Message-Id: <20230309045057.0458DF8042F@alsa1.perex.cz>
Date: Thu,  9 Mar 2023 05:50:57 +0100 (CET)
Message-ID-Hash: NGEHOIHWX52LVTMSASWTWHA65ZGYCVSD
X-Message-ID-Hash: NGEHOIHWX52LVTMSASWTWHA65ZGYCVSD
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NGEHOIHWX52LVTMSASWTWHA65ZGYCVSD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #305 was opened from listout:

lld 16 has gotten more stricter with version scripts. Using llvm 16 as my compiler produced this error.

The full build log can be found here: https://bpa.st/F6DDW

My environments:
```
CC="clang"
CXX="clang++"
AR="llvm-ar"
NM="llvm-nm"
RANLIB="llvm-ranlib"
LDFLAGS="${LDFLAGS} -fuse-ld=lld -rtlib=compiler-rt -unwindlib=libunwind -Wl,--as-needed"
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/305
Repository URL: https://github.com/alsa-project/alsa-lib
