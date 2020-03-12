Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDEEC1975A
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF763206E2
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pmeayHon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF763206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 182211741;
	Thu, 12 Mar 2020 20:36:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 182211741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584041845;
	bh=Lbnqg2LBvJbcxI/tRn6JuFd0OcIJTLQlS87NnC6EEYI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pmeayHonvIihW5d7mSWCFIbdrtavcKYbmNzKAwPX+B8UMG3bt27YxMyqt8WMjn9iB
	 2wPefZ8smwjxzzKAdcR32QGtXGY3IIHMkfWPwsGtG65Gk0H1wPzTffQ4RM6o5uBz0b
	 4q14EI1NeEBZGKr5XghYm62OM/2+giTWhE8QnC6I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 437C4F8029A;
	Thu, 12 Mar 2020 20:34:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E383F8029B; Thu, 12 Mar 2020 20:34:45 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01B4BF80290
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 20:34:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01B4BF80290
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 12:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="243142538"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.251.241.169])
 by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:34:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 03/10] ASoC: SOF: IPC: dai-intel: move ALH declarations in
 header file
Date: Thu, 12 Mar 2020 14:33:39 -0500
Message-Id: <20200312193346.3264-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Janusz Jankowski <janusz.jankowski@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Thomas Gleixner <tglx@linutronix.de>,
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

ALH was inserted in the wrong place during integration, add after DMIC
to mirror the file used by SOF firmware.

No functional change, just text move in the same file to better track
changes, if any.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-intel.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 5f1ef5565be6..04e48227f542 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -87,6 +87,15 @@ struct sof_ipc_dai_hda_params {
 	uint32_t link_dma_ch;
 } __packed;
 
+/* ALH Configuration Request - SOF_IPC_DAI_ALH_CONFIG */
+struct sof_ipc_dai_alh_params {
+	struct sof_ipc_hdr hdr;
+	uint32_t stream_id;
+
+	/* reserved for future use */
+	uint32_t reserved[15];
+} __packed;
+
 /* DMIC Configuration Request - SOF_IPC_DAI_DMIC_CONFIG */
 
 /* This struct is defined per 2ch PDM controller available in the platform.
@@ -179,13 +188,4 @@ struct sof_ipc_dai_dmic_params {
 	struct sof_ipc_dai_dmic_pdm_ctrl pdm[0];
 } __packed;
 
-/* ALH Configuration Request - SOF_IPC_DAI_ALH_CONFIG */
-struct sof_ipc_dai_alh_params {
-	struct sof_ipc_hdr hdr;
-	uint32_t stream_id;
-
-	/* reserved for future use */
-	uint32_t reserved[15];
-} __packed;
-
 #endif
-- 
2.20.1

