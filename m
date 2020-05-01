Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB936C4724C
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 07:30:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1592071C
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 07:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eU5/yEtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1592071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E0A11694;
	Fri,  1 May 2020 09:29:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E0A11694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588318216;
	bh=rLlw8rMUAqeVweok2MD/3Z0Vz6as445kr1Je4wBunK4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eU5/yEtRRXzyYu/xYxqRkaoWqq2iWKdUJAEYahNwU1hgVkQLqRtk1qOTA80s1IqMd
	 RgwS2vy7YPtov/8IYXN+eIoXzrOoti+GayZh6oYG8+KYTOiGzWm4+zCUBjnIKLRL37
	 4gjz3z1TXR9hzSCRkKZ1p7nEI+Gc2j9F7yE/RFJE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02127F80217;
	Fri,  1 May 2020 09:29:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 195E2F8022B; Fri,  1 May 2020 09:29:22 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3CD7F800B9
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 09:29:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3CD7F800B9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 10E3DAC37;
 Fri,  1 May 2020 07:29:09 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek - Fix unused variable warning w/o
 CONFIG_LEDS_TRIGGER_AUDIO
Date: Fri,  1 May 2020 09:28:56 +0200
Message-Id: <20200501072857.13720-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
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

Cover with a proper ifdef around the variable declaration for fixing
the following compilation warning without CONFIG_LEDS_TRIGGER_AUDIO:
  sound/pci/hda/patch_realtek.c: In function 'alc_fixup_hp_gpio_led':
  sound/pci/hda/patch_realtek.c:4134:6: warning: unused variable 'err' [-Wunused-variable]

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 87dc36482cab ("ALSA: hda/realtek - Add LED class support for micmute LED")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b6a1c8b7f5d0..670e59b081d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4131,7 +4131,9 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 				  unsigned int micmute_mask)
 {
 	struct alc_spec *spec = codec->spec;
+#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
 	int err;
+#endif
 
 	alc_fixup_gpio(codec, action, mute_mask | micmute_mask);
 
-- 
2.16.4

