Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75AC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 19:20:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F94613C4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 19:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F94613C4
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7838416A5;
	Tue, 13 Apr 2021 21:19:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7838416A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618341599;
	bh=hQM8XXzE1T+nTIYzMuzATZZDK4CJWOZfpcsUaK9hyPY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFE61E4QuGAbBJc3bLr7fBo7+CPXoOt2Hx1fpluY0c8tel432RjXgmT1c44ikg31+
	 MrfEiNu78XE4+eh7gGsT7HmP9lCTKB1alXNS+JcweWQVN8eDeU2VyfZ+na1Jxeuv+Z
	 o/jCChr6yE/0YA4j2EKMEjGMYRT38qU5LRsfcQFY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6A07F8021D;
	Tue, 13 Apr 2021 21:19:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9586CF8022B; Tue, 13 Apr 2021 21:19:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A571F80161
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 21:19:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A571F80161
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1618341542476771116-webhooks-bot@alsa-project.org>
References: <1618341542476771116-webhooks-bot@alsa-project.org>
Subject: utils/alsa.m4: fix the brackets for real
Message-Id: <20210413191906.9586CF8022B@alsa1.perex.cz>
Date: Tue, 13 Apr 2021 21:19:06 +0200 (CEST)
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

alsa-project/alsa-lib pull request #133 was opened from asavah:

Even after https://github.com/alsa-project/alsa-lib/commit/f9ace404fde9058baf64d77eed98d755a6c11fa4 building alsa-utils from git fails due to broken alsa.m4.

```
autoreconf: running: aclocal -I m4 --force -I m4
/home/asavah/kross/host/bin/m4:/home/asavah/kross/build/asusb450eg/rootfs/usr/share/aclocal/alsa.m4:20: ERROR: end of file in string
autom4te2.71: error: /home/asavah/kross/host/bin/m4 failed with exit status: 1
aclocal: error: /home/asavah/kross/host/bin/autom4te2.71 failed with exit status: 1
autoreconf: error: aclocal failed with exit status: 1
```

This PR should address missing brackets.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/133
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/133.patch
Repository URL: https://github.com/alsa-project/alsa-lib
