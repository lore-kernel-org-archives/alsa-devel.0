Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5543DC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:23:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B1C64EBA
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 22:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B1C64EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14763166E;
	Thu, 18 Feb 2021 23:22:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14763166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613686989;
	bh=LSgcxyFfUXkegWxfcxmzAnisvEi+5hsP3iHV8Ppwd0M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R3kYUDI1c+/T30rDyJ7V5lew1skquuKDerbSqaE1ErepONTfTf6Xj14sidAmk5kEK
	 HJQQk1XuD0aas7J0W2xXKo1z5lnxOlUDOiK+ncrF4Acj9DuK9IB0xtnq/0AXi72l4X
	 JQac1cCH9su0mj0V51CA9rbjFXQPB7JbBSG2QnrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2090F80431;
	Thu, 18 Feb 2021 23:19:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DDF7F80229; Thu, 18 Feb 2021 23:19:52 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01EC9F80229
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 23:19:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01EC9F80229
IronPort-SDR: vQEtLZV1I/lZ2H59B0GWBAFSubELxPH3kx95rihPgDesm/hcQzTZbuAdACKO0ERXaeHulK4FUH
 Bi5+8z3ktI3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="170801491"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="170801491"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:19:37 -0800
IronPort-SDR: ckUVFnkZQGumvG0K2QWw6zUBEHk5pNPu2DkvQD1npcOeYSFyCKoPIi0gaztE7GR6KIjbdhpMpq
 0kXuqXKDmjJw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="581441987"
Received: from tphilli1-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.64.38])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 14:19:36 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/6] ASoC: soc-pcm: add error log
Date: Thu, 18 Feb 2021 16:19:19 -0600
Message-Id: <20210218221921.88991-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218221921.88991-1-pierre-louis.bossart@linux.intel.com>
References: <20210218221921.88991-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

cppcheck warning:

sound/soc/soc-pcm.c:1907:6: style: Variable 'err' is assigned a value
that is never used. [unreadVariable]
 err = dpcm_be_dai_hw_free(fe, stream);
     ^

it's not clear why dpcm_be_dai_hw_free() is sometimes called without
testing the error status, and sometimes an error message is provided.

When in doubt, add an error message for consistency. This may have to
be revisited.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 705fb2d548a9..2de69dc240bd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1907,6 +1907,8 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	/* only hw_params backends that are either sinks or sources
 	 * to this frontend DAI */
 	err = dpcm_be_dai_hw_free(fe, stream);
+	if (err < 0)
+		dev_err(fe->dev, "ASoC: hw_free BE failed %d\n", err);
 
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-- 
2.25.1

