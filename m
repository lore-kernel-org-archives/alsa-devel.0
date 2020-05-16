Return-Path: <SRS0=yPb/=66=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A0C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:30:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C0F2075F
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D/WpYY1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C0F2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59B281663;
	Sat, 16 May 2020 08:30:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59B281663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589610653;
	bh=HiyzZpXqXimlQdI4oroZckn49dhAP4cYnc2b+eJrXHo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D/WpYY1rknHBbt7gPrCkrVRn8JtEop5du6KDxf8I9dptTeJ05Tot1rjoKXFVeiYYC
	 Urn+dqmaucxB2clTxHVAkSj+Tp3YFiYNCaydP8EeLgT/8ipCpBovFn8tv/iT42e+l+
	 kJhKFvfEYsFy0wthvTFV5fBjLisxHYWZ3s48fylA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68884F801F2;
	Sat, 16 May 2020 08:29:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45914F8014C; Sat, 16 May 2020 08:29:04 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EF1EF800E3
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 08:28:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EF1EF800E3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 133D4AEF9
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 06:29:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: hda: Drop unused snd_hda_queue_unsol_event()
Date: Sat, 16 May 2020 08:28:53 +0200
Message-Id: <20200516062854.22141-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200516062854.22141-1-tiwai@suse.de>
References: <20200516062854.22141-1-tiwai@suse.de>
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

The inline function is nowhere used.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_codec.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 8a32060e3d8d..d16a4229209b 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -366,13 +366,6 @@ struct hda_verb {
 void snd_hda_sequence_write(struct hda_codec *codec,
 			    const struct hda_verb *seq);
 
-/* unsolicited event */
-static inline void
-snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex)
-{
-	snd_hdac_bus_queue_event(&bus->core, res, res_ex);
-}
-
 /* cached write */
 static inline int
 snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
-- 
2.16.4

