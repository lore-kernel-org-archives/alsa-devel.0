Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F9C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:35:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04BE2073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HofzxOac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04BE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E1FB1658;
	Tue, 10 Dec 2019 14:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E1FB1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984922;
	bh=KHM4ELKPsFlBOhyiSrLETiiLsMNuEfPBDgm9Bfqs9Yc=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HofzxOacECtldXdK+CSngxFyfveYjGhXu5plJhzbq5zf3jUyV8fUJ0fdNlcxjhnel
	 btRhjNNuEqoJ2xvXf/FABLW8VdgQy/hlmc/2gCNLYb95ihjexXhiIemXNDi/R13TEz
	 YbcIA42aVTCout/HZ84dP2ykoRDc9yPnBePTf7n0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65A05F80336;
	Tue, 10 Dec 2019 14:23:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B07FF80337; Tue, 10 Dec 2019 14:23:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1335FF80323
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:23:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1335FF80323
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5AF113E;
 Tue, 10 Dec 2019 05:23:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F79E3F52E;
 Tue, 10 Dec 2019 05:23:14 -0800 (PST)
Date: Tue, 10 Dec 2019 13:23:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Slawomir Blauciak <slawomir.blauciak@linux.intel.com>
In-Reply-To: <20191210004854.16845-5-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191210004854.16845-5-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: ipc: channel map structures" to
	the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: SOF: ipc: channel map structures

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b7c5986489b5c55ebebc430037dd4691a6bbc99c Mon Sep 17 00:00:00 2001
From: Slawomir Blauciak <slawomir.blauciak@linux.intel.com>
Date: Mon, 9 Dec 2019 18:48:50 -0600
Subject: [PATCH] ASoC: SOF: ipc: channel map structures

This change adds stream map and channel map structures
used for channel re-routing and stream aggregation.

Signed-off-by: Slawomir Blauciak <slawomir.blauciak@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191210004854.16845-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/channel_map.h | 61 +++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 include/sound/sof/channel_map.h

diff --git a/include/sound/sof/channel_map.h b/include/sound/sof/channel_map.h
new file mode 100644
index 000000000000..21044eb5f377
--- /dev/null
+++ b/include/sound/sof/channel_map.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2019 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __IPC_CHANNEL_MAP_H__
+#define __IPC_CHANNEL_MAP_H__
+
+#include <uapi/sound/sof/header.h>
+#include <sound/sof/header.h>
+
+/**
+ * \brief Channel map, specifies transformation of one-to-many or many-to-one.
+ *
+ * In case of one-to-many specifies how the output channels are computed out of
+ * a single source channel,
+ * in case of many-to-one specifies how a single target channel is computed
+ * from a multichannel input stream.
+ *
+ * Channel index specifies position of the channel in the stream on the 'one'
+ * side.
+ *
+ * Ext ID is the identifier of external part of the transformation. Depending
+ * on the context, it may be pipeline ID, dai ID, ...
+ *
+ * Channel mask describes which channels are taken into account on the "many"
+ * side. Bit[i] set to 1 means that i-th channel is used for computation
+ * (either as source or as a target).
+ *
+ * Channel mask is followed by array of coefficients in Q2.30 format,
+ * one per each channel set in the mask (left to right, LS bit set in the
+ * mask corresponds to ch_coeffs[0]).
+ */
+struct sof_ipc_channel_map {
+	uint32_t ch_index;
+	uint32_t ext_id;
+	uint32_t ch_mask;
+	uint32_t reserved;
+	int32_t ch_coeffs[0];
+} __packed;
+
+/**
+ * \brief Complete map for each channel of a multichannel stream.
+ *
+ * num_ch_map Specifies number of items in the ch_map.
+ * More than one transformation per a single channel is allowed (in case
+ * multiple external entities are transformed).
+ * A channel may be skipped in the transformation list, then it is filled
+ * with 0's by the transformation function.
+ */
+struct sof_ipc_stream_map {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t num_ch_map;
+	uint32_t reserved[3];
+	struct sof_ipc_channel_map ch_map[0];
+} __packed;
+
+#endif /* __IPC_CHANNEL_MAP_H__ */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
