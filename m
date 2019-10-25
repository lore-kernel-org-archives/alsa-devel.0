Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A3CA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:42:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D152120684
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W70gBsvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D152120684
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22408187D;
	Fri, 25 Oct 2019 19:41:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22408187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572025367;
	bh=xoyIkO9Hw5TyuTewEKB6d/Si8AsUvdmuyLnh5KYkBF8=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W70gBsvN/tyvVyRDY1++B219YEwNL0BPu4HFsblCkX2u4D0hcFDFTNHr6vHTiK0io
	 VdjQarHMaK4wwdogbMVIempTJbg0wmW/lAtwyLbAWKUHYbMvH65oIyTxX7rJWC/Nf4
	 w09AOwdNChiPm78aaf3JXjPYLAOJYZG1PCzq9xUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59C5FF803A6;
	Fri, 25 Oct 2019 19:41:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1DCFF8045D; Fri, 25 Oct 2019 19:41:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4D36BF803A6
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 19:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D36BF803A6
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1572025280103435993-webhooks-bot@alsa-project.org>
References: <1572025280103435993-webhooks-bot@alsa-project.org>
Message-Id: <20191025174122.E1DCFF8045D@alsa1.perex.cz>
Date: Fri, 25 Oct 2019 19:41:22 +0200 (CEST)
Subject: [alsa-devel] sof-skl_hda: move hdmi as separate use case
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #6 was opened from juimonen:

Move hdmi definitions as separate use case and conf file. This will
enable Pulseaudio to create separate profile for hdmi and make routing
much more fluent than with single profile.

Signed-off-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/6
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/6.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
