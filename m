Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C6C433E3
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:17:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F146720739
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TFXVvU8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F146720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 687D81614;
	Fri, 17 Jul 2020 23:16:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 687D81614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595020658;
	bh=baQ4M8WhEEkJ0rP/dnqhb5JQGOM2bZWznh6Y4TZ7BfA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFXVvU8/RdDBsNqIxen+kGyGtVXcHEb4iiy8yCDlDbA1BLR+fCGFJrCx5pka8BbFu
	 vE6eh3n/olXiohYtJi3rerBCNJEpHUxtfSrA/1mwljkz84bbIP4Gj01y25yExo3kgH
	 DOgQrrhXI7UU1kV7b2n790W+CQCe0wY0OjBODz7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B7E2F801D8;
	Fri, 17 Jul 2020 23:15:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C232F80229; Fri, 17 Jul 2020 23:15:10 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 501ADF80110
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 23:14:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 501ADF80110
IronPort-SDR: yYzbd0869tKGh9GqT2pqvSRcjoa5QBbrw4UPZUdE72cyYdZq/Ca9KSaBdxGZ6hL6vEhvjd9voa
 YfxUVRj/A0Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="129758201"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; d="scan'208";a="129758201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2020 14:13:48 -0700
IronPort-SDR: IN4VoSMgq/cXoFXO6iZaimVUmE/oW58lOV9g7cIwo7JZKhoJSeym5pPfQqRyl2Lrtizu8eP0LZ
 0oiCJy5TmrdA==
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; d="scan'208";a="282905782"
Received: from toddjdav-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.240])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2020 14:13:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/6] ASoC: Intel: sof_sdw_rt711: remove hard-coded codec name
Date: Fri, 17 Jul 2020 16:13:32 -0500
Message-Id: <20200717211337.31956-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717211337.31956-1-pierre-louis.bossart@linux.intel.com>
References: <20200717211337.31956-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We can get codec name from dai link.

Suggested-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_rt711.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw_rt711.c b/sound/soc/intel/boards/sof_sdw_rt711.c
index d4d75c8dc6b7..c8f84e9a3e4e 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711.c
@@ -147,7 +147,7 @@ int sof_sdw_rt711_init(const struct snd_soc_acpi_link_adr *link,
 	if (!playback)
 		return 0;
 
-	ret = rt711_add_codec_device_props("sdw:0:25d:711:0");
+	ret = rt711_add_codec_device_props(dai_links->codecs[0].name);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

