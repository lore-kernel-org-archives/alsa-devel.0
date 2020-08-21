Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F986C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:00:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1962E20738
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GST+313b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD6hD8LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1962E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A21471695;
	Fri, 21 Aug 2020 20:59:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A21471695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598036444;
	bh=2ZwV0/WGjr59FbX/Jxbu7LEt8ZKgsrso9pySXoZl1V8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GST+313bX2yY95QzMfhDtAeT9JHB79WJ2/OC3BrWLjUiy86Dey88ZsdeojazH/Rnk
	 JGlTLYYrC5IbeYkrcGzAgDDjhT4eLnqCGrT2zjIJN1kgTcZLjXOPfhN2rSFlPxPRBw
	 qERsz3u2t8mbcJ4Y3x3lPtVnGRMs3P/kkZP7J7Gc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47CDFF80332;
	Fri, 21 Aug 2020 20:54:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76104F8028F; Fri, 21 Aug 2020 20:54:09 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 910E3F8028F
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 20:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 910E3F8028F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GD6hD8LM"
Received: by mail-qv1-xf43.google.com with SMTP id x6so1080270qvr.8
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9IeHB9lDAArlqZqVF3RpujPXGqkuFDtD8SXfEd8xABI=;
 b=GD6hD8LMYN5mgdIAELCXVSnSM884fmkvhr5QqlZoeJpeb+L1ZV9uxSoOV7b0prEDCN
 nAFH6njIFhR2pI1yMQw2XmHNcDq3yQbtD6o7xi50IQrQV1++zULuBD4C71Eeh5jksjeV
 f5AoLe6an5/xr+k4QzibPZI18Z2L7VHdPP5pAyKsm/2lyzaERsEJhT+gCoOLQ32ZKokj
 A+/VYocRBPXO2FhE90r6bFFbF1PoQCyMtpqvchi8nLIgQjybnWa7Y9/yODsOQEtU8v/1
 puI+7D5DqqArmZRFaYVc8wT7UGqAbh9A08hAg7ycrQUFNpml0JkqNDmgfRV8c4pE1d78
 Ivtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9IeHB9lDAArlqZqVF3RpujPXGqkuFDtD8SXfEd8xABI=;
 b=axqAiV4RTxWKgydy/gokzf94Vyym1xym5bGaQOA5MuMnkPAQbmookRgObLlJpLfS+L
 MwWWeFlKv3zDHiyiDNyX2RkJmqjy7JixKws8+WZrZA41EliDQ8b4Ar/FP27R2xo4LD5B
 ahdSm6c/o0PiVPfVW9ZjRFrPNljzMza5rfiFBwvKZtr94A8EZKkDPbSRwJXvSIByDBX7
 TU/I5BEoIBQKAlyuVPJ3AcrSTBnEOsi11S0++Esbpnqc3PB0FWpY8qp0wc7L7dwGX7kr
 EgHRVR/BgFE7q7utbpxKs563C5tAuYif2btNXL7ecv9RXM9o1H8N80EeYpdVr5W84BXc
 j5bw==
X-Gm-Message-State: AOAM531FIHEYRLcfTnj3nmY/LZKI0jH7MYL3OSmI8XgmCI+uFGDNkhLI
 RkqKS+T1yVesjwhPKuLVhvw=
X-Google-Smtp-Source: ABdhPJw/p/aSkmV5jyryhckZjVlGcJD7wF9+/GM74z1Nf/6LQvha53fa74/Vf278dTIRUtlJXKMSIw==
X-Received: by 2002:a05:6214:1742:: with SMTP id
 dc2mr3813584qvb.90.1598036039800; 
 Fri, 21 Aug 2020 11:53:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 11:53:59 -0700 (PDT)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 10/20] ALSA: hda/ca0132 - Add new quirk ID for SoundBlaster
 AE-7.
Date: Fri, 21 Aug 2020 14:52:27 -0400
Message-Id: <20200821185239.26133-11-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

Add a new PCI subsystem ID for the SoundBlaster AE-7 card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9c61a10114aa..57cb63ea88e6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1134,6 +1134,7 @@ enum {
 	QUIRK_R3DI,
 	QUIRK_R3D,
 	QUIRK_AE5,
+	QUIRK_AE7,
 };
 
 #ifdef CONFIG_PCI
@@ -1253,6 +1254,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
+	SND_PCI_QUIRK(0x1102, 0x0081, "Sound Blaster AE-7", QUIRK_AE7),
 	{}
 };
 
-- 
2.20.1

