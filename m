Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA4C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:08:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965E020756
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y/JZTw2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965E020756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1482D16E2;
	Mon, 23 Nov 2020 10:07:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1482D16E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122481;
	bh=junKauIDueGgswt/O4uPn/+OwTHe6zkc9xhDLd32BNE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y/JZTw2Z65wwcdsDazWVOb9Np8GeucVRKMV/nOxRCUJqERVEF0JaeiKu6lUBnz6fl
	 iln6UDA7w4gt4gH46G+WYLogLstpdBAe87R1dQ5gVKTs2iZtkuyhk2gC8DMyW4hVn0
	 OCOw2mG/OsZ1Zc0yBcAx2gba2cUAiyQ5Ywn5xUY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3787F805EE;
	Mon, 23 Nov 2020 09:55:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15625F8055C; Mon, 23 Nov 2020 09:54:48 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A549EF804E7
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A549EF804E7
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CEF9BAFBE;
 Mon, 23 Nov 2020 08:53:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 17/41] ALSA: usb-audio: Don't set altsetting before
 initializing sample rate
Date: Mon, 23 Nov 2020 09:53:23 +0100
Message-Id: <20201123085347.19667-18-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

Setting the active altsetting at changing sample rate seems
unrecommended.  The host should deselect the altsetting at first
before that, then select it again.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 816fd3e5aada..4501e042a944 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1223,9 +1223,10 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 		}
 
 		/* try to set the interface... */
-		usb_set_interface(chip->dev, iface_no, altno);
+		usb_set_interface(chip->dev, iface_no, 0);
 		snd_usb_init_pitch(chip, iface_no, alts, fp);
 		snd_usb_init_sample_rate(chip, iface_no, alts, fp, fp->rate_max);
+		usb_set_interface(chip->dev, iface_no, altno);
 	}
 	return 0;
 }
-- 
2.16.4

