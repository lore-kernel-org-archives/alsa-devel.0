Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF3EC6FD18
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Mar 2023 21:53:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8D491F0;
	Wed, 29 Mar 2023 23:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8D491F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680126802;
	bh=0/w2nTHfudeBdNQW+rFGrDVYni/MRhAdMUenjEvtJC4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gGVpP1jFLScpsZ3sXK+ijc01EVYFPydujkAOKafxiHrJ+LrmBskvuDOFpzrbu/1h1
	 NwCxWrOxNjOuL+C9Fw/tR8mUZLbKNKOkwYrugkapTgY3/Xlf6ORngwu9T/EVHNR2fw
	 WLWSCi4SnL7/i8O4eUs/uI6iy9G9VjBAFADEBWVg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C317F80423;
	Wed, 29 Mar 2023 23:45:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FBE4F80423; Wed, 29 Mar 2023 23:45:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 286A0F8024E
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2023 23:45:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 286A0F8024E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1680126326643504143-webhooks-bot@alsa-project.org>
References: <1680126326643504143-webhooks-bot@alsa-project.org>
Subject: Does this compile any code?
Message-Id: <20230329214530.8FBE4F80423@alsa1.perex.cz>
Date: Wed, 29 Mar 2023 23:45:30 +0200 (CEST)
Message-ID-Hash: 7GQGVHIUZPBF2NZJTO4YPUGA63UXLNPJ
X-Message-ID-Hash: 7GQGVHIUZPBF2NZJTO4YPUGA63UXLNPJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7GQGVHIUZPBF2NZJTO4YPUGA63UXLNPJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #309 was opened from stefan11111:

If I build the same kernel twice, I get this output when building it the second time:
```
# make
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
Kernel: arch/x86/boot/bzImage is ready  (#17)
```
If I build the kernel again, only changing SND_X86, I get this output:
```
# make
  SYNC    include/config/auto.conf
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
Kernel: arch/x86/boot/bzImage is ready  (#17)

```
It doesn't look like that option compiles any code.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/309
Repository URL: https://github.com/alsa-project/alsa-lib
