Return-Path: <SRS0=9FQT=JZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214CC43460
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 08:27:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2570361438
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 08:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2570361438
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC26F16C2;
	Wed, 28 Apr 2021 10:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC26F16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619598454;
	bh=rwnWKmIQRvaamGUYw14zOPTxGPV5d+pWeCCsh0P8oTs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pnFX+pTYIh64t8BUB4GoGQNXbpI4MdJsFIEfTqTYC5+LtKu4sP+eZ5XcsR1dFSLe0
	 aG+3jwXceEUiIaCHOBSK/4x3NBWlD6FI5+oZ1suZzFFYw/8Hs+k2w/JfsJjAMEdzER
	 QlRpMQEwChW/ORXUYCcsT1Pkpd3Q2DxzmuuG25mY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3650CF8012A;
	Wed, 28 Apr 2021 10:26:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F455F8016C; Wed, 28 Apr 2021 10:26:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 71C9CF80130
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 10:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71C9CF80130
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1619598379949965954-webhooks-bot@alsa-project.org>
References: <1619598379949965954-webhooks-bot@alsa-project.org>
Subject: ucm2: soundwire: use the codec kcontrols for rt711-sdca
Message-Id: <20210428082642.3F455F8016C@alsa1.perex.cz>
Date: Wed, 28 Apr 2021 10:26:42 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #90 was opened from libinyang:

Use "rt711 FU0F" as the HW control, instead of the "PGA2.0 2".

Signed-off-by: Libin Yang <libin.yang@intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/90
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/90.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
