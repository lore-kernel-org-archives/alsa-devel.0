Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58EC4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:44:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4836108E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 19:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4836108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDBD51692;
	Mon, 21 Jun 2021 21:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDBD51692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624304684;
	bh=kjesBnmvm2tSMNWJO2yj7Hkcp8L53AwZk54cC6sVvNg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+Ku+/+CqlnjEZYeW4NhLWVk6/3uptdJaOzPslYykD+MxzZpVdjYHSgH1Qb2+RxLu
	 4tHYRuW5/qTCocWzg5lIQ76SmvjPexXalqHzQ3XxgfXHAUyJoS9dU+GEAvVx88hdA1
	 YtTvDS3KiQ26QghQ3jVhsUB3ZVuj/4XNkORQwlw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89F6AF804E7;
	Mon, 21 Jun 2021 21:41:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23FABF80245; Mon, 21 Jun 2021 21:41:35 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65772F801D5
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 21:41:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65772F801D5
IronPort-SDR: Y9NdEivrYwvaCx0XroZv6zmbr+gpsDqINj8d7Z2he4azWO/apSDCGmX+acwF+X7OpOVcnew9nv
 QzO5D9PtUJSg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203903339"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="203903339"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:23 -0700
IronPort-SDR: 2Q3gyYkGzjpDXTHYlqg5PJ3QNjoeVsswxBwnVXdsSWvF4tG7prQ/JCTXu6zcQe1yGcDI8NU/wz
 FBOqIysXv9UA==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="486619079"
Received: from gwhaugh-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.175.53])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 12:41:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 07/10] ASoC: Intel: sof_sdw: fix signed/unsigned warning
Date: Mon, 21 Jun 2021 14:40:54 -0500
Message-Id: <20210621194057.21711-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621194057.21711-1-pierre-louis.bossart@linux.intel.com>
References: <20210621194057.21711-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Paul Olaru <paul.olaru@oss.nxp.com>
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

Sparse throws the following warning:

sound/soc/intel/boards/sof_sdw.c:796:31: error: incorrect type in argument 6 (different signedness)
sound/soc/intel/boards/sof_sdw.c:796:31:    expected int *group_id
sound/soc/intel/boards/sof_sdw.c:796:31:    got unsigned int *

The group_id cannot be negative, use unsigned int.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 34f142d7b3f9..e9118234b30e 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -682,7 +682,7 @@ static int set_codec_init_func(const struct snd_soc_acpi_link_adr *link,
  */
 static int get_slave_info(const struct snd_soc_acpi_link_adr *adr_link,
 			  struct device *dev, int *cpu_dai_id, int *cpu_dai_num,
-			  int *codec_num, int *group_id,
+			  int *codec_num, unsigned int *group_id,
 			  bool *group_generated)
 {
 	const struct snd_soc_acpi_adr_device *adr_d;
-- 
2.25.1

