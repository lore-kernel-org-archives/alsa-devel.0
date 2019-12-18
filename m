Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029CEC43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:28:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7872A2176D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EdobnFkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7872A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8936B1615;
	Wed, 18 Dec 2019 01:27:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8936B1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576628902;
	bh=oSpz3dGwRVqcsDlb33M2cfbt2uZEZRvbZyHQNwGKDX0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdobnFkSfKctVBwQEWJ46MgsJK0HqilxQ92aGLZzwgz3Huw8Mn2maoZp3HRadlizc
	 BVTY3/pjOgGZ7hXKJBe6HcclXn5+HaR82qS1G4HCisC6c2KjpBdTVYutJhCtYdorxV
	 hNAQGd7PS9RBMRH6q/3gR8vtsj7InB75RJV1N4Xw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDD66F8026F;
	Wed, 18 Dec 2019 01:26:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46B46F80266; Wed, 18 Dec 2019 01:26:38 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E619F80218
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 01:26:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E619F80218
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 16:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; d="scan'208";a="217974218"
Received: from dshoemak-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.3.243])
 by orsmga003.jf.intel.com with ESMTP; 17 Dec 2019 16:26:30 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 18:26:10 -0600
Message-Id: <20191218002616.7652-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218002616.7652-1-pierre-louis.bossart@linux.intel.com>
References: <20191218002616.7652-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, Karol Trzcinski <karolx.trzcinski@linux.intel.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/8] ASoC: SOF: define struct with compiler
	name and version
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Karol Trzcinski <karolx.trzcinski@linux.intel.com>

Add compiler information structure sof_ipc_cc_version.
Add new enum value in sof_ipc_ext_data for new structure.
This struct will be used to show more information about firmware
in host system. It will be helpful during debugging.

Signed-off-by: Karol Trzcinski <karolx.trzcinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/info.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
index a9156b4a062c..1c560144996c 100644
--- a/include/sound/sof/info.h
+++ b/include/sound/sof/info.h
@@ -30,6 +30,7 @@
 enum sof_ipc_ext_data {
 	SOF_IPC_EXT_DMA_BUFFER = 0,
 	SOF_IPC_EXT_WINDOW,
+	SOF_IPC_EXT_CC_INFO,
 };
 
 /* FW version - SOF_IPC_GLB_VERSION */
@@ -115,4 +116,18 @@ struct sof_ipc_window {
 	struct sof_ipc_window_elem window[];
 }  __packed;
 
+struct sof_ipc_cc_version {
+	struct sof_ipc_ext_data_hdr ext_hdr;
+	uint32_t major;
+	uint32_t minor;
+	uint32_t micro;
+
+	/* reserved for future use */
+	uint32_t reserved[4];
+
+	char name[16]; /* null terminated compiler name */
+	char optim[4]; /* null terminated compiler -O flag value */
+	char desc[]; /* null terminated compiler description */
+} __packed;
+
 #endif
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
