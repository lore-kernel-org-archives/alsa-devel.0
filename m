Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C165C433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  1 May 2022 12:44:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 381DD15E5;
	Sun,  1 May 2022 14:43:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 381DD15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651409038;
	bh=5swkpbHTT96IuZnt8lthAG18D/P4ym7dQ6EkUPjgkZQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BfyhWYBPrBVQsWBmoRdgq6FYv+0T5hwP4CKycNf9dcjbIpyWlwJNbhLFL5YiMRRcm
	 4ldHbwskCTV8ofkkXHvgzofiFd0QhUmr5KSGzPZwR2hFdl6bOe9dCBX+nLppff8lt0
	 1i4gcxW+NQxRADCjYVuFXAqp6VcpYEvuJaqkFHyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF722F8012F;
	Sun,  1 May 2022 14:43:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEE95F80137; Sun,  1 May 2022 14:43:05 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 009F8F800E9
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2022 14:43:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 009F8F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hx5wcsKh"
Received: by mail-ej1-x634.google.com with SMTP id k23so23385451ejd.3
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2022 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1vxO7qYbuf91SxJAOZgOiDdeZZIk+EdGKM0jh2u0r1I=;
 b=hx5wcsKhpG2mye5Xtbkri4icuDSRzo5Nc23odigOozmgTd7iDmE1L6u02uMr3UwRo5
 3mCx5F1H1Vg3mLFFhfyOapAfIw92TBUwoc2OCjxv4EcThIYteAyK1TeTO7C/iEzV8fid
 dcay5wHZxHou5U6sz1RwGh8gJolNsMOuqbksNURGf9bdSOKq6GGpAirUbJY1OT5uvxSY
 Lp+cCm8sPzIQh8w/2bKVmGoHK4ejd3igd96ryZRk/qR2JxOAgOZmpCu38YbugSQo9+2a
 CUKOt26sqVrw7jffT8hilkbZB3V/Jod/kicHKypr9Gebxk26gPk0p8rkDyRKq2bYh248
 82sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1vxO7qYbuf91SxJAOZgOiDdeZZIk+EdGKM0jh2u0r1I=;
 b=O/mLUbxhgLOsq0s4n9+pwR0vp36PQEQ9h9roTPa0S0DYCjrUklZVCwYF28a4uJwfBW
 yXEKqmw/4UVKL/fIyVHC4hOa4mjUFLMHpYfrviiSG7ANQ2l6/tAiR5RvT6MBV/jgXQkp
 uAgQF2oO356ij2F1HEaBfwNvo4I3FL1hlMVE1hGRcQhhzXFwPt/Q+3MBAIPvY0wvRxEZ
 RQn/bWNtsVl3hSIQF6aawbMXxTVSMm1aNlhxVOlXLewkLWdRh13TzMxE+qKVSAN2Nvoh
 ryFz1+7R3PDOF2Efcuh04zE5zjyXsmm81eVbK0Py52GkVQjvBDNyyo6rCTWaXSEahaY+
 Ds/g==
X-Gm-Message-State: AOAM530LhN6tlvqEZ51yzzFjVECMjKNV79uBwmiRvF3SGkfQf8eFkyOJ
 A3DZ5rvELj4CBfoPFOTZZ07ph66xo7E=
X-Google-Smtp-Source: ABdhPJxa8WJ8FXW2H8dsdVGmpM90xgYrgMBC0voRB5jrFR1CaXnk0EevY4u57w/yY9XMhAFKfBR1yw==
X-Received: by 2002:a17:906:5641:b0:6da:8691:3fcc with SMTP id
 v1-20020a170906564100b006da86913fccmr7182444ejr.50.1651408980584; 
 Sun, 01 May 2022 05:43:00 -0700 (PDT)
Received: from localhost.localdomain (net-109-116-144-55.cust.vodafonedsl.it.
 [109.116.144.55]) by smtp.gmail.com with ESMTPSA id
 co8-20020a0564020c0800b0042617ba63c6sm5320189edb.80.2022.05.01.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 May 2022 05:43:00 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for Dell Latitude 7520
Date: Sun,  1 May 2022 14:42:37 +0200
Message-Id: <20220501124237.4667-1-gabriele.mzt@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426101359.37794-1-gabriele.mzt@gmail.com>
References: <20220426101359.37794-1-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
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

The driver is currently using ALC269_FIXUP_DELL4_MIC_NO_PRESENCE for
the Latitude 7520, but this fixup chain has some issues:

 - The internal mic is really loud and the recorded audio is distorted
   at "standard" audio levels.

 - There are pop noises at system startup and when plugging/unplugging
   headphone jacks.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215885
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 62fbf3772b41..36920570660b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6780,6 +6780,41 @@ static void alc256_fixup_mic_no_presence_and_resume(struct hda_codec *codec,
 	}
 }
 
+static void alc_fixup_dell4_mic_no_presence_quiet(struct hda_codec *codec,
+						  const struct hda_fixup *fix,
+						  int action)
+{
+	struct alc_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->gen.input_mux;
+	int i;
+
+	alc269_fixup_limit_int_mic_boost(codec, fix, action);
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		/**
+		 * Set the vref of pin 0x19 (Headset Mic) and pin 0x1b (Headphone Mic)
+		 * to Hi-Z to avoid pop noises at startup and when plugging and
+		 * unplugging headphones.
+		 */
+		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
+		snd_hda_codec_set_pin_target(codec, 0x1b, PIN_VREFHIZ);
+		break;
+	case HDA_FIXUP_ACT_PROBE:
+		/**
+		 * Make the internal mic (0x12) the default input source to
+		 * prevent pop noises on cold boot.
+		 */
+		for (i = 0; i < imux->num_items; i++) {
+			if (spec->gen.imux_pins[i] == 0x12) {
+				spec->gen.cur_mux[0] = i;
+				break;
+			}
+		}
+		break;
+	}
+}
+
 enum {
 	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
@@ -6821,6 +6856,7 @@ enum {
 	ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
 	ALC269_FIXUP_HEADSET_MODE,
 	ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC269_FIXUP_ASPIRE_HEADSET_MIC,
@@ -8799,6 +8835,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
 	},
+	[ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_dell4_mic_no_presence_quiet,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8889,6 +8931,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x09bf, "Dell Precision", ALC233_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0a2e, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a30, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0a38, "Dell Latitude 7520", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET),
 	SND_PCI_QUIRK(0x1028, 0x0a58, "Dell", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a61, "Dell XPS 15 9510", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x0a62, "Dell Precision 5560", ALC289_FIXUP_DUAL_SPK),
-- 
2.36.0

