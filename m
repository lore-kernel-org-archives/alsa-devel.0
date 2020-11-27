Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B09C82485
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 16:44:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0020720657
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uwci1rpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0020720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B715185B;
	Fri, 27 Nov 2020 17:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B715185B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606495483;
	bh=X7v3Cx353N0W9PKu7NIZ5jG3EMlzqXQqwA+LUtjyvaU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwci1rprxmL3Ae5Iwx1S2JUp4hGpI9vHFtIeFVlD0l5Th3ytWSFnJJgYZ7GuGV3Bi
	 QK+uiIVx3XflzmNjMlEIzKkwkfIYqHfLAzyHBuQE524Ru7aqVh6QdIwo8JWPDT4FN9
	 kBeMx4O2b0iB8lDg4n1adNfTR/XBxgh4u3FwORtk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 443C7F8019D;
	Fri, 27 Nov 2020 17:43:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8F6CF8029B; Fri, 27 Nov 2020 17:43:03 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A007F800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 17:42:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A007F800EA
IronPort-SDR: iLIu9jqB8VUeprrABylIFVsZ3lpFZLx0Rn/KtJSbUluZJs+6VvBoFihybacJ0cItGT7o3UTrZs
 st5ftRtl0flQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="234020270"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; d="scan'208";a="234020270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2020 08:42:53 -0800
IronPort-SDR: 3QSX9kWrvVLjvf+SBa9jngB2Rzsz2uDxCx0/0eF/+Wfl8yvWr3RgyJTPaWxkTgh0JcAAqTFnQI
 OSSBl53x8uaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; d="scan'208";a="403933343"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga001.jf.intel.com with ESMTP; 27 Nov 2020 08:42:51 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/5] ASoC: SOF: ops: add parse_platform_ext_manifest() op
Date: Fri, 27 Nov 2020 18:40:18 +0200
Message-Id: <20201127164022.2498406-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127164022.2498406-1-kai.vehmanen@linux.intel.com>
References: <20201127164022.2498406-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, Fred Oh <fred.oh@linux.intel.com>,
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

From: Fred Oh <fred.oh@linux.intel.com>

Add parse_platform_ext_manifest() op to parse platform-specific config
data in the extended manifest.

Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/sof/ext_manifest.h |  1 +
 sound/soc/sof/loader.c           |  3 +++
 sound/soc/sof/ops.h              | 10 ++++++++++
 sound/soc/sof/sof-priv.h         |  5 +++++
 4 files changed, 19 insertions(+)

diff --git a/include/sound/sof/ext_manifest.h b/include/sound/sof/ext_manifest.h
index e05cb21023e5..7abc4f0bd3ad 100644
--- a/include/sound/sof/ext_manifest.h
+++ b/include/sound/sof/ext_manifest.h
@@ -62,6 +62,7 @@ enum sof_ext_man_elem_type {
 	SOF_EXT_MAN_ELEM_CC_VERSION		= SOF_IPC_EXT_CC_INFO,
 	SOF_EXT_MAN_ELEM_DBG_ABI		= SOF_IPC_EXT_USER_ABI_INFO,
 	SOF_EXT_MAN_ELEM_CONFIG_DATA		= 5, /**< ABI3.17 */
+	SOF_EXT_MAN_ELEM_PLATFORM_CONFIG_DATA   = 6,
 };
 
 /* extended manifest element header */
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 2a8c9bff9963..cbce484b6469 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -330,6 +330,9 @@ static int snd_sof_fw_ext_man_parse(struct snd_sof_dev *sdev,
 		case SOF_EXT_MAN_ELEM_CONFIG_DATA:
 			ret = ext_man_get_config_data(sdev, elem_hdr);
 			break;
+		case SOF_EXT_MAN_ELEM_PLATFORM_CONFIG_DATA:
+			ret = snd_sof_dsp_parse_platform_ext_manifest(sdev, elem_hdr);
+			break;
 		default:
 			dev_info(sdev->dev, "unknown sof_ext_man header type %d size 0x%X\n",
 				 elem_hdr->type, elem_hdr->size);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index b21632f5511a..77a6ac157d37 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -100,6 +100,16 @@ static inline int snd_sof_dsp_post_fw_run(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+/* parse platform specific extended manifest */
+static inline int snd_sof_dsp_parse_platform_ext_manifest(struct snd_sof_dev *sdev,
+							  const struct sof_ext_man_elem_header *hdr)
+{
+	if (sof_ops(sdev)->parse_platform_ext_manifest)
+		return sof_ops(sdev)->parse_platform_ext_manifest(sdev, hdr);
+
+	return 0;
+}
+
 /* misc */
 
 /**
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index d8bc0178dc89..32d6ceb41fdd 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -18,6 +18,7 @@
 #include <sound/sof/pm.h>
 #include <sound/sof/trace.h>
 #include <uapi/sound/sof/fw.h>
+#include <sound/sof/ext_manifest.h>
 
 /* debug flags */
 #define SOF_DBG_ENABLE_TRACE	BIT(0)
@@ -208,6 +209,10 @@ struct snd_sof_dsp_ops {
 	int (*pre_fw_run)(struct snd_sof_dev *sof_dev); /* optional */
 	int (*post_fw_run)(struct snd_sof_dev *sof_dev); /* optional */
 
+	/* parse platform specific extended manifest, optional */
+	int (*parse_platform_ext_manifest)(struct snd_sof_dev *sof_dev,
+					   const struct sof_ext_man_elem_header *hdr);
+
 	/* DSP PM */
 	int (*suspend)(struct snd_sof_dev *sof_dev,
 		       u32 target_state); /* optional */
-- 
2.28.0

