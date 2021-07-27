Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE0C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 03:08:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BB960F9E
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 03:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86BB960F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 968141B02;
	Tue, 27 Jul 2021 05:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 968141B02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627355308;
	bh=CrPx1yTpxBBnMS3wwGQfwDjedtDRLxbCcEXZ6i/I2Mo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MzPMW/57bGVZgqgvt637o4t3Ck+9ZCS5MKLXm7zz6iG9cMvK1Mn9GSGiCoL2b2BYf
	 qRf0B1V5Z3iA41XUcGi9Pz9XjQIdid3wnOG7lqu9bl/nTxyXQWXdb1mWo+6ag4AGe/
	 xUSnSF13vW6SAuSYrtVdngX+9sEKyDk/mx1rXZXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06369F80258;
	Tue, 27 Jul 2021 05:07:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2085F8026C; Tue, 27 Jul 2021 05:07:35 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59AF0F80212
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 05:07:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59AF0F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cEWrlrPE"
Received: by mail-wm1-x329.google.com with SMTP id
 l11-20020a7bcf0b0000b0290253545c2997so1301042wmg.4
 for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z+vhuPMi7v8JV5TwCD4wJFknXFCpdec7hF+rFYNv128=;
 b=cEWrlrPEght9YOFvG3cMoN5U5IOmV4GIKDDb/BurWVG29PzUWHTrz2tF2uO0sM9Knj
 FWYgwuR4ECgQGTbH9VJgVrmU5ZQtSZ7J0poGMD/0GcooXp1MQ3uRyCjXAuNEL5l/h7lm
 4so5s5/4U+VDDTt0Jq8/mLjCapEFndu69xt4ZyOJELm1pgt3nnULO7J9gyVBS/4/jfSF
 CRbPqhZCpEAfexMteaWAZhAwA4OGhK5Nbzlu/noYbg6Lh7y10GoUFaSqyJO0t3UwBMqq
 0B8JjghGewBt5mvT23kJ7YQ1h9Qb3TEcCSJchdo72s/tyD6Uwe5EHW55PSjXJ167IMCR
 EwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z+vhuPMi7v8JV5TwCD4wJFknXFCpdec7hF+rFYNv128=;
 b=k9wgOVBlT2FpmsaHVjIufvg39sxoEKLnxNfJjUcJx54iqaBlGRvjj2CnSyQHyw8ogx
 ZQwm5bidS7ComV9n/9VE4fgZlqfGSk0qChQ8eydPfzvQY1pXsJjojSbs1uQvgFJgnEVa
 oFnFLvdV7tWmRi3W8Tsmd8jHE2CcRI7TjLhZDLyc6sIfmAvsXE5WjFBVqKnQ12uXuXd8
 JNobpZRuFoO7P7hk7gK6OcIbHsRNzbzQw+Z0n6VQqHAN83SzRzjgyZAQl/XaPGJ6e3if
 FGNoKSixRsJwklvBoMNcZisVXHSjN5aER2oJH2A24ezPQs7f/X6CUqf76Uc1pU/szz59
 JM3w==
X-Gm-Message-State: AOAM532hN7R3ZEqtPJCX+vTNTvpumUldvxTqzmNLDQlBKasmTHI+rk7I
 Ex6NhzmMeLfKoqmUYzw1hbc=
X-Google-Smtp-Source: ABdhPJyby0G1eHA9n1PWph8XZg5AugAwqCZNei2aE+3DxtcgqA4zvOf/dpUUCNLajxf8S0gq0ix1EA==
X-Received: by 2002:a1c:a510:: with SMTP id o16mr1761195wme.162.1627355248335; 
 Mon, 26 Jul 2021 20:07:28 -0700 (PDT)
Received: from mpompiras.. (ppp-94-66-57-252.home.otenet.gr. [94.66.57.252])
 by smtp.gmail.com with ESMTPSA id d18sm1929801wrp.54.2021.07.26.20.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 20:07:27 -0700 (PDT)
From: Nikos Liolios <liolios.nk@gmail.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic for Acer SWIFT SF314-56
 (ALC256)
Date: Tue, 27 Jul 2021 06:05:10 +0300
Message-Id: <20210727030510.36292-1-liolios.nk@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Nikos Liolios <liolios.nk@gmail.com>
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

The issue on Acer SWIFT SF314-56 is that headset microphone doesn't work.
The following quirk fixed headset microphone issue. The fixup was found by trial and error.
Note that the fixup of SF314-54/55 (ALC256_FIXUP_ACER_HEADSET_MIC) was not successful on my SF314-56.

Signed-off-by: Nikos Liolios <liolios.nk@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index caaf0e8aa..14e1ab7c7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8274,6 +8274,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55", ALC256_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1300, "Acer SWIFT SF314-56", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
-- 
2.31.1

