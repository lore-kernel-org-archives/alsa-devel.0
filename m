Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57805C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 07:36:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6FE60230
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 07:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C6FE60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C46C1687;
	Wed, 29 Sep 2021 09:35:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C46C1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632901005;
	bh=N8sWb18dTAZswvb9UMmUBJ9wyL6TJjG8IeEVDVSa1zA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fiHaTHVzxjg7bECHDd7oGz31qbz+MAyP4q8fUiI4rHIXnnKqPstPAABgEcQwXF9K0
	 yKcLvsqhEf41/ZsabvPrLWKPueBhOC6uWuUfocu/735n6Q1dDg77nFSayi70MyNU9D
	 SWVIbmWhqMyJsTX5KXqAvqVsg1erbnvoWSPq8FTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FF08F80161;
	Wed, 29 Sep 2021 09:35:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1524F80227; Wed, 29 Sep 2021 09:35:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF149F80161
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 09:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF149F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="0pxTt1Zn"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="ZsKZZ3cQ"
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id AF73A22504
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632900942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dWOLdNsp85WhCyp/IHJR7PbN2dnf1IUJP3caQiJLzlY=;
 b=0pxTt1ZnZBe0aPer0AkrXFctgrfKqu4MC9LPOgtmatqSwGES0vNOrEpaNUXtx+InvHtnem
 i0Z843knoAzQz8Va8h3hGTrYvFGd6Sn/f4zUscEYb4IRw5C32hldYd67d7s5so+jcII+hw
 ZbyPNFL7+Oec4vsvqr/15H7EC3q2GOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632900942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dWOLdNsp85WhCyp/IHJR7PbN2dnf1IUJP3caQiJLzlY=;
 b=ZsKZZ3cQmBEQKVEo43EesflzSXwalrDVUMbaF0yUFJxiNr8ywbamjr6KRDCT8ONe7sXDPv
 AxLu2H2Buc1jL4Aw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay1.suse.de (Postfix) with ESMTP id 9F6A525D4F;
 Wed, 29 Sep 2021 07:35:42 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix a missing error check in scarlett gen2
 mixer
Date: Wed, 29 Sep 2021 09:35:40 +0200
Message-Id: <20210929073540.9611-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

The check of the returned error code is missing in
scarlett2_update_monitor_other().  Let's fix it.

Fixes: d5bda7e03982 ("ALSA: usb-audio: scarlett2: Add support for the talkback feature")
Reported-by: kernel test robot <lkp@intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/202109131831.9IodEzRx-lkp@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_scarlett_gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 3d5848d5481b..53ebabf42472 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -2450,6 +2450,8 @@ static int scarlett2_update_monitor_other(struct usb_mixer_interface *mixer)
 		err = scarlett2_usb_get_config(mixer,
 					       SCARLETT2_CONFIG_TALKBACK_MAP,
 					       1, &bitmap);
+		if (err < 0)
+			return err;
 		for (i = 0; i < num_mixes; i++, bitmap >>= 1)
 			private->talkback_map[i] = bitmap & 1;
 	}
-- 
2.26.2

