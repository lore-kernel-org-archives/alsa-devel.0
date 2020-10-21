Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84AC4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:27:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A602242E
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pDrttU/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A602242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B7781737;
	Wed, 21 Oct 2020 20:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B7781737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603304846;
	bh=89dAAh+SrZUfPVcilSzUoHCZIWqNy0IRTIY7fM+Qo7M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pDrttU/l6NgjbdXId8VaS3krwgemUCexrZ/4ckNzNQLMB8lwM3cam+OsxbGN4s6ga
	 vkMYpyZAfT7lRDVtvrYzkgnv+9DiFaNRMN3ra9MO0ii5fE8uyxa+eswsyEdDoWE3K3
	 pBO/I5Rg22D4jDc9SxVwH1Q+p7SfQFoiu8v9jruA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7375F80253;
	Wed, 21 Oct 2020 20:26:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E89EF80264; Wed, 21 Oct 2020 20:26:34 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0E90F80111
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 20:26:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0E90F80111
IronPort-SDR: n/eRO5GboEeT+aztjid0eBkFgiOapfZHD3eTNqqAjDAhfmBEuVFYi4GQmGDNBISYBRQyM368K0
 jB1j/4aotOKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="163924079"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; d="scan'208";a="163924079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 11:26:20 -0700
IronPort-SDR: 1HMgDeKRX0flNOBd5ml4DCs39Ao0ETZn/jFoBHLEAO3QXN/ks7lcErDK97k2jcbPoF7D5cwrbb
 MZwbydxAVcbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; d="scan'208";a="348421120"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2020 11:26:17 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: loader: handle all SOF_IPC_EXT types
Date: Wed, 21 Oct 2020 21:24:19 +0300
Message-Id: <20201021182419.1160391-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, lgirdwood@gmail.com,
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Do not emit a warning for extended firmware header fields that are
not used by kernel. This creates unnecessary noise to kernel logs like:

sof-audio-pci 0000:00:1f.3: warning: unknown ext header type 3 size 0x1c
sof-audio-pci 0000:00:1f.3: warning: unknown ext header type 4 size 0x10

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/loader.c | 5 +++++
 1 file changed, 5 insertions(+)

- baseline: eb5a558705c7 commit ("ASoC: mediatek: mt8183-da7219: fix DAPM paths for rt1015")

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 68ed454f7ddf..ba9ed66f98bc 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -118,6 +118,11 @@ int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset)
 		case SOF_IPC_EXT_CC_INFO:
 			ret = get_cc_info(sdev, ext_hdr);
 			break;
+		case SOF_IPC_EXT_UNUSED:
+		case SOF_IPC_EXT_PROBE_INFO:
+		case SOF_IPC_EXT_USER_ABI_INFO:
+			/* They are supported but we don't do anything here */
+			break;
 		default:
 			dev_warn(sdev->dev, "warning: unknown ext header type %d size 0x%x\n",
 				 ext_hdr->type, ext_hdr->hdr.size);
-- 
2.28.0

