Return-Path: <SRS0=YAlk=H6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1DAC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Feb 2021 15:26:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02CF64EAF
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Feb 2021 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02CF64EAF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EDCE1657;
	Sun, 28 Feb 2021 16:25:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EDCE1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614525956;
	bh=9H+eyP993E3+eV4KIySyHa1VOaAS3x121tqjw34e0o4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WN+xDRc9jmDU5L0yDHK5A5zqTs5s6FziuB3/Zud055ACk+s9n7JRsVkshLQri1R7X
	 fzD8kzj8ACQaixavzYw5qp8eIrmsaErHVjGCN0Ms8N5qQ1LgCJmh9DGrWipSZk2UMl
	 qSNmUSZr0gPqmVnJMvuAx+vfX/HAMkiFGSjiTCoY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAEC6F80227;
	Sun, 28 Feb 2021 16:25:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C57EF80227; Sun, 28 Feb 2021 16:25:04 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 74B0CF8010A
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2021 16:25:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74B0CF8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1614525895558794975-webhooks-bot@alsa-project.org>
References: <1614525895558794975-webhooks-bot@alsa-project.org>
Subject: broadwell-rt286, bdw-rt5677: Fix inconsistency in card detection
Message-Id: <20210228152504.1C57EF80227@alsa1.perex.cz>
Date: Sun, 28 Feb 2021 16:25:04 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #85 was edited from dpward:

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1933229

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/85
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/85.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
