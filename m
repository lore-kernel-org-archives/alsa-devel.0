Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD383C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:28:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE9864F60
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9864F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1735317B9;
	Fri, 12 Mar 2021 19:27:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1735317B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615573691;
	bh=UenaL2bU6d/c1ZGIZy0wBpf3mgTXVp8B2sFCFTFIdg8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNvJLgsCkYAIhszFHlHnynqKGaZMTrhZ4AECssYc1fr5BAQ9rNnzuk993mDqjSW7E
	 2jqFvgWmULLAZjU5MZql+yrtnwSJAKhcCerwr2jkpGyhYoyfWYXZoJGikvaHDS39nk
	 Fl4yXU7RrcNBd47ltJg+qHKQ4LTpyWGQk9YCRF00=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B29E8F804F1;
	Fri, 12 Mar 2021 19:23:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 443B5F802E0; Fri, 12 Mar 2021 19:23:34 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEDE7F801ED
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:23:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEDE7F801ED
IronPort-SDR: iTyRuttP9/8ZB3gywERyLP0jGxReXdQjTM9DvFbnBptZNMT6RDlqdzZNWjSTCxfGA4tkHaLloE
 rre7K74RG7WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185515196"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="185515196"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:27 -0800
IronPort-SDR: TXOqmeBFIU4oAz+oS82bU5HQyoIkqGNqVNDIJJGg5BnhEiPKFnayr2Sf6/dWLKFKZE1krO+Qlv
 SVY0i+l1JzuQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="377791964"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:23:25 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 11/23] ASoC: hdmi-codec: remove unused spk_mask member
Date: Fri, 12 Mar 2021 12:22:34 -0600
Message-Id: <20210312182246.5153-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Stephan Gerhold <stephan@gerhold.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

fix cppcheck warning:

sound/soc/codecs/hdmi-codec.c:25:16: style: struct member
'hdmi_codec_channel_map_table::spk_mask' is never
used. [unusedStructMember]
 unsigned long spk_mask;  /* speaker position bit mask */
               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdmi-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 83e74ddccf59..1567ba196ab9 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -22,7 +22,6 @@
 
 struct hdmi_codec_channel_map_table {
 	unsigned char map;	/* ALSA API channel map position */
-	unsigned long spk_mask;		/* speaker position bit mask */
 };
 
 /*
-- 
2.25.1

