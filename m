Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9CDC11F69
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97506613BE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97506613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 396A9174F;
	Sat, 10 Jul 2021 04:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 396A9174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884634;
	bh=OLqbH2d+gVP9ROOjklugV0zALHqGY/8Q2uzXokpItNA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hb3l3Cr05aOHzbmVfuGs4kwqrKenIEKKY8s6xX8S5pqP5CvRH+YB3Ew12JZxEUCbo
	 A8yvX/NocJAG2GC7KCn9jidJnGFUyKbwkIKqqrxP9LBXu2StqFljCJUgEJ7h4elgwN
	 2LRPG3SsBPxSdffOvZk0QE+TD/V5j9VJl/KcRJVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B079F805F4;
	Sat, 10 Jul 2021 04:25:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1430F805F1; Sat, 10 Jul 2021 04:25:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DB92F805D5
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DB92F805D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Wgl7l59d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8164F6141D;
 Sat, 10 Jul 2021 02:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883898;
 bh=OLqbH2d+gVP9ROOjklugV0zALHqGY/8Q2uzXokpItNA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wgl7l59d+dpdoMbdmgqJDJSYOUaB0elbp+1MTV1MTj6JMT5/rJo9umFxjyffIZeyB
 ai/mpNpYPUwIKTsIJUC+rT/Oy8Vkj7G5w9OHq9jvnv37/anD07BvkQd9z42MoiEVpv
 2nCr3qtAPgNj4vpG/sBqYGeK/9+AGl2FBOljiTogph05unbv2UTqDyJOIm/nJDwpE3
 VULcXvCnflZVGSDgyHfqjL8Rk9FinfieuqQ6dRFDKyAJpdnDpoK0qjxwv5XI70f27P
 F2aWTy4y/A8z78+nm5UTdrOTA95vDraEVqprmFuWFa5BnbgKgeO5uJ5VRHNGxXnEMU
 zRDYRatYqglHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 22/93] ASoC: Intel: sof_sdw: add quirk support
 for Brya and BT-offload
Date: Fri,  9 Jul 2021 22:23:16 -0400
Message-Id: <20210710022428.3169839-22-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Bard Liao <bard.liao@intel.com>, Yong Zhi <yong.zhi@intel.com>
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>

[ Upstream commit 03effde3a2ea1d82c4dd6b634fc6174545d2c34f ]

Brya is another ADL-P product.

AlderLake has support for Bluetooth audio offload capability.
Enable the BT-offload quirk for ADL-P Brya and the Intel RVP.

Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20210521155632.3736393-2-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 2770e8179983..f6d957ff61d6 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -197,7 +197,21 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.driver_data = (void *)(SOF_RT711_JD_SRC_JD1 |
 					SOF_SDW_TGL_HDMI |
 					SOF_RT715_DAI_ID_FIX |
-					SOF_SDW_PCH_DMIC),
+					SOF_SDW_PCH_DMIC |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Brya"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_SDW_PCH_DMIC |
+					SOF_SDW_FOUR_SPK |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
 	{}
 };
-- 
2.30.2

