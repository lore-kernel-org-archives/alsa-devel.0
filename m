Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA7EC47094
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 16:13:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6144A61477
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 16:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6144A61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20A361678;
	Mon,  7 Jun 2021 18:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20A361678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623082432;
	bh=5TPLlNjg+rAFTrvhsrCBzcvPB6QcO6Yb61jNIL906sA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BbpSSyQwCG2a1NhBgIqbA2dsHzw2HTrZTkb+SrK1OM9iqFboYiHZQ2bvnexBv9WIG
	 bqFXaamClzLfu5+59fD8PHu3FUbb0bT2+00QBhzL/EKF1X7ccFFSKm0P4zbubj798H
	 DEhmD0CIYre7XsM03MlLrL8+X01RDN6v3fONvfsk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94FF1F8020D;
	Mon,  7 Jun 2021 18:13:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E1FEF80212; Mon,  7 Jun 2021 18:13:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FEAFF801EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 18:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FEAFF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cNz5feNV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8232C613BD;
 Mon,  7 Jun 2021 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082369;
 bh=5TPLlNjg+rAFTrvhsrCBzcvPB6QcO6Yb61jNIL906sA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cNz5feNVSsSvI7PArvBiWMJwUCHJ0o5H7/cOtWshLKmzlOa12S8qSpoM3UvVasSAU
 YdBdkKyAH1bJEW/ksmomNDvNIo0ab0cowwlViqdgGeAVXlE/z/cbWJzcBvsA4au2Ra
 0Cq6ucITCRXzd1O9Y/iSrVO1OjiQ7dW0Pw4E3iCma9AE2G7evyZqGUabCbFYrBga4m
 hiq9fpRY6mDRsYwOrbq2aRhuShsQFsQ+KqWzk0NhC0Pt2kcVI47tWF2nB6O7wn6rlP
 oUNb5YbL6qMsRsige7c/XiN8N9IbdWV437iZnkiwN35bzcK3hb4NoPv2UV53e2qRlW
 o79ywJyNw87Dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 27/49] ALSA: hda: Add AlderLake-M PCI ID
Date: Mon,  7 Jun 2021 12:11:53 -0400
Message-Id: <20210607161215.3583176-27-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161215.3583176-1-sashal@kernel.org>
References: <20210607161215.3583176-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 4ad7935df6a566225c3d51900bde8f2f0f8b6de3 ]

Add HD Audio PCI ID for Intel AlderLake-M. Add rules to
snd_intel_dsp_find_config() to choose SOF driver for ADL-M systems with
PCH-DMIC or Soundwire codecs, and legacy driver for the rest.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210528185123.48332-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 4 ++++
 sound/pci/hda/hda_intel.c    | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index ab5ff7867eb9..d8be146793ee 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -331,6 +331,10 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x51c8,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x51cc,
+	},
 #endif
 
 };
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 79ade335c8a0..470753b36c8a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2485,6 +2485,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Alderlake-P */
 	{ PCI_DEVICE(0x8086, 0x51c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Alderlake-M */
+	{ PCI_DEVICE(0x8086, 0x51cc),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Elkhart Lake */
 	{ PCI_DEVICE(0x8086, 0x4b55),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
-- 
2.30.2

