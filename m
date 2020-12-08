Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5ADC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 18:11:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24D823B54
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 18:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24D823B54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C1BA1697;
	Tue,  8 Dec 2020 19:10:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C1BA1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607451099;
	bh=jtoRVfSnTR6uvkCkevRlv1GFLRt6Do4me7pk+woPeAA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mfSvfS/XgovDXZov87Pw+9zuvuL9n2d2OyF1dBvNvCv3+tiSHGbasANl+ayMZAd1w
	 U/+oeByIUGN+RxXwXc8nTM9iVzp5NzlOOQiVgtvFXekt8FTHcuNoWD8bWG+/2F+J7j
	 qKkIEVvOnsm9BF3FJ6wUD1ucgj31vK7oyLaKsm9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D15D4F8010A;
	Tue,  8 Dec 2020 19:10:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3AF5F8019D; Tue,  8 Dec 2020 19:10:47 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1E6FF8010A
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 19:10:41 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C50BCA003E;
 Tue,  8 Dec 2020 19:10:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C50BCA003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607451040; bh=lP24/kVk08TtUPodXu+hHcP/J6uDrkuoevZ4U3U14K8=;
 h=From:To:Cc:Subject:Date:From;
 b=rdg5R31ySlRLAvSuSdBoAw6PgCdiIHjwiEg/nVi1NpdDdcz81hl5sddRVLzC1RcgE
 txrIUqn2N0wQzE4UYTuO/3wHQPbstBEikrKeePRtoeV0fU8/9z5k83R676DF8Er2bk
 1GAVFjsYqsOSbC6K8Bmp72lNPNcIf/IQxhwK2KmE=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  8 Dec 2020 19:10:37 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: AMD Raven/Renoir - fix the PCI probe (PCI revision)
Date: Tue,  8 Dec 2020 19:10:33 +0100
Message-Id: <20201208181033.2745563-1-perex@perex.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

The Raven and Renoir ACP can be distinguished by the PCI revision.
Let's do the check very early, otherwise the wrong probe code
can be run.

Link: https://lore.kernel.org/alsa-devel/2e4587f8-f602-cf23-4845-fd27a32b1cfc@amd.com/
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/amd/raven/pci-acp3x.c     | 4 ++++
 sound/soc/amd/renoir/rn-pci-acp3x.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 31b797c8bfe6..77f2d9389606 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -118,6 +118,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	int ret, i;
 	u32 addr, val;
 
+	/* Raven device detection */
+	if (pci->revision != 0x00)
+		return -ENODEV;
+
 	if (pci_enable_device(pci)) {
 		dev_err(&pci->dev, "pci_enable_device failed\n");
 		return -ENODEV;
diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 60a3e2f442db..338b78c514ec 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -188,6 +188,10 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	int ret, index;
 	u32 addr;
 
+	/* Renoir device check */
+	if (pci->revision != 0x01)
+		return -ENODEV;
+
 	if (pci_enable_device(pci)) {
 		dev_err(&pci->dev, "pci_enable_device failed\n");
 		return -ENODEV;
-- 
2.26.2
