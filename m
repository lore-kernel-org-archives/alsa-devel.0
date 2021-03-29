Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205A3C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 11:32:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816786193A
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 11:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816786193A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4EED1666;
	Mon, 29 Mar 2021 13:31:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4EED1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617017524;
	bh=KF0v+I5hJHKVCDX2ARFXTH/9gQTzz2S2WI1A4WnGe7Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6if399ijZyb3aGm+jtP5Ju4IKIdmdt37kZ+JNCU4BeWOo5qmhGDCSlYyLty4L/SP
	 P6GSj94hV/TPylR9ppyTj5ucGlyz/lhyvzzFI8B0mlydqthUFEvRtVCwu5F+Uv2WUR
	 DSaGn2ecR04RpC5AqCtiZjBsMDjj6puwhL9gfYug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41357F800B9;
	Mon, 29 Mar 2021 13:31:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52CEDF8016E; Mon, 29 Mar 2021 13:31:13 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEB9CF80157
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 13:31:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEB9CF80157
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2B51EB46C
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 11:31:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: hda: Add missing sanity checks in PM
 prepare/complete callbacks
Date: Mon, 29 Mar 2021 13:30:59 +0200
Message-Id: <20210329113059.25035-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329113059.25035-1-tiwai@suse.de>
References: <20210329113059.25035-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The recently added PM prepare and complete callbacks don't have the
sanity check whether the card instance has been properly initialized,
which may potentially lead to Oops.

This patch adds the azx_is_pm_ready() call in each place
appropriately like other PM callbacks.

Fixes: f5dac54d9d93 ("ALSA: hda: Separate runtime and system suspend")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 12e51ac973c4..8a74b5818e91 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1023,6 +1023,9 @@ static int azx_prepare(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
 
+	if (!azx_is_pm_ready(card))
+		return 0;
+
 	chip = card->private_data;
 	chip->pm_prepared = 1;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
@@ -1038,6 +1041,9 @@ static void azx_complete(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
 
+	if (!azx_is_pm_ready(card))
+		return;
+
 	chip = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	chip->pm_prepared = 0;
-- 
2.26.2

