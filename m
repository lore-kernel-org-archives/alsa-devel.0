Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F913C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:02:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F02072D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GsBDBoEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38C82166D;
	Fri, 21 Aug 2020 22:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38C82166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598040167;
	bh=RsZb5ZcJlPZ/fmiRp2oF2VVME04wYU8JwnycqMJfnqc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GsBDBoEAJukT2SA2q+fYrlcYJqr71fGJ6UZyUiKv2NgW+oYAD6XuFgr9Bs9vIScV1
	 weQzXe/Ulp1a2FjKCtDCN2dY/ESkf6cm+NohioEN7eGZCul6heNeagjOHiT+qFcOAd
	 HF8fJE0yEdPETZGlvHnRf0oDjoAzT3VRXBrtdEWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F4F8F80307;
	Fri, 21 Aug 2020 21:56:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB0D2F802EB; Fri, 21 Aug 2020 21:56:39 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6929DF80257
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 21:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6929DF80257
IronPort-SDR: JzXx59j4Pkon6M7UlkNPn09rBU2cOouChwMb0gg/vu2SrTGNA2biiZ5PgZI01mVPDZCigXHjoK
 Vw2af5SIrL8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="217158562"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; d="scan'208";a="217158562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 12:56:21 -0700
IronPort-SDR: 2raCJYDlQI34z/yQkSC9a/E8kPaloynshXAHR74EwvnKXDR2BSulSMJlRaiSdwmbVLxY5PttoX
 5ELYiC03btEA==
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; d="scan'208";a="279002421"
Received: from pahnn-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.254.176.176])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 12:56:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 10/14] ASoC: Intel: sof_sdw: Add support for product Ripto
Date: Fri, 21 Aug 2020 14:55:57 -0500
Message-Id: <20200821195603.215535-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821195603.215535-1-pierre-louis.bossart@linux.intel.com>
References: <20200821195603.215535-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, vinod.koul@intel.com, broonie@kernel.org,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

From: Rander Wang <rander.wang@intel.com>

Ripto is another product based on TGL with the same
audio hardware configuration as Volteer.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index ca231459ac10..44d06fa48b24 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -123,6 +123,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI | SOF_SDW_PCH_DMIC |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Ripto"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI | SOF_SDW_PCH_DMIC |
+					SOF_SDW_FOUR_SPK),
+	},
 
 	{}
 };
-- 
2.25.1

