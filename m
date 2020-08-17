Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A458C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 23:35:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1772065D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 23:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jXxJX5zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1772065D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5935E16E8;
	Tue, 18 Aug 2020 01:34:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5935E16E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597707336;
	bh=27U8aGS4dGLgS57fwvOU/S32GzirC2tLJLTgkLDMsDI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXxJX5zQOk89lGmmPvlaLuDn1foCLXt4JLs9ELhFTLzVyCb6EkOc0ODPwIyEFkDQG
	 qyWTJiCe/RPsXgxOyKCj6yWuk7X5v2MPweDyzFgH7oh4vWbkHRQ0AezLib41AHnYDC
	 49TT6jZIXrPuubno43sNG6AZcuoKWUcxW5i61KTA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E16B3F80216;
	Tue, 18 Aug 2020 01:34:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16A3CF80218; Tue, 18 Aug 2020 01:34:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 36865F800F0
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 01:34:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36865F800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1597707280009090900-webhooks-bot@alsa-project.org>
References: <1597707280009090900-webhooks-bot@alsa-project.org>
Subject: hdajackretask: Update kernel doc URL in README
Message-Id: <20200817233444.16A3CF80218@alsa1.perex.cz>
Date: Tue, 18 Aug 2020 01:34:44 +0200 (CEST)
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

alsa-project/alsa-tools pull request #2 was opened from ferdnyc:

As of THIS writing, the kernel documentation tree has been rearranged, and the "Hint strings" section now resides at the updated URL

Request URL   : https://github.com/alsa-project/alsa-tools/pull/2
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/2.patch
Repository URL: https://github.com/alsa-project/alsa-tools
