Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5CC47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 05:07:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526D26128A
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 05:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526D26128A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 183C4171A;
	Thu, 10 Jun 2021 07:06:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 183C4171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623301666;
	bh=lBlDHBSFyadgC6T0DTt5blLcF7SaJXtSJqX3QL5lBOA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MuxP7qySMVJL7fPeEQhLFZEmX7tshoYNbTcrpl/svfsvvV/QPm/RmosbQZADbgWQD
	 Q2KKoGrY5/kW06X/uLeDFlQum00XWBwXQpvyqNootVrfnQoawTCDx25+PsueGbhFAU
	 2FPBV9WXYlpGUEHP4ppq6amVTCTHH9ZIkuCp1o7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 385BFF8020D;
	Thu, 10 Jun 2021 07:06:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8400F80218; Thu, 10 Jun 2021 07:06:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8650DF800FC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 07:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8650DF800FC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623301608142592907-webhooks-bot@alsa-project.org>
References: <1623301608142592907-webhooks-bot@alsa-project.org>
Subject: [Bug] Duplication in Array Element not Handled in Parsing conf
Message-Id: <20210610050652.B8400F80218@alsa1.perex.cz>
Date: Thu, 10 Jun 2021 07:06:52 +0200 (CEST)
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

alsa-project/alsa-lib issue #151 was opened from aiChaoSONG:

When parsing array element in conf files, an auto-increase number is used as config id(`snd_config_t->id`), and array element as the config value(`snd_config_t->u.string/integer/integer64/real`), duplication is not handle in `parse_array_defs/parse_array_def/parse_value` functions.

Suppose we have a conf:
```
array [
    "a"
    "b"
    "a"
]
```
the parsed result will be:
```
    parent
        |
        ---- snd_config_t {id: "0", u.string: "a"}
        |
        ---- snd_config_t {id: "1", u.string: "b"}
        |
        ---- snd_config_t {id: "2", u.string: "a"}
```
The duplication in "a" may be desired. But please consider this condition: suppose we have four conf files A, B, C and D, where A 
is the conf above, let B include A, C include A, D include B and C, so D include A twice indirectly. File A will be processed twice when parsing D, because duplication is not handled, here comes the problem, the parsed result of A in D is:
```
    parent
        |
        ---- snd_config_t {id: "0", u.string: "a"}
        |
        ---- snd_config_t {id: "1", u.string: "b"}
        |
        ---- snd_config_t {id: "2", u.string: "a"}
        |
        ---- snd_config_t {id: "3", u.string: "a"}
        |
        ---- snd_config_t {id: "4", u.string: "b"}
        |
        ---- snd_config_t {id: "5", u.string: "a"}
```
This is obviously wrong.

I think handle duplication in parse_value is not the solution, because element duplication in an array is wanted. The key problem here is that we parse the same conf more than once.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/151
Repository URL: https://github.com/alsa-project/alsa-lib
