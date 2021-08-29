Return-Path: <SRS0=jhkO=NU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0CEC432BE
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Aug 2021 13:11:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B814A60F38
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Aug 2021 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B814A60F38
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A0E516A3;
	Sun, 29 Aug 2021 15:10:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A0E516A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630242674;
	bh=e+eOnB+gbI5UFYWd1Z3EsBU5AKe4cVgXSqkVLJkNL/8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vdw0oIxEouMm0Y6YhMhK+eZuJJVY63HcywXZdnCAlg3hRNuzTjTAZGhFyPXt7a9PV
	 vcjk2KGO9DLFAqe6X/EzQXMtvFNz5djDwA5rwm/2paC7GvESj+sfcarDtBAah6XTGf
	 VD0+bNF+x6dsq4uuqWOqB9fZQxyK/aLgI07TIVnU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12D73F80254;
	Sun, 29 Aug 2021 15:10:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 460FBF8025B; Sun, 29 Aug 2021 15:10:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 497B7F80169
 for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2021 15:10:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 497B7F80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1630242615461005926-webhooks-bot@alsa-project.org>
References: <1630242615461005926-webhooks-bot@alsa-project.org>
Subject: Question: different install prefixes for libalsa and alsa-plugins?
Message-Id: <20210829131022.460FBF8025B@alsa1.perex.cz>
Date: Sun, 29 Aug 2021 15:10:22 +0200 (CEST)
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

alsa-project/alsa-lib issue #175 was opened from daravi:

Hello,

I use Conan to manage my dependencies and wanted to add a recipe for `alsa-plugins`. However it seems that `ALSA_CONFIG_DIR` can only be set to a single path: https://github.com/conan-io/conan-center-index/pull/7098#discussion_r697920460

So I was wondering if there is any other way I could have alsa and plugins installed in separate directories? (so that they can each have their own config directory)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/175
Repository URL: https://github.com/alsa-project/alsa-lib
