Return-Path: <SRS0=lB/p=BW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A75C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 07:03:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B836204FD
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 07:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ursfiWWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B836204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 750E21662;
	Wed, 12 Aug 2020 09:03:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 750E21662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597215836;
	bh=HPWdxI+V7rsSj87CosW2hF1q5Y+DRCM9KEHpT0WyBMs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ursfiWWxwM+3iJnlmszIO5DwvkZq47fAll1T2W+ukwLqQ25Ub0Il2BXAyLyeI6r3U
	 AgdNJ7a3l/4Ysb0q3O5n1xPwkAykPYCEeg1pYe/0KUHxJes2kZdUK4gCm7UMrU5Htu
	 997cToAuJXSwYZhx9L0r2tXN+qfuqqFN54uo0vmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 106A6F800F4;
	Wed, 12 Aug 2020 09:03:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8538EF8022D; Wed, 12 Aug 2020 09:03:04 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A3BEF800F4
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 09:02:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A3BEF800F4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EF619B156;
 Wed, 12 Aug 2020 07:03:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek - Fix unused variable warning
Date: Wed, 12 Aug 2020 09:02:56 +0200
Message-Id: <20200812070256.32145-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Hui Wang <hui.wang@canonical.com>, Stephen Rothwell <sfr@canb.auug.org.au>
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

The previous fix forgot to remove the unused variable that triggers a
compile warning now:
  sound/pci/hda/patch_realtek.c: In function 'alc285_fixup_hp_gpio_led':
  sound/pci/hda/patch_realtek.c:4163:19: warning: unused variable 'spec' [-Wunused-variable]

Fix it.

Fixes: 404690649e6a ("ALSA: hda - reverse the setting value in the micmute_led_set")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 073029aeaf3c..7f9d35273734 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4160,8 +4160,6 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 static void alc285_fixup_hp_gpio_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
-	struct alc_spec *spec = codec->spec;
-
 	alc_fixup_hp_gpio_led(codec, action, 0x04, 0x01);
 }
 
-- 
2.16.4

