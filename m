Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DC6C3F2D1
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:36:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9832121741
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GtcpCF41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9832121741
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3F8D1607;
	Wed,  4 Mar 2020 09:35:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3F8D1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583310990;
	bh=AxSr2DiE6YGNWwwvNNNfqYZEpIiBPZHPCLgmemIfZls=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GtcpCF41cZvhbnf3FiA9UX3Uz8VJveglCNlYjRUW+rBV9JRMX7Q369Wn9RQfyyzXF
	 dSkqoeBGj0m6Ke7XAM5pvDUm++GlBAboOCB548Tce4jVzIu/25vihQV/uXhY1M0Fsc
	 XFZEXAOxz3e1t/G52MakyLUE+OdmNr24uZGPigdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CD3FF801EC;
	Wed,  4 Mar 2020 09:35:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37A33F801ED; Wed,  4 Mar 2020 09:35:38 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BDB3CF800D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 09:35:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDB3CF800D8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583310933813123941-webhooks-bot@alsa-project.org>
References: <1583310933813123941-webhooks-bot@alsa-project.org>
Subject: Build is failing with python 3.8
Message-Id: <20200304083538.37A33F801ED@alsa1.perex.cz>
Date: Wed,  4 Mar 2020 09:35:38 +0100 (CET)
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

alsa-project/alsa-lib issue #33 was opened from seb128:

One build log from Ubuntu (1.1.9 but the current version has the same issue)
https://launchpadlibrarian.net/462093809/buildlog_ubuntu-focal-amd64.alsa-lib_1.1.9-0ubuntu4_BUILDING.txt.gz

The Ubuntu package has been fixed with that change
http://launchpadlibrarian.net/462101751/alsa-lib_1.2.1.2-2_1.2.1.2-2ubuntu1.diff.gz

The issue/needed changed is explained on https://docs.python.org/3/whatsnew/3.8.html

> To embed Python into an application, a new --embed option must be passed to python3-config --libs --embed to get -lpython3.8 (link the application to libpython). To support both 3.8 and older, try python3-config --libs --embed first and fallback to python3-config --libs (without --embed) if the previous command fails.

The Ubuntu patch doesn't have that fallback logic though which is why I'm not proposing it with a merge request

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/33
Repository URL: https://github.com/alsa-project/alsa-lib
