Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40AAC2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:33:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDA520774
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RQeSnp6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB2FB852;
	Wed, 15 Apr 2020 22:32:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB2FB852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586982823;
	bh=DoFRzYxnsybYvvzTuN5KVIXploexFZ9pmYAGOYWSkqM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQeSnp6lT+DBg3MZW7G8JHqMk39MRRgFSZTyar4fuNpTkTuADXm2Im2eylbztNlEL
	 kxvQ4UTDSNHSiSrIxYkqVAUFy9RylEyVHlK2eK+A+YVYYtRQt2wmKkVbjRzCHXzrv3
	 VDBBayhyNoavnfe4ojshH1lbElmAAegcBxWXZcRg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2E23F802A9;
	Wed, 15 Apr 2020 22:29:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD316F8026A; Wed, 15 Apr 2020 22:29:06 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6860FF8025F
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 22:28:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6860FF8025F
IronPort-SDR: RLll9yyXYYgx8ZWK06B5F/InqdfBGWMhs7AZT/U5TEQ/Bxoh8daOggpeJgV3pCC+GxHbjGjk8t
 +VPnjxda1KpQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 13:28:57 -0700
IronPort-SDR: S9uNHn3jS/UyRMcPZzu0rgwvqlInaTIZmKSKi3Au/37ReObmXPAiTz87fpfaqJGAqDL/x/Q46K
 YTY2Kbcx9CDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="288656251"
Received: from jplam-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.82.197])
 by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2020 13:28:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/24] ASoC: SOF: ext_manifest: parse firmware version
Date: Wed, 15 Apr 2020 15:27:57 -0500
Message-Id: <20200415202816.934-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415202816.934-1-pierre-louis.bossart@linux.intel.com>
References: <20200415202816.934-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Karol Trzcinski <karolx.trzcinski@linux.intel.com>
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

The firmware version can be extracted from the extended
manifest content. This information known at build time
does not need to be provided in a mailbox.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/uapi/sound/sof/ext_manifest.h | 13 +++++++++++++
 sound/soc/sof/loader.c                | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/uapi/sound/sof/ext_manifest.h b/include/uapi/sound/sof/ext_manifest.h
index fc4d1bec0cb3..163d32210ad8 100644
--- a/include/uapi/sound/sof/ext_manifest.h
+++ b/include/uapi/sound/sof/ext_manifest.h
@@ -51,6 +51,11 @@ struct sof_ext_man_header {
 
 /* Now define extended manifest elements */
 
+/* Extended manifest elements types */
+enum sof_ext_man_elem_type {
+	SOF_EXT_MAN_ELEM_FW_VERSION		= 0,
+};
+
 /* extended manifest element header */
 struct sof_ext_man_elem_header {
 	uint32_t type;		/*< SOF_EXT_MAN_ELEM_ */
@@ -58,4 +63,12 @@ struct sof_ext_man_elem_header {
 	uint8_t blob[];		/*< type dependent content */
 } __packed;
 
+/* FW version */
+struct sof_ext_man_fw_version {
+	struct sof_ext_man_elem_header hdr;
+	/* use sof_ipc struct because of code re-use */
+	struct sof_ipc_fw_version version;
+	uint32_t flags;
+} __packed;
+
 #endif /* __SOF_FIRMWARE_EXT_MANIFEST_H__ */
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 6b354b6fb83a..01077c1ce235 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -127,6 +127,20 @@ int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset)
 }
 EXPORT_SYMBOL(snd_sof_fw_parse_ext_data);
 
+static int ext_man_get_fw_version(struct snd_sof_dev *sdev,
+				  const struct sof_ext_man_elem_header *hdr)
+{
+	const struct sof_ext_man_fw_version *v;
+
+	v = container_of(hdr, struct sof_ext_man_fw_version, hdr);
+
+	memcpy(&sdev->fw_ready.version, &v->version, sizeof(v->version));
+	sdev->fw_ready.flags = v->flags;
+
+	/* log ABI versions and check FW compatibility */
+	return snd_sof_ipc_valid(sdev);
+}
+
 static ssize_t snd_sof_ext_man_size(const struct firmware *fw)
 {
 	const struct sof_ext_man_header *head = (void *)fw->data;
@@ -201,6 +215,9 @@ static int snd_sof_fw_ext_man_parse(struct snd_sof_dev *sdev,
 
 		/* process structure data */
 		switch (elem_hdr->type) {
+		case SOF_EXT_MAN_ELEM_FW_VERSION:
+			ret = ext_man_get_fw_version(sdev, elem_hdr);
+			break;
 		default:
 			dev_warn(sdev->dev, "warning: unknown sof_ext_man header type %d size 0x%X\n",
 				 elem_hdr->type, elem_hdr->size);
-- 
2.20.1

