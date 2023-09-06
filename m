Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168E4EB8FAD
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Sep 2023 09:59:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 954E8846;
	Wed,  6 Sep 2023 11:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 954E8846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693994393;
	bh=PZ47ZEPoVQqAp2yGb1CDTW8VSvGTiQhFtQPJKX7Je2w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Vyx+phRzKRPs3PdPgUsvZ0mDOuNPtaLNLPtXkrGH6GsDr7WkLbSrbqKxn6j1zM5oe
	 KLBuO6ZSg3y0eOyVD980nqAvIBRONRfKY8Mn2FnGB/N7aOA2sQThwKk7NygzbJMV0Z
	 AZToJV6ecH3HpHZsdHmVBQYheoGMyQdxlLTqHWgs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9764AF80549; Wed,  6 Sep 2023 11:58:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E476F80527;
	Wed,  6 Sep 2023 11:58:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4064F80537; Wed,  6 Sep 2023 11:54:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 37638F80494
	for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2023 11:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37638F80494
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1693994096205333471-webhooks-bot@alsa-project.org>
References: <1693994096205333471-webhooks-bot@alsa-project.org>
Subject: _dlsym_control_001 undeclared when compiling alsa-lib
Message-Id: <20230906095457.E4064F80537@alsa1.perex.cz>
Date: Wed,  6 Sep 2023 11:54:57 +0200 (CEST)
Message-ID-Hash: FOZYTU6EQFERPX6KTSSYE3VLTMWIHMXV
X-Message-ID-Hash: FOZYTU6EQFERPX6KTSSYE3VLTMWIHMXV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FOZYTU6EQFERPX6KTSSYE3VLTMWIHMXV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #350 was edited from cemkeylan:

Hello, as mentioned I'm getting the above error when compiling alsa-lib `1.2.10`. Full error below.

```
In file included from ../../include/local.h:177,
                 from control_local.h:22,
                 from control.c:188:
control.c: In function 'snd_ctl_open_conf':
../../include/global.h:98:36: warning: implicit declaration of function '__STRING' [-Wimplicit-function-declaratio]
   98 | #define SND_DLSYM_VERSION(version) __STRING(version)
      |                                    ^~~~~~~~
control.c:1541:25: note: in expansion of macro 'SND_DLSYM_VERSION'
 1541 |                         SND_DLSYM_VERSION(SND_CONTROL_DLSYM_VERSION), 1);
      |                         ^~~~~~~~~~~~~~~~~
../../include/control.h:43:41: error: '_dlsym_control_001' undeclared (first use in this function)
   43 | #define SND_CONTROL_DLSYM_VERSION       _dlsym_control_001
      |                                         ^~~~~~~~~~~~~~~~~~
../../include/global.h:98:45: note: in definition of macro 'SND_DLSYM_VERSION'
   98 | #define SND_DLSYM_VERSION(version) __STRING(version)
      |                                             ^~~~~~~
control.c:1541:43: note: in expansion of macro 'SND_CONTROL_DLSYM_VERSION'
 1541 |                         SND_DLSYM_VERSION(SND_CONTROL_DLSYM_VERSION), 1);
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
../../include/control.h:43:41: note: each undeclared identifier is reported only once for each function it appears in
   43 | #define SND_CONTROL_DLSYM_VERSION       _dlsym_control_001
      |                                         ^~~~~~~~~~~~~~~~~~
../../include/global.h:98:45: note: in definition of macro 'SND_DLSYM_VERSION'
   98 | #define SND_DLSYM_VERSION(version) __STRING(version)
      |                                             ^~~~~~~
control.c:1541:43: note: in expansion of macro 'SND_CONTROL_DLSYM_VERSION'
 1541 |                         SND_DLSYM_VERSION(SND_CONTROL_DLSYM_VERSION), 1);
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
make: *** [Makefile:415: control.lo] Error 1
```

I have tried to understand the reason this occurs. This doesn't happen when compiling version `1.2.9`, so I can't understand how and where the declaration is for that version.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/350
Repository URL: https://github.com/alsa-project/alsa-lib
