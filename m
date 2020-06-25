Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7419EC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:08:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E933220789
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="upt3D6JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E933220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83C38192C;
	Thu, 25 Jun 2020 20:08:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83C38192C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593108533;
	bh=r16U2TstmOfH2WiwGQDtLzL9Lbevd4kNSONE749h07Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=upt3D6JE0Wqo/1j5qD56NdzmMjnEKvU2oBqgim3Dz0xYL0toq2OuzB+Y6qNBItgM2
	 CkGJDjyGpw3IH7yPlZrABzCJiz/m5xlLnkOLXD2hq6sCnEOCcIt7MH6x61rNPXMXe7
	 XS/ZSLbEiD7zp37vRFNMVB+tVpmQwdrnNgKjIuPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74CC1F802A9;
	Thu, 25 Jun 2020 20:07:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 113F0F80249; Thu, 25 Jun 2020 20:07:06 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A14BEF80218
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 20:06:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A14BEF80218
IronPort-SDR: zjLj1HwW+L1dCVAvlbA6iEKSFRmO3FHGcQGazkK97ToR17zFKTm3e32z87NmzrEv//FZWetqdZ
 WBUsy/Fva9KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146506311"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="146506311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 11:06:53 -0700
IronPort-SDR: aAadYumewmWiBRkozKgSTUB7aDILHZzYAPi70FjzwOC7k6IamK/t7PLi6Z8KUCTKD+BXjGSgSK
 7+MiE3Wmd03g==
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="453093126"
Received: from kpcavias-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.110.181])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 11:06:52 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: SOF: nocodec: add missing .owner field
Date: Thu, 25 Jun 2020 13:06:32 -0500
Message-Id: <20200625180635.3563-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625180635.3563-1-pierre-louis.bossart@linux.intel.com>
References: <20200625180635.3563-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

This field is required for ASoC cards. Not setting it will result in a
module->name pointer being NULL and generate problems such as

cat /proc/asound/modules
 0 (efault)

Reported-by: Jaroslav Kysela <perex@perex.cz>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Fixes: 8017b8fd37bf ('ASoC: SOF: Add Nocodec machine driver support')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/nocodec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index d03b5be31255..9e922df6a710 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -14,6 +14,7 @@
 
 static struct snd_soc_card sof_nocodec_card = {
 	.name = "nocodec", /* the sof- prefix is added by the core */
+	.owner = THIS_MODULE
 };
 
 static int sof_nocodec_bes_setup(struct device *dev,
-- 
2.20.1

