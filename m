Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF0C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 10:26:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E7623D50
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 10:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E7623D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FE8416E3;
	Fri, 11 Dec 2020 11:25:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FE8416E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607682399;
	bh=Io6QDBTYrxU/pakn8qlitDwVmXCxlg4/MYhI8/trE3s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NhZDEMz0BVmmmOepXcF/tJgAPPPcxpE6fwrS3rNWVG9gbafWKI4qlBkpe9SJLAhDn
	 pqQQvKXfpw6xHi5FDvxsHbSDLm6ymqv/LsEsrwHjyKogneGgyTCvU58BHjDAxqOytw
	 5W8gd5QcSgUJVlm5oN7bL8xlrPwM/E8UMYdIHTYw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCB98F8014E;
	Fri, 11 Dec 2020 11:25:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67C9AF8020D; Fri, 11 Dec 2020 11:25:47 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73FB2F8014E
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 11:25:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73FB2F8014E
IronPort-SDR: bfAEXWwktw2tk4EGcIJsr3DV71FXyfYJRO1EWiBPA7jKe/HjObdoxW+NAKXiFIjzUSEPQVTxce
 oKSq2iQzDF8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174524451"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="174524451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2020 02:25:33 -0800
IronPort-SDR: xMOhaQJB2+TbUkUPjyIg9znzXZ1hxi3fzXRyg/mBB5cdZiZ8cV7x2HiorXfuRyUA04oHHV1dbr
 ququ8M1+e8FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="333992083"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 11 Dec 2020 02:25:31 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: imx: update kernel-doc description
Date: Fri, 11 Dec 2020 12:22:55 +0200
Message-Id: <20201211102255.3189589-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@gmail.com>, kai.vehmanen@linux.intel.com,
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add missing parameters to avoid W=1 error

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/imx/imx-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 5fee637834c2..8826ef94f04a 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -47,6 +47,8 @@ void imx8_get_registers(struct snd_sof_dev *sdev,
 /**
  * imx8_dump() - This function is called when a panic message is
  * received from the firmware.
+ * @sdev: SOF device
+ * @flags: parameter not used but required by ops prototype
  */
 void imx8_dump(struct snd_sof_dev *sdev, u32 flags)
 {
-- 
2.29.2

