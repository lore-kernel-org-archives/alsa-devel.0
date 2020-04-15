Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF9C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F7120774
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XNN/ist2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F7120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 254431670;
	Wed, 15 Apr 2020 22:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 254431670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586982748;
	bh=WQQcrPTA3bP7Hn5ajHe2JQ8wwZLYpR9igMLVX0Ctm0E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNN/ist2lzyQmfEWsbuXLcoprtBp5uV+ogTpdprmF0fjTgZ7atDmKeuOKKOp/EtKg
	 XPQjArBhAs3SPX/kgy7qYV7H76ZJ9nLJ+GHXUXDoIyKUMOMDMe9xgt/iitALBo0/Ky
	 tJq6Yi/5uIOSji//SvkBiv94/uSxHBSjgtEa+lgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E55BF802A1;
	Wed, 15 Apr 2020 22:29:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1C48F80291; Wed, 15 Apr 2020 22:29:05 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43524F80266
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 22:28:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43524F80266
IronPort-SDR: d/Lc+C8WW4sAK5l+IXHkQQOXxf/wlMlGvhP8/BquUIi1xn/F794zghJ5OLjxuOa1D3xkRllaqX
 BW/yHKWkwxaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 13:28:58 -0700
IronPort-SDR: fNfL5PqCv3U69nn0X4yEez9ptI4hLQFYBlBC37Yc7evDZ7csyVDoB0pr2XGg0mwUWHuWNHsWrm
 PGdaiI+DM5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="288656254"
Received: from jplam-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.82.197])
 by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2020 13:28:57 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/24] ASoC: SOF: ext_manifest: parse windows
Date: Wed, 15 Apr 2020 15:27:58 -0500
Message-Id: <20200415202816.934-7-pierre-louis.bossart@linux.intel.com>
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

The window description can be extracted from the extended manifest
content. This information known at build time does not need to be
provided in a mailbox.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/uapi/sound/sof/ext_manifest.h |  9 +++++++++
 sound/soc/sof/loader.c                | 27 +++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/sof/ext_manifest.h b/include/uapi/sound/sof/ext_manifest.h
index 163d32210ad8..203c203f6531 100644
--- a/include/uapi/sound/sof/ext_manifest.h
+++ b/include/uapi/sound/sof/ext_manifest.h
@@ -17,6 +17,7 @@
 #define __SOF_FIRMWARE_EXT_MANIFEST_H__
 
 #include <linux/const.h>
+#include <sound/sof/info.h>
 
 /* In ASCII `XMan` */
 #define SOF_EXT_MAN_MAGIC_NUMBER	0x6e614d58
@@ -54,6 +55,7 @@ struct sof_ext_man_header {
 /* Extended manifest elements types */
 enum sof_ext_man_elem_type {
 	SOF_EXT_MAN_ELEM_FW_VERSION		= 0,
+	SOF_EXT_MAN_ELEM_WINDOW			= SOF_IPC_EXT_WINDOW,
 };
 
 /* extended manifest element header */
@@ -71,4 +73,11 @@ struct sof_ext_man_fw_version {
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
index 01077c1ce235..bbfdf07fa6f5 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -20,13 +20,21 @@ static int get_ext_windows(struct snd_sof_dev *sdev,
 {
 	const struct sof_ipc_window *w =
 		container_of(ext_hdr, struct sof_ipc_window, ext_hdr);
+	size_t w_size = struct_size(w, window, w->num_windows);
+
+	if (sdev->info_window) {
+		if (memcmp(sdev->info_window, w, w_size)) {
+			dev_err(sdev->dev, "error: mistmatch between window descriptor from extended manifest and mailbox");
+			return -EINVAL;
+		}
+		return 0;
+	}
 
 	if (w->num_windows == 0 || w->num_windows > SOF_IPC_MAX_ELEMS)
 		return -EINVAL;
 
 	/* keep a local copy of the data */
-	sdev->info_window = kmemdup(w, struct_size(w, window, w->num_windows),
-				    GFP_KERNEL);
+	sdev->info_window = kmemdup(w, w_size, GFP_KERNEL);
 	if (!sdev->info_window)
 		return -ENOMEM;
 
@@ -141,6 +149,18 @@ static int ext_man_get_fw_version(struct snd_sof_dev *sdev,
 	return snd_sof_ipc_valid(sdev);
 }
 
+static int ext_man_get_windows(struct snd_sof_dev *sdev,
+			       const struct sof_ext_man_elem_header *hdr)
+{
+	const struct sof_ipc_ext_data_hdr *w_ipc;
+	const struct sof_ext_man_window *w;
+
+	w = container_of(hdr, struct sof_ext_man_window, hdr);
+	w_ipc = (const struct sof_ipc_ext_data_hdr *)&w->ipc_window;
+
+	return get_ext_windows(sdev, w_ipc);
+}
+
 static ssize_t snd_sof_ext_man_size(const struct firmware *fw)
 {
 	const struct sof_ext_man_header *head = (void *)fw->data;
@@ -218,6 +238,9 @@ static int snd_sof_fw_ext_man_parse(struct snd_sof_dev *sdev,
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
2.20.1

