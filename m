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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6834C433E3
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C5F2075E
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NWUjjdt7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvnzpEJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C5F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A08D167D;
	Fri, 21 Aug 2020 21:02:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A08D167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598036616;
	bh=otPZlKIPKgaVXB4VxE2f/kMA4OKlsqUFGoovke6laDY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NWUjjdt7JYtj94nh4eSGxN8J84RtffzIl9zFfBCBp8F5k7QEvfQcZxNp+dMCA+qkS
	 pFuRj4J4QADiN63UrBCSfGxOoHVj5PBhUJ0cZFo+35PW+h0KurmxEf7PBZP8LTf3Nm
	 piQBWTk8Q843vMprj6jwLDzDt0E8PSTbNRY1PQJY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79AFFF80349;
	Fri, 21 Aug 2020 20:54:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A6DBF80316; Fri, 21 Aug 2020 20:54:15 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F06AF80308
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 20:54:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F06AF80308
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WvnzpEJK"
Received: by mail-qk1-x744.google.com with SMTP id m7so2249142qki.12
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ySHRdkEI0EzJJJO/AyNWTBnHyWXEreYyyJNUq9kZfoI=;
 b=WvnzpEJKTyoNFkklI2snGsgG7wnjHqExJLQZdJLXjtTLqZzWaF2bP9DYyTR4V5Ah47
 4vzmMozsf38RuDW4GWrUwjlxTLpZm4/UUNfAVoSQttCYVFe1NYjCuZ9Vs+7a59IJOrWR
 O417+z5lftpavPgruh6z6JTPcLF+3WvdotmEZnzNFJz2rilEP5IkaY5Os7rBzL11FWiw
 vwxNoL4HY9lj+tKJ6+DFfAsj3Ky+mYERhLRwfTINtIB5lDu+9+xromc2arB+KpPT9IM2
 WXC/Yv1yhVpV9lm0BeBpNXvdk6w8toaRw1Xw0rEMdPdCQE5oihEwEcrW1li5S6Tg5InH
 0/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ySHRdkEI0EzJJJO/AyNWTBnHyWXEreYyyJNUq9kZfoI=;
 b=WcRZW3NVL4WM1An/EM6QuLQ6HkNInZajqGQM8Rw993Gyb4mg3BV7VWhuKLxylxsdxk
 eWVXLI96QpO98CC30Ku1192f+oRUz0MdAfx99GNNTcPuXfPKQwsz46oXQoM/iCgrWp/X
 +Z9mZF6CGFBFKfQYwRT5bwNhlvWHI2euKzBeTBxk5fj/KtN7JKOb5MTz/dfLIVhS4Bix
 jWTOLwBBQcfKB7x5kK0HlKVgrzNExG2FVjv9WrBYPi1yNARpKzjsQ1NyGaMsjey5OCga
 P32jL53ou30C6haPvjEZOKmaOQyGkqqdi7ewWBRYu9xn2cHi35H3z0cQVuzD2w2VK/gV
 PCGQ==
X-Gm-Message-State: AOAM5318mne3eJv7kDHsp8Rnp2redG3aYRiRzU/lF663dWS8Ffpvx8ky
 COC7tVWsXOL1Wi2XIcL7DAzq6G7AeFc=
X-Google-Smtp-Source: ABdhPJy0tFKmH9MuzNd+9OhMKF+hWTMOFGz9YUA1vkqDjMV5krKUFZVy5qe+JYghg+8cHC2G6S+5yg==
X-Received: by 2002:a37:8601:: with SMTP id i1mr4143086qkd.307.1598036049415; 
 Fri, 21 Aug 2020 11:54:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 11:54:09 -0700 (PDT)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 15/20] ALSA: hda/ca0132 - Add init data for SoundBlaster AE-7.
Date: Fri, 21 Aug 2020 14:52:32 -0400
Message-Id: <20200821185239.26133-16-conmanx360@gmail.com>
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

Add initialization data for the SoundBlaster AE-7 card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9a1491d33819..4ec93a070d73 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3582,6 +3582,7 @@ static void ca0132_gpio_init(struct hda_codec *codec)
 	switch (ca0132_quirk(spec)) {
 	case QUIRK_SBZ:
 	case QUIRK_AE5:
+	case QUIRK_AE7:
 		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
 		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
 		snd_hda_codec_write(codec, 0x01, 0, 0x790, 0x23);
@@ -8911,6 +8912,19 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
 		break;
+	case QUIRK_AE7:
+		ca0132_gpio_init(codec);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x49);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_PLL_PMU_WRITE, 0x88);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		chipio_write(codec, 0x18b008, 0x000000f8);
+		chipio_write(codec, 0x18b008, 0x000000f0);
+		chipio_write(codec, 0x18b030, 0x00000020);
+		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
+		break;
 	case QUIRK_ZXR:
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
-- 
2.20.1

