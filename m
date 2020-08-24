Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150F3C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:13:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB3C2067C
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EpOrlg5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB3C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB0DB1676;
	Mon, 24 Aug 2020 22:12:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB0DB1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598299981;
	bh=lOfE+dXf1FL3dtevs0jMN9t3863Oa8+NivpbgfO6PC0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EpOrlg5Aq+cg+oWeewucFFMcWizNhwDB70soG9uijwIss7zMaYQx9XxkimDG4K0lm
	 tbMJvl6mwogbz+6A12kFirA47/6n1iRGCFgYawGfXMEUPLhcFzqV8Kft7jRBl7v8fE
	 +7sH8av4T1KzkvAKi9pTyNnQ1cfXPzGyvel+Sv1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B512F802E1;
	Mon, 24 Aug 2020 22:09:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F992F802D2; Mon, 24 Aug 2020 22:09:39 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7789F801D9
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 22:09:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7789F801D9
IronPort-SDR: NOSI3DMksASNrxgm+Q8hvWvAK9TeNl1bGRAWBm1piHcHwDC5gE4Ipa3WhS+34tOTRW//VaSYf6
 ejtBylaM6a4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157033726"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; d="scan'208";a="157033726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 13:09:23 -0700
IronPort-SDR: DDBa0VBjcbbaG62abJEIiYwGNJmc3ntzrS9TDFC2Ut/UB+M5QcP0vuFA9nlRz6G42zZu1wb/Wr
 hYp+lPIS4bjg==
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; d="scan'208";a="443351185"
Received: from dentoneb-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.223.13])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 13:09:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/8] ASoC: SOF: (cosmetic) use the "bool" type where it makes
 sense
Date: Mon, 24 Aug 2020 15:09:06 -0500
Message-Id: <20200824200912.46852-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824200912.46852-1-pierre-louis.bossart@linux.intel.com>
References: <20200824200912.46852-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

Several fields in struct snd_sof_dev are used as boolean flags, use
the "bool" type for them.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-priv.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 64f28e082049..e2070072791c 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -370,7 +370,7 @@ struct snd_sof_dev {
 	/* DSP firmware boot */
 	wait_queue_head_t boot_wait;
 	enum snd_sof_fw_state fw_state;
-	u32 first_boot;
+	bool first_boot;
 
 	/* work queue in case the probe is implemented in two steps */
 	struct work_struct probe_work;
@@ -431,10 +431,10 @@ struct snd_sof_dev {
 	int dma_trace_pages;
 	wait_queue_head_t trace_sleep;
 	u32 host_offset;
-	u32 dtrace_is_supported; /* set with Kconfig or module parameter */
-	u32 dtrace_is_enabled;
-	u32 dtrace_error;
-	u32 dtrace_draining;
+	bool dtrace_is_supported; /* set with Kconfig or module parameter */
+	bool dtrace_is_enabled;
+	bool dtrace_error;
+	bool dtrace_draining;
 
 	bool msi_enabled;
 
-- 
2.25.1

