Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBBC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:31:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A88208C7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qQRkt8pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A88208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B9DD18B2;
	Wed,  2 Sep 2020 23:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B9DD18B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082278;
	bh=LobmKfKuqi3VzFfC78FZt/ivNW0WfYsw62vxZCRCYMU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qQRkt8pMxhVuJdN+NJrdHIRgkdcmp/Yvc1uHi8s1CrdulKo70nKyBeE3EhgUfrPsr
	 SZm90DBNvX5ni0/c2kgrKKa6pW3vhs5oEvTFWsODJ0kFImyU9SYeWrvHIxtImH0aUE
	 IC7QRa614RA5dyHa3YdZDK3ZMh279IQVG5z41QlA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AB10F80341;
	Wed,  2 Sep 2020 23:22:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B17E1F80306; Wed,  2 Sep 2020 23:22:34 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18D43F802E1
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18D43F802E1
IronPort-SDR: 18OkODOZF3zn0pXH1SNn5EfrA83fRbL6TxCNOm6fEURv1KFr5DGcncE1ipQUpoew6iJ3P0wxu2
 6lD6ltN81LeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482883"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:09 -0700
IronPort-SDR: 7fampBUinODS36hWHd8zfMNuizV7+1yyhIk2aFESyMZ10c6sAN491AxGODFYU66J4Gy2gzv9HO
 ZJJoCVW+2EvQ==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798292"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:08 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/18] ALSA: ac97: (cosmetic) align argument names
Date: Wed,  2 Sep 2020 16:21:28 -0500
Message-Id: <20200902212133.30964-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
References: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warning:

sound/ac97/bus.c:133:60: style:inconclusive: Function
'snd_ac97_bus_scan_one' argument 1 names different: declaration 'ac97'
definition 'adrv'. [funcArgNamesDifferent]

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/ac97/ac97_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/ac97_core.h b/sound/ac97/ac97_core.h
index 0c5956e4b2f3..5a9677c3d4c3 100644
--- a/sound/ac97/ac97_core.h
+++ b/sound/ac97/ac97_core.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  */
 
-unsigned int snd_ac97_bus_scan_one(struct ac97_controller *ac97,
+unsigned int snd_ac97_bus_scan_one(struct ac97_controller *adrv,
 				   unsigned int codec_num);
 
 static inline bool ac97_ids_match(unsigned int id1, unsigned int id2,
-- 
2.25.1

