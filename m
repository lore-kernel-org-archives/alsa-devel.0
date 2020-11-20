Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9068C63777
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 08:31:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9472224C
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 08:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JgxP2dnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9472224C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDF6B16F1;
	Fri, 20 Nov 2020 09:30:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDF6B16F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605861094;
	bh=CHJj/A5PWTqgqrwEMSIubqpetyVEL6A7AErVkE6qnbI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgxP2dnIOMviZG9AfbqlLhFuUWVO/60n1VcxbY2/L3zTsA5F+FDy0hx2YInEqox4m
	 I/HzWFBOEFxvAQWZElDuc5ZSCtZFk3MNfBSO1jQVhsL8dXZn/Cja5JWY1fvA/nnMlW
	 J6SgMWiXy6GqGd5wxltTTvKOGeO1roD4RBxVuss4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C481F80168;
	Fri, 20 Nov 2020 09:30:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 588EFF8016C; Fri, 20 Nov 2020 09:30:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F0A17F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 09:30:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0A17F80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605861031748018026-webhooks-bot@alsa-project.org>
References: <1605861031748018026-webhooks-bot@alsa-project.org>
Subject: [PATCH 0/4] alsa-gobject: bump project version up to v0.2.0 for new
 release
Message-Id: <20201120083042.588EFF8016C@alsa1.perex.cz>
Date: Fri, 20 Nov 2020 09:30:42 +0100 (CET)
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

alsa-project/alsa-gobject pull request #58 was opened from takaswie:

This patchset is a preparation for new release, including slight changes.

```
Takashi Sakamoto (4):
  hwdep: fix metadata and documentation for the type of interface
  upgrade CI operationg system to Ubuntu 20.04 LTS amd64
  upgrade CI operationg system to Fedora 33
  bump version up to 0.2.0 to release

 .github/workflows/build.yml      |  4 ++--
 README.rst                       |  7 ++++---
 meson.build                      |  2 +-
 src/hwdep/alsahwdep-enum-types.h | 22 +++++++++++++---------
 4 files changed, 20 insertions(+), 15 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/58
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/58.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
