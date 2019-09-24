Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB0C432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:56:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C133D20872
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="azVKzuwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C133D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35414169F;
	Tue, 24 Sep 2019 07:55:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35414169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569304605;
	bh=HNOkwV4HOIE3GxiTa7AKfkYD1qQQ7IOacoyjt+96D7A=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=azVKzuweldsxCQhA5CUYmxtByBN1XMvmfkUGBVnPpIPN0UWwXUYjV5YO7a08FmMeX
	 3GHMfG+cZSuAsObBmjmBN66iqeeBJ0WA7pWTMZPr86wv19hg9HYyzoArQqaaE2Kp0s
	 bYtlqjD4Gk986InWIE40Z13hW1BK7yzL36HZA7xM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F804F803F4;
	Tue, 24 Sep 2019 07:55:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C82AF8045F; Tue, 24 Sep 2019 07:55:53 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49647F80213
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 07:55:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49647F80213
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Sep 2019 22:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; d="scan'208";a="388743625"
Received: from chrome-audio.sc.intel.com ([172.25.206.186])
 by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2019 22:55:47 -0700
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
To: tiwai@suse.de,
	broonie@kernel.org
Date: Mon, 23 Sep 2019 22:37:23 -0700
Message-Id: <1569303443-6838-1-git-send-email-sathyanarayana.nujella@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 yung-chuan.liao@linux.intel.com, Joyce Toh <joyce.toh@intel.com>
Subject: [alsa-devel] [PATCH] ALSA: hda - Force polling mode on CML for
	fixing codec communication
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

We observed the same issue as reported by commit a8d7bde23e7130686b7662
("ALSA: hda - Force polling mode on CFL for fixing codec communication")
Apply the same fix to CML.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Joyce Toh <joyce.toh@intel.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 91e71be42fa4..e6997a5bf098 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -370,6 +370,7 @@ enum {
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
 #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 #define IS_CNL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9dc8)
+#define IS_CML(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x02c8)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -1754,7 +1755,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 		azx_bus(chip)->dma_type = SNDRV_DMA_TYPE_DEV_UC;
 
 	/* Workaround for a communication error on CFL (bko#199007) and CNL */
-	if (IS_CFL(pci) || IS_CNL(pci))
+	if (IS_CFL(pci) || IS_CNL(pci) || IS_CML(pci))
 		azx_bus(chip)->polling_mode = 1;
 
 	if (chip->driver_type == AZX_DRIVER_NVIDIA) {
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
