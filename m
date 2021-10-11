Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C9C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524B660F92
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 524B660F92
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 793211661;
	Mon, 11 Oct 2021 14:17:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 793211661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633954677;
	bh=+modbq7gFaHRS/C6O5N3bkBo6rlJ+wjLiM5wbHhSNwE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jKFM0eUkehEb2ZZyVoehVGhdBAtpl6+aCxsRlxftxEQQYaXx1F6zNdWuDczoBmPho
	 U4PR/csAFodEiap8W9cPPp9aHbBk3DeqyZkwKrHwJpZqrbizujwXo6i9yza3AAlFvy
	 J/39PihEGi2PMEc19C7uB4NJqWFnECMzPu23o1d4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0A02F8025B;
	Mon, 11 Oct 2021 14:17:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8CB7F8016D; Mon, 11 Oct 2021 14:17:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 78C49F8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 14:16:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78C49F8016D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1633954615724216938-webhooks-bot@alsa-project.org>
References: <1633954615724216938-webhooks-bot@alsa-project.org>
Subject: When will we have a new release?
Message-Id: <20211011121702.E8CB7F8016D@alsa1.perex.cz>
Date: Mon, 11 Oct 2021 14:17:02 +0200 (CEST)
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

alsa-project/alsa-lib issue #185 was opened from leiserfg:

There was an issue in the last release that affects pipewire while using laptops with `Comet Lake PCH` that was solved in alsa after the release. I'm  currently using `master` via AUR but will love to be able to use a release version (so I don't have to re-build with every change on master)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/185
Repository URL: https://github.com/alsa-project/alsa-lib
