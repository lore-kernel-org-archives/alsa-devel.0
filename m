Return-Path: <SRS0=REud=KR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66383C2B9F2
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 03:49:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F20613D0
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 03:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F20613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CD7B16A0;
	Sat, 22 May 2021 05:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CD7B16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621655340;
	bh=lVBPv9tOoFkV8NZyoSh+Y0dJ9zX/0+oF3518Ufm4A7k=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mtzu35Vaqw/Q74dm0yZrmnXFEo9T9UjQokpsyFC8fAbOawhRAHS0C9ZgKdbvUcfJy
	 044MtZxduQGkEPV+VTvcKuNJquGv0B00qjH5jZQ/amzVFo/PNMfZYAc4R9SzKoF3JU
	 vZQSbWs3Fw78ye0U0RyAWUSIZMtXjKvuu8KoUm6A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 177E4F8020B;
	Sat, 22 May 2021 05:48:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B855F80217; Sat, 22 May 2021 05:48:07 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E806F800E5
 for <alsa-devel@alsa-project.org>; Sat, 22 May 2021 05:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E806F800E5
Received: from [123.112.69.138] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <hui.wang@canonical.com>)
 id 1lkIcF-0003Vp-UV; Sat, 22 May 2021 03:47:57 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Headphone volume is controlled by Front
 mixer
Date: Sat, 22 May 2021 11:47:41 +0800
Message-Id: <20210522034741.13415-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
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

On some ASUS and MSI machines, the audio codec is alc1220 and the
Headphone is connected to audio mixer 0xf and DAC 0x5, in theory
the Headphone volume is controlled by DAC 0x5 (Heapdhone Playback
Volume), but somehow it is controlled by DAC 0x2 (Front Playback
Volume), maybe this is a defect on the codec alc1220.

Because of this issue, the PA couldn't switch the headphone and
Lineout correctly, If we apply the quirk CLEVO_P950 to those machines,
the Lineout and Headphone will share the audio mixer 0xc and DAC 0x2,
and generate Headphone+LO mixer, then PA could handle them when
switching between them.

BugLink: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/1206
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c6b5db831ed0..3d40d32ef3ba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2603,6 +2603,28 @@ static const struct hda_model_fixup alc882_fixup_models[] = {
 	{}
 };
 
+static const struct snd_hda_pin_quirk alc882_pin_fixup_tbl[] = {
+	SND_HDA_PIN_QUIRK(0x10ec1220, 0x1043, "ASUS", ALC1220_FIXUP_CLEVO_P950,
+		{0x14, 0x01014010},
+		{0x15, 0x01011012},
+		{0x16, 0x01016011},
+		{0x18, 0x01a19040},
+		{0x19, 0x02a19050},
+		{0x1a, 0x0181304f},
+		{0x1b, 0x0221401f},
+		{0x1e, 0x01456130}),
+	SND_HDA_PIN_QUIRK(0x10ec1220, 0x1462, "MS-7C35", ALC1220_FIXUP_CLEVO_P950,
+		{0x14, 0x01015010},
+		{0x15, 0x01011012},
+		{0x16, 0x01011011},
+		{0x18, 0x01a11040},
+		{0x19, 0x02a19050},
+		{0x1a, 0x0181104f},
+		{0x1b, 0x0221401f},
+		{0x1e, 0x01451130}),
+	{}
+};
+
 /*
  * BIOS auto configuration
  */
@@ -2644,6 +2666,7 @@ static int patch_alc882(struct hda_codec *codec)
 
 	snd_hda_pick_fixup(codec, alc882_fixup_models, alc882_fixup_tbl,
 		       alc882_fixups);
+	snd_hda_pick_pin_fixup(codec, alc882_pin_fixup_tbl, alc882_fixups, true);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
-- 
2.25.1

