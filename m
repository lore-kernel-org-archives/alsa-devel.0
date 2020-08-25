Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C1C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 00:00:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D4B20738
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 00:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iof2BbqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D4B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF25716CB;
	Wed, 26 Aug 2020 01:59:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF25716CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598400004;
	bh=6SwUKOVKgprpP9xcYDQf/D4h+GGw0/1vhC7DorwTlEY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iof2BbqBb6+0DZR7jMMhRwkR6gWG9zUaOiG2dFSPlEAQz/Vwy7M/SxylFIoY7Fo2t
	 Tb7/Rcm/JhVvwu+cB8eIdeYzSWh8PLMJXbTBe94fLyEYesrUbRQpEk4jXitp4c7FWr
	 s6QnrsIqrmYpNeFNBhW9n8aqX8Y5FVi7r+m2C/5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AB6AF800EB;
	Wed, 26 Aug 2020 01:59:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66663F8026A; Wed, 26 Aug 2020 01:59:12 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D041F800D1
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 01:59:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D041F800D1
IronPort-SDR: uZ/En4WsjGKA2LBSotoX3FDRp+j4DvheILH1oZDga+PvEUCYdONbz7zkZTSki+CfMbtGEPG8pN
 /EDyylLJVTqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="135764549"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="135764549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 16:59:03 -0700
IronPort-SDR: Q/OHPjnjrzqW/7pVfv9O7Yi6m7gG1uESpdRW+r7n6KIgRYDFjK8ceg6gHQGKJnqQ0OYE9jKXtj
 7ocSyjXd1FIQ==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="474558903"
Received: from cdurvasu-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.42.42])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 16:59:03 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: SOF: IPC: make sof_ipc_window monosized
Date: Tue, 25 Aug 2020 16:58:51 -0700
Message-Id: <20200825235854.1588034-2-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825235854.1588034-1-ranjani.sridharan@linux.intel.com>
References: <20200825235854.1588034-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Karol Trzcinski <karolx.trzcinski@linux.intel.com>
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

This step is needed to add possibility to pack sof_ipc_window inside
another one in used FW build tools - for example in extended manifest.
Structure reusability leads to easy parsing function reuse, so source
code is shorter and easier to maintain.

Using structures with constant size is less tricky and properly
supported by each toolchain by contrast to variable size elements.

This is minor ABI change - backward compatibility is kept.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/sof/info.h     | 2 +-
 include/uapi/sound/sof/abi.h | 2 +-
 sound/soc/sof/loader.c       | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
index 5a55ba8b7e56..313e3e70c630 100644
--- a/include/sound/sof/info.h
+++ b/include/sound/sof/info.h
@@ -99,7 +99,7 @@ struct sof_ipc_window_elem {
 struct sof_ipc_window {
 	struct sof_ipc_ext_data_hdr ext_hdr;
 	uint32_t num_windows;
-	struct sof_ipc_window_elem window[];
+	struct sof_ipc_window_elem window[SOF_IPC_MAX_ELEMS];
 }  __packed;
 
 struct sof_ipc_cc_version {
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index d54be303090f..6af32f82fb99 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 16
+#define SOF_ABI_MINOR 17
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index b94fa5f5d480..25dc28ebafb7 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -20,13 +20,12 @@ static int get_ext_windows(struct snd_sof_dev *sdev,
 {
 	const struct sof_ipc_window *w =
 		container_of(ext_hdr, struct sof_ipc_window, ext_hdr);
-	size_t w_size = struct_size(w, window, w->num_windows);
 
 	if (w->num_windows == 0 || w->num_windows > SOF_IPC_MAX_ELEMS)
 		return -EINVAL;
 
 	if (sdev->info_window) {
-		if (memcmp(sdev->info_window, w, w_size)) {
+		if (memcmp(sdev->info_window, w, ext_hdr->hdr.size)) {
 			dev_err(sdev->dev, "error: mismatch between window descriptor from extended manifest and mailbox");
 			return -EINVAL;
 		}
@@ -34,7 +33,7 @@ static int get_ext_windows(struct snd_sof_dev *sdev,
 	}
 
 	/* keep a local copy of the data */
-	sdev->info_window = kmemdup(w, w_size, GFP_KERNEL);
+	sdev->info_window = kmemdup(w, ext_hdr->hdr.size, GFP_KERNEL);
 	if (!sdev->info_window)
 		return -ENOMEM;
 
-- 
2.25.1

