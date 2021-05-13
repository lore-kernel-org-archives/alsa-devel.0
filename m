Return-Path: <SRS0=EA+P=KI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72500C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 01:54:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4E561413
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 01:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4E561413
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2194917D6;
	Thu, 13 May 2021 03:53:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2194917D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620870876;
	bh=z3URNIHCkvp9F5/UwIl+gOS6ReCNxUVEu5ml4DErVn4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gq6K/KOXxHQRVouQ1Amphflk4ETyMuKGNqebsoTb3bRnlLjncrm0D38HfoPBVxUJd
	 ccLu5vHbk4p0ueGq/UfFRBpUvbJE1Zxy67YODUboZ1jJCRlsCccKiF/2eNOIIV+tNG
	 9oWtPkDoUmpI85Bxoq/8HI1VIMT8tB/grlBYoHuM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA7AEF801D5;
	Thu, 13 May 2021 03:53:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A30FF80245; Thu, 13 May 2021 03:53:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F03FFF8016B
 for <alsa-devel@alsa-project.org>; Thu, 13 May 2021 03:53:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F03FFF8016B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1620870807803136110-webhooks-bot@alsa-project.org>
References: <1620870807803136110-webhooks-bot@alsa-project.org>
Subject: pulse.conf overrides ~/.asoundrc for default
Message-Id: <20210513015330.5A30FF80245@alsa1.perex.cz>
Date: Thu, 13 May 2021 03:53:30 +0200 (CEST)
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

alsa-project/alsa-lib issue #134 was edited from flatmax:

On many systems pulse audio sets the default device to pulse. This overrides the settings in ~/.asoundrc.

This is further complicated by using a tool like pasuspender and finding that pulse's default device is still set and overriding ~/.asoundrc

It would seem more empowering to let the user override the default device in ~/.asoundrc and have that take effect over pulse.conf which typically resides in /usr/share/alsa/alsa.conf.d
For that matter, it would be more empowering to the user to override everything (well almost any thing) using ~/.asoundrc, whether it is in alsa,conf.d or elsewhere.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/134
Repository URL: https://github.com/alsa-project/alsa-lib
