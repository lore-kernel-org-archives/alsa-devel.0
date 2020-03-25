Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA16C43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:58:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F089C20658
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gas2/+9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F089C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E0A7166E;
	Wed, 25 Mar 2020 22:57:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E0A7166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585173511;
	bh=U/rlOGb4jdeL72oIGnox5VtTBi+SWIdWmbTLu9GpF8o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gas2/+9AvHonTvtbX1rnEeFrBeWoGaDAAFCbP1xSuRYwlM5DLzaCJ99vEUsF5hJvu
	 exLLiZL+pYvmtMCmBjsFT4QCnD1LWkZ1gym51ILTTQ10bOm2g2cHBpOYlSXOFzfKua
	 z1vqjNFwV1dIcXwyEbABAmdTGMdvNTCzD49inAMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDF1CF80308;
	Wed, 25 Mar 2020 22:51:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5582BF80218; Wed, 25 Mar 2020 22:50:54 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8068FF8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:50:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8068FF8015A
IronPort-SDR: mrPJuQ6q8WC02OWAoWEhqJBmSU1Uy1LimZLUhDCNHo/ft8Cxz7onUN3gh4mSzl+BegT5aVVO80
 dKC5p2PvgRHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 14:50:43 -0700
IronPort-SDR: eHNfYbhxYG6rnldS+XWbuiDkFruAtuFepLDAtlTIkY5ZagpJiSHcz20fPItuqbzwWOVg31VTrt
 001crQ8a4STw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="265666199"
Received: from abeljans.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.233.195])
 by orsmga002.jf.intel.com with ESMTP; 25 Mar 2020 14:50:42 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 08/11] ASoC: SOF: Intel: hda: add parameter to control
 SoundWire clock stop quirks
Date: Wed, 25 Mar 2020 16:50:24 -0500
Message-Id: <20200325215027.28716-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325215027.28716-1-pierre-louis.bossart@linux.intel.com>
References: <20200325215027.28716-1-pierre-louis.bossart@linux.intel.com>
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

Add module parameter so that the different modes can be quickly tested.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index ee4f1ceca883..1e69cfcee8e0 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -40,6 +40,16 @@
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
+/*
+ * The default for SoundWire clock stop quirks is to power gate the IP
+ * and do a Bus Reset, this will need to be modified when the DSP
+ * needs to remain in D0i3 so that the Master does not lose context
+ * and enumeration is not required on clock restart
+ */
+static int sdw_clock_stop_quirks = SDW_INTEL_CLK_STOP_BUS_RESET;
+module_param(sdw_clock_stop_quirks, int, 0444);
+MODULE_PARM_DESC(sdw_clock_stop_quirks, "SOF SoundWire clock stop quirks");
+
 static int sdw_params_stream(struct device *dev,
 			     struct sdw_intel_stream_params_data *params_data)
 {
@@ -149,6 +159,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	res.parent = sdev->dev;
 	res.ops = &sdw_callback;
 	res.dev = sdev->dev;
+	res.clock_stop_quirks = sdw_clock_stop_quirks;
 
 	/*
 	 * ops and arg fields are not populated for now,
-- 
2.20.1

