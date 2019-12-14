Return-Path: <SRS0=xxPz=2E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBBC43603
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 17:53:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2D420724
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 17:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jq7he1O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2D420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44261165F;
	Sat, 14 Dec 2019 18:52:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44261165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576345998;
	bh=ufiuq1VIM1Y/Xm/vox1gsD1UjQskvXfjesfWFe066SE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jq7he1O13QfpFMrsbRG4ZI9b1n05SNvpxozjNAA4sxL91IV7dPN3188b0ki30YMK/
	 GOdfiHw582IzdprON5WehUjPHO2ADi2nU9ibS9u9CG2mw6cuDp1sg4bMGbUyH9CpSS
	 cLnKDrNZyePRRjDjuir8MYt/oY9z20+VpbnkVbDs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 176A9F801D8;
	Sat, 14 Dec 2019 18:52:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8576F8020C; Sat, 14 Dec 2019 18:52:24 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2131EF8014F
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2019 18:52:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2131EF8014F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F387CABBD
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2019 17:52:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sat, 14 Dec 2019 18:52:17 +0100
Message-Id: <20191214175217.31852-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: hda: Fix regression by strip mask fix
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

The commit e38e486d66e2 ("ALSA: hda: Modify stream stripe mask only
when needed") tried to address the regression by the unconditional
application of the stripe mask, but this caused yet another
regression for the previously working devices.  Namely, the patch
clears the azx_dev->stripe flag at snd_hdac_stream_clear(), but this
may be called multiple times before restarting the stream, so this
ended up with clearance of the flag for the whole time.

This patch fixes the regression by moving the azx_dev->stripe flag
clearance at the counter-part, the close callback of HDMI codec
driver instead.

Fixes: e38e486d66e2 ("ALSA: hda: Modify stream stripe mask only when needed")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205855
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204477
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_stream.c    | 4 +---
 sound/pci/hda/patch_hdmi.c | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index f9707fb05efe..682ed39f79b0 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -120,10 +120,8 @@ void snd_hdac_stream_clear(struct hdac_stream *azx_dev)
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				SD_CTL_DMA_START | SD_INT_MASK, 0);
 	snd_hdac_stream_writeb(azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
-	if (azx_dev->stripe) {
+	if (azx_dev->stripe)
 		snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK, 0);
-		azx_dev->stripe = 0;
-	}
 	azx_dev->running = false;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_clear);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78647ee02339..630b1f5c276d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2021,6 +2021,8 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		per_cvt->assigned = 0;
 		hinfo->nid = 0;
 
+		azx_stream(get_azx_dev(substream))->stripe = 0;
+
 		mutex_lock(&spec->pcm_lock);
 		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 		clear_bit(pcm_idx, &spec->pcm_in_use);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
