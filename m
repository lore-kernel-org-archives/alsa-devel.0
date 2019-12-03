Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34471C432C3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:42:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54C62070A
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CfVzdR9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54C62070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFA0E83D;
	Tue,  3 Dec 2019 16:41:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFA0E83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575387724;
	bh=ZVCCIxHL2GsOQbfRHk2od4GZuplVCUUSLIRxCGvZ/X8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CfVzdR9UkFeAP3qgI8TIbgT6e17qlha8BddCU00wPIvir8w3DzZio0bEkbXSiBlja
	 5E+lgJeOub9bp2fuHsH8u7M/3OMVi/QoCgjWURI9U4gAHOTMQOWMZYUeMEEVo5GYkb
	 3hUUlgGunrNu07nnKp4Ao8FTvhUOldQua4ZZpOjk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68E47F800B4;
	Tue,  3 Dec 2019 16:41:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC3DEF80227; Tue,  3 Dec 2019 16:41:12 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10724F800B4
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 16:41:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10724F800B4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C7C5569BB8;
 Tue,  3 Dec 2019 15:41:08 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  3 Dec 2019 16:41:05 +0100
Message-Id: <20191203154105.30414-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Nikhil Mahale <nmahale@nvidia.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH] ALSA: hda: hdmi - Keep old slot assignment
	behavior for Intel platforms
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

The commit 609f5485344b ("ALSA: hda: hdmi - preserve non-MST PCM
routing for Intel platforms") tried to restore the old behavior wrt
assignment of the PCM slot for Intel platforms, but this didn't do it
right.  As found in the later discussion, even on non-MST, a positive
pipe id is passed, which is equivalent with dev_id on Intel.

This patch reverts the previous attempt and applies a simpler
workaround instead.  Actually, for Intel platforms, we can handle as
if per_pin->dev_id=0, assign the primary slot at the first try.  This
assures the compatible behavior with the previous versions regarding
the slot assignment.

Fixes: 609f5485344b ("ALSA: hda: hdmi - preserve non-MST PCM routing for Intel platforms")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ed4e98a1057a..78647ee02339 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1348,21 +1348,18 @@ static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
 	 * with the legacy static per_pin-pcm assignment that existed in the
 	 * days before DP-MST.
 	 *
+	 * Intel DP-MST prefers this legacy behavior for compatibility, too.
+	 *
 	 * per_pin of m!=0 prefers to get pcm=(num_nids + (m - 1)).
 	 */
 
-	if (per_pin->dev_id == 0) {
+	if (per_pin->dev_id == 0 || spec->intel_hsw_fixup) {
 		if (!test_bit(per_pin->pin_nid_idx, &spec->pcm_bitmap))
 			return per_pin->pin_nid_idx;
 	} else {
 		i = spec->num_nids + (per_pin->dev_id - 1);
 		if (i < spec->pcm_used && !(test_bit(i, &spec->pcm_bitmap)))
 			return i;
-
-		/* keep legacy assignment for dev_id>0 on Intel platforms */
-		if (spec->intel_hsw_fixup)
-			if (!test_bit(per_pin->pin_nid_idx, &spec->pcm_bitmap))
-				return per_pin->pin_nid_idx;
 	}
 
 	/* have a second try; check the area over num_nids */
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
