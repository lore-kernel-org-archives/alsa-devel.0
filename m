Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991DCA9EA0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:11:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6062B2053B
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Efj5WOu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6062B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41DFF1ED8;
	Mon, 28 Oct 2019 09:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41DFF1ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572250313;
	bh=3OExLpB6Ap75gWos5e94w8ZIYf40pluYxUq9j9NLSpA=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Efj5WOu4NwkhJOL87K/GiYZ7MJN06NtyU9ya6oahpSuP07VU+W6vDPdfn3stxhIqw
	 XgLf+vkkgZ20rBPepavcO9CuVar10WIUfpCvoICLEMRWny1ZRpRatONCXdlzhZEWAF
	 7VIKsX4f0+CCkrbyVpbN+WdpFDNmVQAMPCgi8Ios=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF160F802BD;
	Mon, 28 Oct 2019 09:11:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A19FF8011D; Mon, 28 Oct 2019 09:11:02 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 882F2F8011D
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 09:10:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 882F2F8011D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 50DFBB4E1;
 Mon, 28 Oct 2019 08:10:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon, 28 Oct 2019 09:10:56 +0100
Message-Id: <20191028081056.22010-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Jonas Witschel <diabonas@gmx.de>, Chris Wilson <chris@chris-wilson.co.uk>
Subject: [alsa-devel] [PATCH] Revert "ALSA: hda: Flush interrupts on
	disabling"
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

This reverts commit caa8422d01e983782548648e125fd617cadcec3f.

It turned out that this commit caused a regression at shutdown /
reboot, as the synchronize_irq() calls seems blocking the whole
shutdown.  Also another part of the change about shuffling the call
order looks suspicious; the azx_stop_chip() call disables the CORB /
RIRB while the others may still need the CORB/RIRB update.

Since the original commit itself was a cargo-fix, let's revert the
whole patch.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205333
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_controller.c | 2 --
 sound/pci/hda/hda_intel.c   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index d3999e7b0705..7e7be8e4dcf9 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -447,8 +447,6 @@ static void azx_int_disable(struct hdac_bus *bus)
 	list_for_each_entry(azx_dev, &bus->stream_list, list)
 		snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_INT_MASK, 0);
 
-	synchronize_irq(bus->irq);
-
 	/* disable SIE for all streams */
 	snd_hdac_chip_writeb(bus, INTCTL, 0);
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a815bc811799..cf53fbd872ee 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1348,9 +1348,9 @@ static int azx_free(struct azx *chip)
 	}
 
 	if (bus->chip_init) {
-		azx_stop_chip(chip);
 		azx_clear_irq_pending(chip);
 		azx_stop_all_streams(chip);
+		azx_stop_chip(chip);
 	}
 
 	if (bus->irq >= 0)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
