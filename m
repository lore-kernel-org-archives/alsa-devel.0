Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA7CD6E4C
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:10:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81F816020A;
	Mon,  1 Jun 2026 10:10:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81F816020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780301419;
	bh=hRQPW5KZDoHk+f8ou9zmuGPZVRshuGxakrPmmKo9ve8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=poHDbMWWdu01fwqIzn3/p5Ug1shgxFrEnBHNOrn3/8POv58DOE+RoSY0vFZZc3DcQ
	 xgGoKIDtjpElHGvl8UotM0ry2hKOXMhlWf78miK96LwiXnNLv/mStZ6KBx0wfbsuqw
	 R6tq7kQ7Xv4HPZvVHVTQHS77/6zjpbYn1vcvB/78=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B649CF8060C; Mon,  1 Jun 2026 10:09:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54656F805F7;
	Mon,  1 Jun 2026 10:09:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEFCCF804D6; Fri, 29 May 2026 06:12:06 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9319AF8003C
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 06:12:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9319AF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gpEWE53G
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso1015569a91.2
        for <alsa-devel@alsa-project.org>;
 Thu, 28 May 2026 21:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780027922; x=1780632722;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AX/doqrwyFj9kqQj3i4hlD+1A7+yopQ7vuCHaJlszFc=;
        b=gpEWE53GXpomqmxTKaMQIUHjoXxgYWDWormx5HQY9CeiIjaJ28VlNs4isKG3cLUcqF
         g60q97xtU3NCD/oroM3PEZGeTGknP6euIsOSA25AUcH2RSOHOJDZ4dJ5OeStSOOyw/Aw
         etz2nS70AdxBSGK3ClZO2YFOpzxUtOnf4/E6ZDHNAnVVeNaD0x975kuliC5ovYPn12Vn
         UTKVfXA7v1EBsDJozqQCXdKtUarKBAiTJos+hCWx/7+BRSq6Pe1dOqMECM/S21J5dqd0
         KokID0QTZ8+FjTX6mEygf6ffWGqQUb9y45zmQeviwmPY7eGOonIV/Nv65kLOFTXZE17R
         K/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780027922; x=1780632722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX/doqrwyFj9kqQj3i4hlD+1A7+yopQ7vuCHaJlszFc=;
        b=erMUHz2a9fznOEO2FE+hYx/uzvyteiYqVB2L2JTb9TBL8FhpWnrHn/DbHP1K5QZZ+3
         lRbpN462Cgd+4MFn3ISzD/h/GyPPAqyefd03MTVbrPnpl31AV75zxp2QiUw7kdZjZeNn
         lXD9Kutnjpp/oOMLXr7cDZZM3U2Y0yYwmvWYtbibDwW5/5QK4BbcAbluFkGWT7rhkcdL
         bseMaIBdkfc5xc+jUyBca6c8MLVKSFXXb2Zxy8y5tJ4Z2Ihc3tDTOIpfQLJ8Z6BKeB+R
         fUsp5IMpyxvMB+5+CAkqOnnAo97DUpfpGJSv0mlBxRUfW9rkqwNUjqdl4uJD2JQBw9Bd
         Ag1w==
X-Gm-Message-State: AOJu0Yzkuz1aBi5fMt7gf+reMDmBlZFKlOY9RWinvi64t/txMu9df0Hp
	pe3C9jUvkrxXMhfv9a0AD76GM8yeBS179xBiYanfTApoAgFe5OTKcfdr
X-Gm-Gg: Acq92OER9D28mUDxa87TIbwnaj087B22WLMF37kRwd3NEbn15t2pPDFRY7SA8/gKTiI
	2gNuGQVd29Fu/mG6s+WTj8SOCbLwoZOBGEUZNakEOKqlBM9BYx5VW9rbCG35rGlTZePY3NJiqbt
	ei3oKaPgwxxksj57k6vgN1sYAuRVwqx9WBODO5Ru+SwjO6c2Qn5DsRUCyNJIVIpWy1+8OXgxuq9
	/PvLUMFI+u9KtelIkBtZwdte1GAcpmkZaKF3e4VjABlfoCvXhm2TpmCucWchmmR/E48uxK8vCGt
	DzhTBJwOJ7MKcquxCxSKRsRpjOnjbyxXj9S0Z5unxYiTlcSheJxT2VV0FjNlCZw4eFv9TVg8G+z
	8jg3pzOvJ9N0yZqhZ7XAZrm+YSvMa3q4E1CruDUGD/arBA6oH9+X6EaqCkmI2LyKpN+TuAaCoff
	DAOkbbiExE/pXIOpCLMyfhVEW4ouJfC9b+Yf8+rogK2W7KzXUVmgnOTXXNOCqjrjaN9MZ/J3ci1
	5qGGnipj2x5btQ78xrfO6ITNESLEna26pXVy+X6qSO5vWq/l6LU04pkLH5wcycc
X-Received: by 2002:a17:903:22d1:b0:2bc:810b:5c0c with SMTP id
 d9443c01a7336-2bf20bb2983mr16163415ad.34.1780027921550;
        Thu, 28 May 2026 21:12:01 -0700 (PDT)
Received: from arch.tail5702ad.ts.net
 (ec2-3-112-56-38.ap-northeast-1.compute.amazonaws.com. [3.112.56.38])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c2da36sm3717895ad.69.2026.05.28.21.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:12:01 -0700 (PDT)
From: ocean <zhouoceanhy@gmail.com>
X-Google-Original-From: ocean <51983215+ocean-sudo@users.noreply.github.com>
To: tiwai@suse.de,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
Subject: [PATCH v2] ALSA: hda/conexant: fix FEVM FA880 PRO internal mic mux
Date: Fri, 29 May 2026 12:11:47 +0800
Message-ID: 
 <20260529041147.70001-1-51983215+ocean-sudo@users.noreply.github.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: zhouoceanhy@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DMNHKLV34TWNEQGKW4DTIW2RWDSD4JOS
X-Message-ID-Hash: DMNHKLV34TWNEQGKW4DTIW2RWDSD4JOS
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:09:33 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DMNHKLV34TWNEQGKW4DTIW2RWDSD4JOS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>

FEVM FA880 PRO mini PC uses Conexant CX20632 codec. The internal
microphone is connected to pin 0x1e. In order to make it work,
we need to force ADC 0x14 connection to 0x1e (connection index 3).

This patch adds a new quirk CXT_FIXUP_CX20632_INTMIC to force
the connection selection on initialization, and applies it
for the SSID 2014:8004.

Signed-off-by: Ocean Zhou <51983215+ocean-sudo@users.noreply.github.com>
---
 sound/pci/hda/patch_conexant.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 2d4094be83ab..5e2279267104 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -300,6 +300,7 @@ enum {
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
 	CXT_FIXUP_HP_A_U,
+	CXT_FIXUP_CX20632_INTMIC,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -343,6 +344,15 @@ static void cxt5066_increase_mic_boost(struct hda_codec *codec,
 				  (0 << AC_AMPCAP_MUTE_SHIFT));
 }
 
+static void cxt_fixup_cx20632_intmic(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_INIT)
+		return;
+
+	/* Force ADC 0x14 to internal mic pin 0x1e (conn index 3). */
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_CONNECT_SEL, 0x03);
+}
+
 static void cxt_update_headset_mode(struct hda_codec *codec)
 {
 	/* The verbs used in this function were tested on a Conexant CX20751/2 codec. */
@@ -1035,6 +1045,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_hp_a_u,
 	},
+	[CXT_FIXUP_CX20632_INTMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_cx20632_intmic,
+	},
 };
 
 static const struct hda_quirk cxt5045_fixups[] = {
@@ -1140,6 +1154,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2014, 0x8004, "FEVM FA880 PRO", CXT_FIXUP_CX20632_INTMIC),
 	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
 	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
@@ -1165,6 +1180,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
 	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
+	{ .id = CXT_FIXUP_CX20632_INTMIC, .name = "cx20632-intmic" },
 	{}
 };
 
