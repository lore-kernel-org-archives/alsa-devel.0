Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C5CC52D7C
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Aug 2024 19:13:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2435B826;
	Wed, 21 Aug 2024 21:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2435B826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724267579;
	bh=SxWEWx4TinLZrxno5ALgxrwD74WG09ZwCxUcPqSBUc8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TYL+9fLLrgcbdh6lSJNxwCw8d7r67QAgsDnyLzKC18+oLQduioBStKCtxihNmV57A
	 3apurTXhc2wTd2U8ZEOnCT9gUN+4vrZb5nI1Fza5TpHYLf1jTQTMakWxWulqiSbcmx
	 bzEGxrSrxOhtHs5qoAjCCyMjiLUAmlAmyNiB0Ty4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4318AF805BB; Wed, 21 Aug 2024 21:12:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B7E4F805B5;
	Wed, 21 Aug 2024 21:12:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC015F80496; Wed, 21 Aug 2024 21:12:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id BE62EF800F0
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 21:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE62EF800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1724267534578495026-webhooks-bot@alsa-project.org>
References: <1724267534578495026-webhooks-bot@alsa-project.org>
Subject: No sound from XonarDX
Message-Id: <20240821191219.BC015F80496@alsa1.perex.cz>
Date: Wed, 21 Aug 2024 21:12:19 +0200 (CEST)
Message-ID-Hash: X4L37PMRDRUGPUSIJCOU47CO2VPLHEXV
X-Message-ID-Hash: X4L37PMRDRUGPUSIJCOU47CO2VPLHEXV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X4L37PMRDRUGPUSIJCOU47CO2VPLHEXV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #408 was opened from 3bitbrain:

No matter what wiki or advice I try, no sound at all from a known good Xonar DX card.
Distro : Gentoo, fresh install.
Always un-muted everything in the console alsamixer.

alsa-lib version 1.2.11

[alsa.txt](https://github.com/user-attachments/files/16697602/alsa.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/408
Repository URL: https://github.com/alsa-project/alsa-lib
