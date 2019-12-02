Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA736C432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:50:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CD021774
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dGMAGz2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CD021774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3394C15E4;
	Mon,  2 Dec 2019 08:49:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3394C15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575273047;
	bh=y3A6U6F+N5kPFvGmA2u30IuwNefVoFHViLeCVlbRiU8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dGMAGz2Ss1AUr8c7AkBay2LzeWYTodWhERs3vqX8mzpJ6h7p5bMIIypRAmXIoP7BW
	 fPOQzhQyy5M2NvnzPZnjA5yy1ivRvrljqgNUYUNeEQpRdithMfV1x0mN4ZQm1Z07vv
	 5JeNZ4G/FLyHyubRpS3MVIZQIc/2zm18Wg0I5MVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2C53F800F0;
	Mon,  2 Dec 2019 08:49:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E1AAF80214; Mon,  2 Dec 2019 08:49:54 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2BA2F800F0
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 08:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2BA2F800F0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 04C38B14A
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 07:49:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  2 Dec 2019 08:49:47 +0100
Message-Id: <20191202074947.1617-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: hda: Modify stream stripe mask only when
	needed
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

The recent in HD-audio stream management for changing the stripe
control seems causing a regression on some platforms.  The stripe
control is currently used only by HDMI codec, and applying the stripe
mask unconditionally may lead to scratchy and static noises as seen on
some MacBooks.

For addressing the regression, this patch changes the stream
management code to apply the stripe mask conditionally only when the
codec driver requested.

Fixes: 9b6f7e7a296e ("ALSA: hda: program stripe bits for controller")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204477
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h    |  1 +
 sound/hda/hdac_stream.c    | 19 ++++++++++++-------
 sound/pci/hda/patch_hdmi.c |  5 +++++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index b260c5fd2337..e05b95e83d5a 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -493,6 +493,7 @@ struct hdac_stream {
 	bool prepared:1;
 	bool no_period_wakeup:1;
 	bool locked:1;
+	bool stripe:1;			/* apply stripe control */
 
 	/* timestamp */
 	unsigned long start_wallclk;	/* start + minimum wallclk */
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index d8fe7ff0cd58..f9707fb05efe 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -96,12 +96,14 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 			      1 << azx_dev->index,
 			      1 << azx_dev->index);
 	/* set stripe control */
-	if (azx_dev->substream)
-		stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
-	else
-		stripe_ctl = 0;
-	snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK,
-				stripe_ctl);
+	if (azx_dev->stripe) {
+		if (azx_dev->substream)
+			stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
+		else
+			stripe_ctl = 0;
+		snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK,
+					stripe_ctl);
+	}
 	/* set DMA start and interrupt mask */
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				0, SD_CTL_DMA_START | SD_INT_MASK);
@@ -118,7 +120,10 @@ void snd_hdac_stream_clear(struct hdac_stream *azx_dev)
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				SD_CTL_DMA_START | SD_INT_MASK, 0);
 	snd_hdac_stream_writeb(azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
-	snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK, 0);
+	if (azx_dev->stripe) {
+		snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK, 0);
+		azx_dev->stripe = 0;
+	}
 	azx_dev->running = false;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_clear);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0032bba8cc9d..ed4e98a1057a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -32,6 +32,7 @@
 #include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_jack.h"
+#include "hda_controller.h"
 
 static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
@@ -1249,6 +1250,10 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
 
+	/* flip stripe flag for the assigned stream if supported */
+	if (get_wcaps(codec, per_cvt->cvt_nid) & AC_WCAP_STRIPE)
+		azx_stream(get_azx_dev(substream))->stripe = 1;
+
 	snd_hda_set_dev_select(codec, per_pin->pin_nid, per_pin->dev_id);
 	snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
 			    AC_VERB_SET_CONNECT_SEL,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
