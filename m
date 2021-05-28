Return-Path: <SRS0=FleP=KX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB08C47087
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 11:34:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7572B613D4
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 11:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572B613D4
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0E1916D6;
	Fri, 28 May 2021 13:33:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0E1916D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622201643;
	bh=mEoMPZTj64xlsPOXjgfGW88XVVaPvL41kUbuFCPi7NM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pygTRGOpWKE0ea4qGD2MJMOA8Q62TUesRHskXm3wxx6e0ngc77UvJ85mOltkt3Wfy
	 cQb71PGMAGRQ4qPGzdtH05zMId7aRSBPCTJwfIPbBVCYVFE7kv1ZzoXnj4MVzPcWor
	 EV6xByEzwkkxcv0jxLYJcTDcgjlTHilB7fU3a9Uk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27468F804AB;
	Fri, 28 May 2021 13:33:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECB28F804AC; Fri, 28 May 2021 13:33:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5C2C7F804A9
 for <alsa-devel@alsa-project.org>; Fri, 28 May 2021 13:33:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C2C7F804A9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622201583215404987-webhooks-bot@alsa-project.org>
References: <1622201583215404987-webhooks-bot@alsa-project.org>
Subject: [PATCH 0/3] alsa-gobject: misc fixes
Message-Id: <20210528113310.ECB28F804AC@alsa1.perex.cz>
Date: Fri, 28 May 2021 13:33:10 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #59 was edited from takaswie:

This patchset fixes some bugs below:

 * Ubuntu 19.10/i386 is EOL and no release is available for i386 architecture in Ubuntu project
 * Wrong command is in install section of README

```
Takashi Sakamoto (2):
  correct install section in README
  fix workflow according to EOF of i386 ubuntu distribution

 .github/workflows/build.yml | 81 +++++++++++++++++++------------------
 README.rst                  |  2 +-
 2 files changed, 42 insertions(+), 41 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/59
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/59.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
