Return-Path: <SRS0=JMHt=2M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D132C2D0C0
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 07:14:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DB6206CB
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 07:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H9bFWok6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DB6206CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FEAC1614;
	Sun, 22 Dec 2019 08:14:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FEAC1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576998894;
	bh=ffgGN9DKGLLOoH7Zxa1VtZwgvqsdpaB1oGA0xBqshso=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H9bFWok6bGH+agcnn98rqU0V2kHtQFc5a2F9etaw0Icuatpap+zRGUpH/wYcCZ0UV
	 m/vNZCVDQZfF9CtV+v6flNUKDGLmyZ9SuIg7NdRhCjAssPrcdsudvBCiy6iWxwggEx
	 FiBe7gzCZ0kss0NGGZtM2R1oMJfjvk7gBEhGanFc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2525EF8011C;
	Sun, 22 Dec 2019 08:14:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D748FF80136; Sun, 22 Dec 2019 08:14:01 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B263EF80087
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2019 08:13:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B263EF80087
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1576998837996987104-webhooks-bot@alsa-project.org>
References: <1576998837996987104-webhooks-bot@alsa-project.org>
Message-Id: <20191222071401.D748FF80136@alsa1.perex.cz>
Date: Sun, 22 Dec 2019 08:14:01 +0100 (CET)
Subject: [alsa-devel] ctl: elem_info_int: fix wrong assignment to private
	value
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

alsa-project/alsa-gobject pull request #1 was opened from takaswie:

ALSACtl::ElemInfoInt has properties for 'min', 'max' and 'step' but their
assignments are not proper. This commit fixes the bug.

Fixes: aac870451a89 ("ctl: elem_info_int: add properties for type-dependent parameters and constructor")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/1
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/1.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
