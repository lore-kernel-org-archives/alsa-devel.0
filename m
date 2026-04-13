Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4B4F8A145
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:20:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60DF860204;
	Thu, 16 Apr 2026 11:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60DF860204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776331207;
	bh=Eq7AiSyUe5x724YmkToZzNj+bhT6SMcbZlP8W/ontxY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=uuMIvMm4If1/yTd/D/ZoUWUFFHUNayO/C8/CLragLWX0egYAjuGwlFZ7ZmOMkQXBT
	 qjHowDqV10q82opC8A9GiCBuKS+Tpo10mUcegpepnic1m134uQj/lXfiHvpN9MdELa
	 Cxada417JOStM4qhaW61tCIwE/76nOHREFsncPrs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A32C9F805EF; Thu, 16 Apr 2026 11:19:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEA9EF805E1;
	Thu, 16 Apr 2026 11:19:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C1EBF80537; Mon, 13 Apr 2026 05:13:45 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C34C2F8011B
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2026 05:13:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C34C2F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rSwhmi8O
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso3431328a91.3
        for <alsa-devel@alsa-project.org>;
 Sun, 12 Apr 2026 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776050020; x=1776654820;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GppEUacIi0+YAoU9LcH4rary7mmQqN5EezxmfgdeTAg=;
        b=rSwhmi8OkTJM+q42KtMZc8q0f9rH2eKN9lzGooovWFdRyakLdQqNQt4WJ6b2p5IEpG
         2ZjHyjjpkaccyei6Yvc5XXSAGonZ4MEDGX5akgIYPPwnCA6kSpkyJAjwJTiVN7tgDkYV
         k1IefEDTpenvlW0hijuykUwEaSPPa85WiT4eA7FwsyvIYbkOOcBfmIioNn8wYvjJaN+P
         AGpZX4eT5Nxg6g2xk/YWD5aRJDiVLDbz/CJlhvogv4O1kuOi/6xWLc8h+qX4BHAFB9rW
         uRzf/mimczBeUPW+B0zeTW1y++Tnoo1Tl7FDKW73ktXnWRHUht96T9oTCLW6STw0OwRX
         GhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776050020; x=1776654820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GppEUacIi0+YAoU9LcH4rary7mmQqN5EezxmfgdeTAg=;
        b=h/FVfIgOllVvXILx2UZL5xzHzpvsivBfBYKr2PDJQreZwjD9aXgjyROeQOZYExWKSX
         y4thA57U210vBUcfb+L4EzdBXzP7dLVkVySmNbS63fjz3G/jeRMpyqNyVRrxqiX8JTTP
         +pFN3rSPj52RcAe3gFHaLBXgTPXao/t328ZKGPtSO9m3bLFWyBVxwhj+z0lDVdc9Mesc
         tf+MCuTdV6uCvF2Nus8NQHkfN0eqGq3Ep+Nn4gHy5OvS/qtTpo09PP/JhsrCi7ZW7pLH
         ywrRSGdc7YFz0tUcAuhHXVviVZ33cYJzZmVT+Cy6R8Cwlr8ckUegn1ulBNIRK8GhbrUG
         Y6rw==
X-Gm-Message-State: AOJu0YyBYgNy0zsGSKx5ifSVu/FAC3EyXRp4FRMuzg9K5GhtIAzTySx5
	meYjP3afcfhpMvD3Rk7Obe4p4PRp5201Xgxm9hfNqPajp5nvnLfIynV+Ioly7U2T3IEZCA==
X-Gm-Gg: AeBDiet2E+3BVsQDd98ZCOIj+SYKP+3hlfSfGuPtaTia3N9vT+TBZlukWPPcxEv7XeV
	r4EvipBzSedjFgROF7y9sDtMTdD2o01HLEnePfQ/zDUwva3Zgei5nJfnByW6dcMPhlJVXE8JVBS
	wQcwRtQKtp+RJAd1fEmSbpiuWZYaHSQVTrftVrchrqPe28B7cDC5B5Isgjb6Iwe5vdDqOAT0Bgt
	mocZAak+VLimc+7AToBF2WCiLiiYDDOOh6hqdZuL00u2tdss1Zm0a8JS7AAU9xOMAvPJR0knmAv
	o3WTGxR+HkZdeoP6faieciEc5+lBfrWPn2LbUgDfbBYB4c8TqjWJqNgpSF+1ioB3sS/FU59O72m
	9EcxR1XGjNLd6V2XVqc4LHf2ZWL+pi9G37c8uzS/CpFEDcd8ryH5QLKCb0braNL/wpkxPIoN7mF
	VsvQt/oFTUiJRAM4qX7THC2DzB3B6ex6lP7WZ2AKqvd4waYIl6qQ==
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr12647368a91.0.1776050019702;
        Sun, 12 Apr 2026 20:13:39 -0700 (PDT)
Received: from FoxArch (184-155-120-110.cpe.sparklight.net. [184.155.120.110])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e581537afsm4808028a91.10.2026.04.12.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:13:39 -0700 (PDT)
From: Faye <faye.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faye <faye.opensource@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Acer PT316-51S headset mic
Date: Sun, 12 Apr 2026 21:12:59 -0600
Message-ID: <20260413031259.30135-1-faye.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: faye.opensource@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: HJZQNLKDE3OXOYKOVPJLYWIAIAXCJ6XB
X-Message-ID-Hash: HJZQNLKDE3OXOYKOVPJLYWIAIAXCJ6XB
X-Mailman-Approved-At: Thu, 16 Apr 2026 09:19:25 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HJZQNLKDE3OXOYKOVPJLYWIAIAXCJ6XB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Acer PT316-51S (PCI SSID 1025:160e) with ALC287 codec does not
detect the headset microphone due to missing BIOS pin configuration
for pin 0x19. Apply ALC2XX_FIXUP_HEADSET_MIC to enable it.

Signed-off-by: Faye <faye.opensource@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index cb39054..75466f4 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6689,6 +6689,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1539, "Acer Nitro 5 AN515-57", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x160e, "Acer PT316-51S", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1597, "Acer Nitro 5 AN517-55", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x171e, "Acer Nitro ANV15-51", ALC245_FIXUP_ACER_MICMUTE_LED),
-- 
2.53.0

