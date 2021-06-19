Return-Path: <SRS0=smJs=LN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BFFC2B9F4
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Jun 2021 20:42:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13509611CE
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Jun 2021 20:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13509611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B439016E1;
	Sat, 19 Jun 2021 22:41:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B439016E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624135342;
	bh=m4qUO3bXOB5MnsnjVSvT2iHPERyb2SsFrq3KZkPqxfM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XnY2uH9qp9MfBCHO7Npya9y2QijMe5wZWPjvnYdhnl0WTT8ZAWKXbgpUPbUnxtnMA
	 dfXZbU1G0vBPTvzzQD+YCMgRSiVRTBOkD0+PUrZRxOAb04kXwK745qIha5rb7RFd9y
	 ggofB53MWt/q8Ak/s+t36lzPPPf17tpbUQ2+hfhg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45C2DF8019B;
	Sat, 19 Jun 2021 22:41:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1350F8025A; Sat, 19 Jun 2021 22:41:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 238BFF8014E
 for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2021 22:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 238BFF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hngxuUDV"
Received: by mail-ej1-x62b.google.com with SMTP id he7so21619287ejc.13
 for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2021 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y7heK8jLCMAsTutXG9D4DyhQ6mrjIGHXdgIEcCAASY0=;
 b=hngxuUDVRJVY6DUcHk9I1L3p2ved84CHmUxh6E5o2RGSW7sa5Hz++ePY+cOGZk+sY6
 DFj+2S8GlqRDhMo40Hq2BJZBvmihyq58llZRh4eI4qfRHQdeAGDwDkvsrLG7Y3D18re7
 4po8972Lz3XgjJkZ5bfeae6bYzcOcyhg8S9KiCDP/+G199J7gfzKZHDLhXjv3P2CvmOX
 MjekgnjbH0iV4Zjie8L6G37hhomr1bl+8yXXcO2l2iLn/KQXdTuY4M8taBP5IMPzJsT5
 Kpye7UBo0ror4XLcXfmwJk6pkDbq5oWgHrzpj737vhu/+4Mgb1mPC7Z9oCiXgRL1K9d0
 O3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y7heK8jLCMAsTutXG9D4DyhQ6mrjIGHXdgIEcCAASY0=;
 b=mUevUtSAKUvXANmwlqNqdpN2xaAlBx/Y4IM6Urxe7LFKWFvhunJ7/cj/xOF8RtwKvF
 E1s54ZLOWgqf4SInzU2mPhzuCChZofFt4oWrcLIYRMEd2HsCY+NIM76IuI4osOdY9Yx+
 T3hA+sNVO2lJM7yP63WD17iJwpcg4Qj9PmB4gtoQESLBwb9K2jpdaBss/dNd3aMoJG09
 kCq5CS+qgExOEzTmkKSPnCw5z9dCh1UMsaPGb5TK7aIeO7xAzi4v7y24qztRHYWmWMbU
 DiH1Dx3bjx4cpTpLlIb70CpEF2wQS/Hwqm1Npz8o6acEZUIwODsLeuZz7/C4rSjLicY+
 zI1g==
X-Gm-Message-State: AOAM5307/V4HR92PsYuxwU5dGtrr5eXdFNekoPLhh/HfeqBka+ojfNMk
 eKV2z8cgSl43na9TPTB1iTQ=
X-Google-Smtp-Source: ABdhPJwsp2ECG98d5l0TLg/JGqenBmU6zzzRTf63uWOHQ6NbHzdS1LeH0DS3H7tVjjmZUw2w3yhB/g==
X-Received: by 2002:a17:907:1011:: with SMTP id
 ox17mr9147195ejb.149.1624135285646; 
 Sat, 19 Jun 2021 13:41:25 -0700 (PDT)
Received: from spectre.. (host-79-18-36-75.retail.telecomitalia.it.
 [79.18.36.75])
 by smtp.gmail.com with ESMTPSA id q16sm8408685edt.26.2021.06.19.13.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Jun 2021 13:41:25 -0700 (PDT)
From: Elia Devito <eliadevito@gmail.com>
To: 
Subject: [PATCH] ALSA: hda/realtek: Improve fixup for HP Spectre x360 15-df0xxx
Date: Sat, 19 Jun 2021 22:41:04 +0200
Message-Id: <20210619204105.5682-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Chiu <chris.chiu@canonical.com>, Jian-Hong Pan <jhp@endlessos.org>,
 Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
 Jeremy Szu <jeremy.szu@canonical.com>, linux-kernel@vger.kernel.org,
 Elia Devito <eliadevito@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Werner Sembach <wse@tuxedocomputers.com>, Hui Wang <hui.wang@canonical.com>,
 Sami Loone <sami@loone.fi>, Huacai Chen <chenhuacai@kernel.org>
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

On HP Spectre x360 15-df0xxx, after system boot with plugged headset, the
headset mic are not detected.
Moving pincfg and DAC's config to single fixup function fix this.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59d0936377eb..07eabcf22b5f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6354,6 +6354,24 @@ static void alc_fixup_no_int_mic(struct hda_codec *codec,
 	}
 }
 
+static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	static const hda_nid_t conn[] = { 0x02 };
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 },  /* rear speaker */
+		{ }
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		/* force front speaker to DAC1 */
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -8138,13 +8156,8 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chain_id = ALC269_FIXUP_HP_LINE1_MIC1_LED,
 	},
 	[ALC285_FIXUP_HP_SPECTRE_X360] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x90170110 }, /* enable top speaker */
-			{}
-		},
-		.chained = true,
-		.chain_id = ALC285_FIXUP_SPEAKER2_TO_DAC1,
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_spectre_x360,
 	},
 	[ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.31.1

