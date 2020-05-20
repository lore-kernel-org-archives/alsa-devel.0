Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDDC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 17:03:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932C7206B6
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 17:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hSViUXJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932C7206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED3E11812;
	Wed, 20 May 2020 19:02:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED3E11812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589994182;
	bh=KbsaQSj9zMD6i/sJHtr+ut7s5Ffd82I8gbNiODWWZEM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hSViUXJpJ7GdlMEQ2uD6dXoh/wx20vR5e3V3REITFY2YVM2RYSeh+jPYe36NrFjtz
	 lFV4cmGUtzrOwUej4d2piTmOw/AtY50QVEINc0QNWGRJ4nLhbPuESehQOuzqPO87yF
	 +NpicfK3Fcr/Lh1KZCk2DlRYBoJscPNTAUL1EHEc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD477F8029B;
	Wed, 20 May 2020 18:59:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68E54F8025E; Wed, 20 May 2020 18:59:38 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6225EF801F9
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 18:59:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6225EF801F9
IronPort-SDR: KR81/IpZerF4DtKHrgaDUlhY1A0qRgXHSh1Ea51QiXjV//t8LKPrrCDiw44yTUvU0HYYzgnJEy
 SIGz1n7dW1zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 09:59:27 -0700
IronPort-SDR: RrqN2sJzWVNoNA4+IsoXn6WOEuV8wvHDRRep9uPtb8uo5GVEJeoK9DCD0XGDXlJNmUkOJmaWuH
 877CBv+H8sDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; d="scan'208";a="412085934"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 20 May 2020 09:59:25 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 4/5] ASoC: SOF: ext_manifest: parse windows
Date: Wed, 20 May 2020 19:59:10 +0300
Message-Id: <20200520165911.21696-5-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520165911.21696-1-kai.vehmanen@linux.intel.com>
References: <20200520165911.21696-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Karol Trzcinski <karolx.trzcinski@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

The window description can be extracted from the extended manifest
content. This information known at build time does not need to be
provided in a mailbox.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/sof/ext_manifest.h |  8 ++++++++
 sound/soc/sof/loader.c           | 25 +++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/ext_manifest.h b/include/sound/sof/ext_manifest.h
index 6ed787eb788c..0001fc5779ef 100644
--- a/include/sound/sof/ext_manifest.h
+++ b/include/sound/sof/ext_manifest.h
@@ -58,6 +58,7 @@ struct sof_ext_man_header {
 /* Extended manifest elements types */
 enum sof_ext_man_elem_type {
 	SOF_EXT_MAN_ELEM_FW_VERSION		= 0,
+	SOF_EXT_MAN_ELEM_WINDOW			= SOF_IPC_EXT_WINDOW,
 };
 
 /* extended manifest element header */
@@ -76,4 +77,11 @@ struct sof_ext_man_fw_version {
 	uint32_t flags;
 } __packed;
 
+/* extended data memory windows for IPC, trace and debug */
+struct sof_ext_man_window {
+	struct sof_ext_man_elem_header hdr;
+	/* use sof_ipc struct because of code re-use */
+	struct sof_ipc_window ipc_window;
+} __packed;
+
 #endif /* __SOF_FIRMWARE_EXT_MANIFEST_H__ */
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 8b42613304a7..6e92a1285b91 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -20,13 +20,21 @@ static int get_ext_windows(struct snd_sof_dev *sdev,
 {
 	const struct sof_ipc_window *w =
 		container_of(ext_hdr, struct sof_ipc_window, ext_hdr);
+	size_t w_size = struct_size(w, window, w->num_windows);
 
 	if (w->num_windows == 0 || w->num_windows > SOF_IPC_MAX_ELEMS)
 		return -EINVAL;
 
+	if (sdev->info_window) {
+		if (memcmp(sdev->info_window, w, w_size)) {
+			dev_err(sdev->dev, "error: mismatch between window descriptor from extended manifest and mailbox");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
 	/* keep a local copy of the data */
-	sdev->info_window = kmemdup(w, struct_size(w, window, w->num_windows),
-				    GFP_KERNEL);
+	sdev->info_window = kmemdup(w, w_size, GFP_KERNEL);
 	if (!sdev->info_window)
 		return -ENOMEM;
 
@@ -140,6 +148,16 @@ static int ext_man_get_fw_version(struct snd_sof_dev *sdev,
 	return snd_sof_ipc_valid(sdev);
 }
 
+static int ext_man_get_windows(struct snd_sof_dev *sdev,
+			       const struct sof_ext_man_elem_header *hdr)
+{
+	const struct sof_ext_man_window *w;
+
+	w = container_of(hdr, struct sof_ext_man_window, hdr);
+
+	return get_ext_windows(sdev, &w->ipc_window.ext_hdr);
+}
+
 static ssize_t snd_sof_ext_man_size(const struct firmware *fw)
 {
 	const struct sof_ext_man_header *head;
@@ -213,6 +231,9 @@ static int snd_sof_fw_ext_man_parse(struct snd_sof_dev *sdev,
 		case SOF_EXT_MAN_ELEM_FW_VERSION:
 			ret = ext_man_get_fw_version(sdev, elem_hdr);
 			break;
+		case SOF_EXT_MAN_ELEM_WINDOW:
+			ret = ext_man_get_windows(sdev, elem_hdr);
+			break;
 		default:
 			dev_warn(sdev->dev, "warning: unknown sof_ext_man header type %d size 0x%X\n",
 				 elem_hdr->type, elem_hdr->size);
-- 
2.26.2

