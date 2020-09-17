Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7795C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:00:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118A62076D
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eRnFJh8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118A62076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DF911681;
	Thu, 17 Sep 2020 12:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DF911681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600340448;
	bh=WSZ+GkyqjpvpmrVS8/c5QvGTionte5/WRM1RK23jZy8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eRnFJh8Y8BziSkEV/al0eVNHIHaM5CjJen6HvKHJi0OuYVwWPX7lD354V8o23/Pst
	 9dZRMfBjZW71/p0FfPb/5NyYaE33w2ga6hOk5BdWllmw/ESwjPE9J/PY4tVHux4Vd3
	 u1NjoD1/WHDb6j+XVAyTNHRqRpNdOcdUG+cOumWY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88F98F802C4;
	Thu, 17 Sep 2020 12:58:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB098F802DD; Thu, 17 Sep 2020 12:58:19 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7025F8025E
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 12:58:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7025F8025E
IronPort-SDR: 0W/qptBabc1UoYyIfB3ZZ8zJKnz+gW4WEKhrJtOGXTgtjF9JDU7F8y7CNWY3MGJCFaCTukcXjE
 AJ9LXNd1DZRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="157075348"
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; d="scan'208";a="157075348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 03:58:07 -0700
IronPort-SDR: +yPDLrq+wgDtGGgzBq/Og55urYXFWriY/baYnyQuFpibexTUFhBM5alhdqIvSym6fmK+dlv2jr
 5N+QwwrdC//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; d="scan'208";a="320177317"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 17 Sep 2020 03:58:05 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/8] ASoC: SOF: Add `src_hash` to `sof_ipc_fw_version`
 structure
Date: Thu, 17 Sep 2020 13:56:27 +0300
Message-Id: <20200917105633.2579047-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200917105633.2579047-1-kai.vehmanen@linux.intel.com>
References: <20200917105633.2579047-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Karol Trzcinski <karolx.trzcinski@linux.intel.com>, daniel.baluta@nxp.com
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

From: Karol Trzcinski <karolx.trzcinski@linux.intel.com>

This field will be used to compare ldc file with loaded fw version,
to assert validity of trace logs. Value used in sof-logger.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/sof/info.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
index 313e3e70c630..0b7101aef596 100644
--- a/include/sound/sof/info.h
+++ b/include/sound/sof/info.h
@@ -46,9 +46,11 @@ struct sof_ipc_fw_version {
 	uint8_t time[10];
 	uint8_t tag[6];
 	uint32_t abi_version;
+	/* used to check FW and ldc file compatibility, reproducible value */
+	uint32_t src_hash;
 
 	/* reserved for future use */
-	uint32_t reserved[4];
+	uint32_t reserved[3];
 } __packed;
 
 /* FW ready Message - sent by firmware when boot has completed */
-- 
2.27.0

