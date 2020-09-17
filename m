Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E23C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:03:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEF5208DB
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hcsVW6+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEF5208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 426031674;
	Thu, 17 Sep 2020 13:02:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 426031674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600340589;
	bh=J3rQ0vNAD/d47u4uQSGE/iIrRHC4kJyTTuY8DH5v9yk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hcsVW6+aemtXtU7S4QQg73ntItacpp1jam4ABYvjj3l9C0ZTmETbSGfl+rFgHSRGL
	 oALoRCsjnWDIT44XC40EYE207ZRYl4vQgtAzYBT8aUZEmaMdGJdjUwBJeMf5diEoix
	 H13GpSdsFuRJAft7QBu1rHm0SahhFuMuiN5vRvT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 222B1F802FD;
	Thu, 17 Sep 2020 12:58:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48632F802EB; Thu, 17 Sep 2020 12:58:24 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB752F8028B
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 12:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB752F8028B
IronPort-SDR: zyrkaIbVlSp8BmlGcURABbk2Y9YaZsl+X/tC4VI27qhwiJbncd9TEt3e6L8K32YRiVCL6gOUo2
 8Yfoo4sN5plw==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="157075363"
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; d="scan'208";a="157075363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 03:58:15 -0700
IronPort-SDR: CstMMEIKtCm4oXqL9DYTnUkjK5Uf/JrRzmnb+iR3iPdLKThn29mHhisAwhQSgu4BFkMt21R3kO
 TIOBlwrNUVPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; d="scan'208";a="320177356"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 17 Sep 2020 03:58:13 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 6/8] ASoC: SOF: remove several superfluous type-casts
Date: Thu, 17 Sep 2020 13:56:31 +0300
Message-Id: <20200917105633.2579047-7-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200917105633.2579047-1-kai.vehmanen@linux.intel.com>
References: <20200917105633.2579047-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

No need to type-cast assignments between void and other pointers in C.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index cd506a4bfc4b..afe7e503bf66 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -485,13 +485,13 @@ EXPORT_SYMBOL(sof_machine_check);
 
 int sof_machine_register(struct snd_sof_dev *sdev, void *pdata)
 {
-	struct snd_sof_pdata *plat_data = (struct snd_sof_pdata *)pdata;
+	struct snd_sof_pdata *plat_data = pdata;
 	const char *drv_name;
 	const void *mach;
 	int size;
 
 	drv_name = plat_data->machine->drv_name;
-	mach = (const void *)plat_data->machine;
+	mach = plat_data->machine;
 	size = sizeof(*plat_data->machine);
 
 	/* register machine driver, pass machine info as pdata */
@@ -510,7 +510,7 @@ EXPORT_SYMBOL(sof_machine_register);
 
 void sof_machine_unregister(struct snd_sof_dev *sdev, void *pdata)
 {
-	struct snd_sof_pdata *plat_data = (struct snd_sof_pdata *)pdata;
+	struct snd_sof_pdata *plat_data = pdata;
 
 	if (!IS_ERR_OR_NULL(plat_data->pdev_mach))
 		platform_device_unregister(plat_data->pdev_mach);
-- 
2.27.0

