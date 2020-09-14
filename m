Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE94FC43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:52:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8AB207EA
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kI4xoj6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8AB207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7ED1E1677;
	Mon, 14 Sep 2020 08:51:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7ED1E1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600066354;
	bh=k160TlcDptOd2Ur6p7PkQHcdIFoTuCiVp9hPn0PkGm0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kI4xoj6TD3P3zJI6cXa1k/uPOWTJJZqd6xPmz2FCaKfUhKEnlRIqV+kWTAy8X5jHl
	 2nyc4nKY0oOE97wRgWwciFXhgUJJT7LvDACwsEJ0HUe5GaghIh/zANxZAfNsPv7TZu
	 4hev2uLF+23G4CqbWgzamTUkEcULJbMBGuu5PAtA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE82FF80150;
	Mon, 14 Sep 2020 08:51:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BF39F8015A; Mon, 14 Sep 2020 08:51:42 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41B21F800F1
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 08:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41B21F800F1
Received: from [125.35.49.90] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kHiKn-0001o9-28; Mon, 14 Sep 2020 06:51:29 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	kailang@realtek.com
Subject: [PATCH] ALSA: hda/realtek - Couldn't detect Mic if booting with
 headset plugged
Date: Mon, 14 Sep 2020 14:51:18 +0800
Message-Id: <20200914065118.19238-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: stable@vger.kernel.org
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

We found a Mic detection issue on many Lenovo laptops, those laptops
belong to differnt models and they have different audio design like
internal mic connects to the codec or PCH, they all have this problem,
the problem is if plugging a headset before powerup/reboot the
machine, after booting up, the headphone could be detected but Mic
couldn't. If we plug out and plug in the headset, both headphone and
Mic could be detected then.

Through debugging we found the codec on those laptops are same, it is
alc257, and if we don't disable the 3k pulldown in alc256_shutup(),
the issue will be fixed. So far there is no pop noise or power
consumption regression on those laptops after this change.

Cc: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 85e207173f5d..b6dc47da1d7b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3428,7 +3428,11 @@ static void alc256_shutup(struct hda_codec *codec)
 
 	/* 3k pull low control for Headset jack. */
 	/* NOTE: call this before clearing the pin, otherwise codec stalls */
-	alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
+	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
+	 * when booting with headset plugged. So skip setting it for the codec alc257
+	 */
+	if (codec->core.vendor_id != 0x10ec0257)
+		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (!spec->no_shutup_pins)
 		snd_hda_codec_write(codec, hp_pin, 0,
-- 
2.17.1

