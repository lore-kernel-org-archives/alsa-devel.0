Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CAC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 18:56:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D3761131
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 18:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5D3761131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25962166A;
	Mon,  4 Oct 2021 20:55:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25962166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633373807;
	bh=gkHQtVaeJBG6RKIGwmoJXrMwTHlDUSvHx4lmo9SKV84=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rNuCYGRgJGsdSXdp4m3I3yFUbqf+E0YBqJYRnNLzppdzsoTR2rMYDMM8+fIXN7B7T
	 KaNIlnXCSTDAF4eI9vHMmV+AUU0FUjyI+M1a9awePP83xhnGgBPWBIuosltiSEy5QM
	 mD6dQPETzTRcJOChRsMXkAQKrFuH6hPPNSiI6AKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10AFCF80424;
	Mon,  4 Oct 2021 20:55:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EBFFF804AC; Mon,  4 Oct 2021 20:55:13 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29398F80229
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 20:55:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29398F80229
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206360922"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="206360922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 10:14:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="523435360"
Received: from mbrescia-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.77.4])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 10:14:39 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/5] ASoC: SOF: dai: mirror group_id definition added in
 firmware
Date: Mon,  4 Oct 2021 12:14:26 -0500
Message-Id: <20211004171430.103674-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004171430.103674-1-pierre-louis.bossart@linux.intel.com>
References: <20211004171430.103674-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Brent Lu <brent.lu@intel.com>,
 Bard Liao <bard.liao@intel.com>
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

This was added in ABI 3.17 but never added to the kernel tree. The
group_id is not currently used but this patch is required before
additional changes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Brent Lu <brent.lu@intel.com>
---
 include/sound/sof/dai.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 6bb403e8c5ee..ea6dc970c18f 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -69,7 +69,8 @@ struct sof_ipc_dai_config {
 
 	/* physical protocol and clocking */
 	uint16_t format;	/**< SOF_DAI_FMT_ */
-	uint16_t reserved16;	/**< alignment */
+	uint8_t group_id;	/**< group ID, 0 means no group (ABI 3.17) */
+	uint8_t reserved8;	/**< alignment */
 
 	/* reserved for future use */
 	uint32_t reserved[8];
-- 
2.25.1

