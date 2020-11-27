Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04AAC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 13:27:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4A722243
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 13:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RqWQK6Xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4A722243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marcan.st
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E68F182D;
	Fri, 27 Nov 2020 14:26:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E68F182D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606483669;
	bh=76+DL0qTHRcrLgZz7KlWWdE42orm1tX2TB7gCqSaMmI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RqWQK6XpoDDMl81tFJNf5KDvOUf36269gTwllyH20ILYiFphoFpkt99WbKD3Ckt5Y
	 e9gbekncwLKu/9Sv/TvRRQQNslhf8+416hQLcMdIsmHZppeTmFUBAB8hgNkjcenH+J
	 GebSNXnzx5+FUg0BwbV7pJBs/bJE1Sy2RgWCM0fs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19BC8F8015F;
	Fri, 27 Nov 2020 14:26:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D40B7F8015F; Fri, 27 Nov 2020 14:26:57 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E01E4F800E0
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 14:26:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E01E4F800E0
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: hector@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 7219741ECC;
 Fri, 27 Nov 2020 13:26:41 +0000 (UTC)
From: Hector Martin <marcan@marcan.st>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: US16x08: fix value count for level meters
Date: Fri, 27 Nov 2020 22:26:35 +0900
Message-Id: <20201127132635.18947-1-marcan@marcan.st>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Detlef Urban <onkel@paraair.de>,
 Hector Martin <marcan@marcan.st>, stable@vger.kernel.org
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

The level meter control returns 34 integers of info. This fixes:

snd-usb-audio 3-1:1.0: control 2:0:0:Level Meter:0: access overflow

Cc: stable@vger.kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 92b1a6d9c931..bd63a9ce6a70 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -607,7 +607,7 @@ static int snd_us16x08_eq_put(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_meter_info(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->count = 1;
+	uinfo->count = 34;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->value.integer.max = 0x7FFF;
 	uinfo->value.integer.min = 0;
-- 
2.28.0

