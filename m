Return-Path: <SRS0=iGAb=EV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB88C2D0E4
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 14:09:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC96B22447
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZS7rVc38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC96B22447
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35FFB17AF;
	Sun, 15 Nov 2020 15:08:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35FFB17AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605449380;
	bh=tFpR8PuLgzpgwpPNI9acQLKyYEN1jB7WehjNpm0POas=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZS7rVc38AnO+Hte8r0rS6pPYBvbwyyQStczWc3rmsjNkGZYxtI4/sa3Qv0wCbRnAT
	 zWTRV7M/uccr666joLdE5EYinxlAnsX2HGCaDsTZmpZPW4xehkzcZszjOfd7gidUAu
	 t9BI+z2NdHwjfZJOF8P91prdwQm1waOKRopGaZSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B83C8F801ED;
	Sun, 15 Nov 2020 15:08:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68F63F801F5; Sun, 15 Nov 2020 15:08:48 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E86D4F8010A
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2020 15:08:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E86D4F8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605449319037471056-webhooks-bot@alsa-project.org>
References: <1605449319037471056-webhooks-bot@alsa-project.org>
Subject: [PATCH 0/9] alsa-gobject: hwdep: enhancement for error reporting
Message-Id: <20201115140848.68F63F801F5@alsa1.perex.cz>
Date: Sun, 15 Nov 2020 15:08:48 +0100 (CET)
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

alsa-project/alsa-gobject pull request #51 was opened from takaswie:

The patchset is the part of work about #47.

Current implementation uses library-wide error domain to report error. this
is partly against rule of GError usage. Furthermore, the error delivers
information just about errno and hard to know the cause of error.

This patchset enhances error reporting. The library-wide error domain is
obsoleted. ALSAHwdep library is small and includes global functions.
GFileError is used for the functions to report error since It has no
specific error domain in current design.

```
Takashi Sakamoto (9):
  seq: query: remove duplicated semicolon
  ctl: query: simplify count check
  timer: instance_param: simplify count check
  hwdep: skip check of return value from g_malloc()
  hwdep: check whether method argument for GError is available
  hwdep: add checks for method arguments
  hwdep: query: simplify count check
  hwdep: query: use GFileError to report error
  hwdep; obsolete library-wide GQuark for error reporting

 src/ctl/query.c             |   9 ++--
 src/hwdep/privates.h        |   6 ---
 src/hwdep/query.c           | 101 ++++++++++++++++--------------------
 src/seq/query.c             |   2 +-
 src/timer/instance-params.c |   5 +-
 5 files changed, 50 insertions(+), 73 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/51
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/51.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
