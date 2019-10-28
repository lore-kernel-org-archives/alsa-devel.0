Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34ACCA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:07:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A53B214D9
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jf3R/soJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A53B214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A3761F00;
	Mon, 28 Oct 2019 14:06:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A3761F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572268058;
	bh=ismRquiffIWbp8WRPno7AR11DWEnEJseE1uexRJSuk8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jf3R/soJ/AzTw6UESJN/ZkJD90VydL1PaT2JI+DrYaZM17w13IubSeBEr2KR3fT0n
	 nBS9lsgsFWBiheVg5RDKUSNIgizLhh5M/97jBlk063of0XYeuwzGgt2rbkE+Hx4XlT
	 cueoWBBmPI52NqTQotk0T38YtGdex02PoWU5cGTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF3ECF802BD;
	Mon, 28 Oct 2019 14:06:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D98E5F80361; Mon, 28 Oct 2019 14:06:46 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8231CF8011D
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 14:06:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8231CF8011D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 68746B23A;
 Mon, 28 Oct 2019 13:06:43 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon, 28 Oct 2019 14:06:34 +0100
Message-Id: <20191028130634.3501-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH] ALSA: hda: Allow non-Intel device probe
	gracefully
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

The recent addition of snd_intel_dsp_driver_probe() check caused a
spurious kernel warning when the driver is loaded for a non-Intel
hardware due to snd_BUG_ON().  Moreover, for such a hardware, we
should always return SND_INTEL_DSP_DRIVER_ANY, not check the
dsp_driver option at all.

This patch fixes these issues for non-Intel devices.

Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/intel-dsp-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 0b2a7201a46a..be1df80ed013 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -307,13 +307,13 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 {
 	const struct config_entry *cfg;
 
-	if (dsp_driver > 0 && dsp_driver <= SND_INTEL_DSP_DRIVER_LAST)
-		return dsp_driver;
-
 	/* Intel vendor only */
-	if (snd_BUG_ON(pci->vendor != 0x8086))
+	if (pci->vendor != 0x8086)
 		return SND_INTEL_DSP_DRIVER_ANY;
 
+	if (dsp_driver > 0 && dsp_driver <= SND_INTEL_DSP_DRIVER_LAST)
+		return dsp_driver;
+
 	/*
 	 * detect DSP by checking class/subclass/prog-id information
 	 * class=04 subclass 03 prog-if 00: no DSP, use legacy driver
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
