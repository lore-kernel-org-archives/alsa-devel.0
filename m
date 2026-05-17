Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A52CD4F3D
	for <alsa-devel@archiver.kernel.org>; Sun, 17 May 2026 20:50:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EE7F601F7;
	Sun, 17 May 2026 22:49:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EE7F601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779051007;
	bh=EmM6HSaL7MtlsZzHGdKLKG9OE/EYn2728i8JBIR5OtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=at0mcT2LwDdA62qYjGjdK75FQy6CEOftFO36aNaUhTlK0hQWZPBpYhCFIotyf8TEW
	 YwzqvN8/D/27eKCRbkPJHeoLYhJDe/CmyB0Ckm9BSaMbPK/tQYn/pzZGvuhKs7ud80
	 nvo+0NSBbODStZ5j+aNSvV6T43TaX5QAx/7o3P0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0576F805EE; Sun, 17 May 2026 22:49:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 800B4F805F2;
	Sun, 17 May 2026 22:49:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 176D8F804FF; Sun, 17 May 2026 18:29:57 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A6536F8014E
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2026 18:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6536F8014E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GvTMeU8e
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so12984245e9.0
        for <alsa-devel@alsa-project.org>;
 Sun, 17 May 2026 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779035394; x=1779640194;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHonvBVve/NNvr6Ulmu+t2ONftc5b9ycNLCCNIoOHK0=;
        b=GvTMeU8eykAcY91e6oE2bWYWICjp986RPjhcABjdYjVp7JlunBjdcwliMIh/pisMJX
         enI8UgT83PBM8BKHvNvMIcSuTW28ukcBNIL4tjKvKp7T9yeqtJQGsgqZ+px23GEiil8i
         +H2l4NaHWkotfIxIxrnJRkgdosDdY8wkUQJqSQQNPtzjLSkeQauIHlJkz48pHmTQG3KM
         06xr8qoNRGTM5GEsXkmsSzwNW7dJFxXnfil/d4DLzJcpgI537qQ3TlkxMYqf85YQf2/V
         FO6KydSzkCJDxT7pV0U8RGMeZJSrJIceQaqCiAtYNRT9+/SL2/fdemtHnvWvRRuPXxwa
         K1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779035394; x=1779640194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHonvBVve/NNvr6Ulmu+t2ONftc5b9ycNLCCNIoOHK0=;
        b=cXcYU34a+06+oui3qw1n8/mwWIq9ZwwqsfHPKZX6mni10Y13SpZp/tvdAgwaEKjDZ7
         gcJ91llQtaVv0ZT9gjUhl3N3V7mmXmb45wpwAgoDMFoh7zrBA4mBjIGfrdX1wJTSvjAT
         3c1ctkAF9OzdxlVgVLhWUIdz0hpdRott2hp8CP0t7mh7ipPeXsJ/4fO5rMC5cKSjHyrB
         7UxGmbPgPG+rZaEhVHcMr/lgtgnRgpQikOYi3RNcZFLezWL/aX7kEBtKnFN8HnM6pWy9
         vdOj1CO6wfEbYXDzCguQxDCZHZrV1Y5SmA5QuwlBln1xn1RVzgP9XHUKVoGCW8q9mYh/
         pgFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+j8zb71FRf2kNiYJtvP6zMNXMLqw+fmuvM97nyvG/2zSBLU7kh/RGVYx6wdxy0B4ZeC8uoKXEEOBxz@alsa-project.org
X-Gm-Message-State: AOJu0YzR8kKcg7oPXr+mrLX0vXgW65OP/DoCTP/ArPQb+DUcPyVI6Wfm
	VQXAlqfgdQT3JuSkYJSBBvyiTgzDtWUZ4dixAPFqP3xC5iPCvfETk/gp
X-Gm-Gg: Acq92OEn+dBWWZIILb9pLNKIiYuMJ8Aj7bPBhUuwCrVb+TJwIt7xHyiJUjWy58mysUX
	9qSBOA7X/0ddz348L51fdub3xXx9U6SV20lwxbEPKNfSocn9galUgKEarakH3/e29b9uppBzPTy
	cphkDZ7rHvmTU9Xj6Lj0KZVykSBCpxkHhwNxHVJzOGg13IvfCBGmDe0y1HDFVrsGJ/ERwrfLn/k
	yCpFgT/NTHydIOVl2HnrRCxj2jdBGVT3qXOsfHaUaQxCGRl6SQWkY9FoSd82P6+qLQsjNV5UhiL
	TsC/5LhwUNglTlCYUGgn/2SCfGEQtyHxcJtRS015tR93hnyAQqgbaaTwICHBXf33lSdQM/LdstY
	GmE4dE9X3tHoA9tkE7S/lmROcYEBWLkMXZ3ypqBtxCxAIItrvpAQM8q/ZLqAMmBXOlhRaDbgZNT
	0UebD5IGsatxnZRPmYMQrU0Soyr5onp9zMpQ==
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48fe4dad784mr156141785e9.5.1779035393286;
        Sun, 17 May 2026 09:29:53 -0700 (PDT)
Received: from [192.168.0.5] ([151.67.112.59])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2c96csm64633195e9.2.2026.05.17.09.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 09:29:52 -0700 (PDT)
Message-ID: <2f45fd6e-0a5b-4f47-9f2b-75d8b323ced8@gmail.com>
Date: Sun, 17 May 2026 18:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ALSA: hda/ca0132: add QUIRK_GENERIC path for Gigabyte,
 GA-Z170X-Gaming G1
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela ` <perex@perex.cz>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <a1dd5dfd-8678-4dd9-b6af-68a1e078168a@gmail.com>
 <87tss7xyj5.wl-tiwai@suse.de>
Content-Language: en-US
From: "eziogale@gmail.com" <eziogale@gmail.com>
In-Reply-To: <87tss7xyj5.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: eziogale@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4RC2OOVESYIIMINN4WFZSAXIB5EUFLJ4
X-Message-ID-Hash: 4RC2OOVESYIIMINN4WFZSAXIB5EUFLJ4
X-Mailman-Approved-At: Sun, 17 May 2026 20:49:28 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RC2OOVESYIIMINN4WFZSAXIB5EUFLJ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some CA0132 implementations (e.g. Gigabyte GA-Z170X-Gaming G1) produce 
white noise when using the DSP firmware path.

Add a QUIRK_GENERIC path that uses the standard HDA generic parser 
instead, with custom pin configs.

This patch applies against v6.18.24.
---
  sound/hda/codecs/Kconfig  |   1 +
  sound/hda/codecs/ca0132.c | 111 +++++++++++++++++++++++++++++++++-----
  2 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/sound/hda/codecs/Kconfig b/sound/hda/codecs/Kconfig
index addbc94..dcf340e 100644
--- a/sound/hda/codecs/Kconfig
+++ b/sound/hda/codecs/Kconfig
@@ -69,6 +69,7 @@ comment "Set to Y if you want auto-loading the codec 
driver"

  config SND_HDA_CODEC_CA0132
      tristate "Build Creative CA0132 codec support"
+    select SND_HDA_GENERIC
      help
        Say Y or M here to include Creative CA0132 codec support in
        snd-hda-intel driver.
diff --git a/sound/hda/codecs/ca0132.c b/sound/hda/codecs/ca0132.c
index dd054ae..92fc93f 100644
--- a/sound/hda/codecs/ca0132.c
+++ b/sound/hda/codecs/ca0132.c
@@ -24,6 +24,7 @@
  #include "hda_local.h"
  #include "hda_auto_parser.h"
  #include "hda_jack.h"
+#include "generic.h"

  #include "ca0132_regs.h"

@@ -1060,6 +1061,8 @@ enum dsp_download_state {
   */

  struct ca0132_spec {
+    struct hda_gen_spec gen;
+
      const struct snd_kcontrol_new *mixers[5];
      unsigned int num_mixers;
      const struct hda_verb *base_init_verbs;
@@ -1174,6 +1177,7 @@ enum {
      QUIRK_R3D,
      QUIRK_AE5,
      QUIRK_AE7,
+    QUIRK_GENERIC,
      QUIRK_NONE = HDA_FIXUP_ID_NOT_SET,
  };

@@ -1292,6 +1296,20 @@ static const struct hda_pintbl ae7_pincfgs[] = {
      {}
  };

+static const struct hda_pintbl ca0132_generic_pincfgs[] = {
+    { 0x0b, 0x41014111 },
+    { 0x0c, 0x414520f0 }, /* SPDIF out */
+    { 0x0d, 0x01014010 }, /* lineout */
+    { 0x0e, 0x41c501f0 },
+    { 0x0f, 0x411111f0 }, /* disabled */
+    { 0x10, 0x411111f0 }, /* disabled */
+    { 0x11, 0x41012014 },
+    { 0x12, 0x37a790f0 }, /* mic */
+    { 0x13, 0x77a701f0 },
+    { 0x18, 0x500000f0 },
+    {}
+};
+
  static const struct hda_quirk ca0132_quirks[] = {
      SND_PCI_QUIRK(0x1028, 0x057b, "Alienware M17x R4", 
QUIRK_ALIENWARE_M17XR4),
      SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
@@ -1304,6 +1322,7 @@ static const struct hda_quirk ca0132_quirks[] = {
      SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
      SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
      SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", 
QUIRK_R3DI),
+    SND_PCI_QUIRK(0x1458, 0xA046, "Gigabyte GA-Z170X-Gaming G1", 
QUIRK_GENERIC),
      SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
      SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
      SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
@@ -1325,6 +1344,7 @@ static const struct hda_model_fixup 
ca0132_quirk_models[] = {
      { .id = QUIRK_R3D, .name = "r3d" },
      { .id = QUIRK_AE5, .name = "ae5" },
      { .id = QUIRK_AE7, .name = "ae7" },
+    { .id = QUIRK_GENERIC, .name = "generic" },
      {}
  };

@@ -9882,14 +9902,57 @@ static void sbz_detect_quirk(struct hda_codec 
*codec)
      }
  }

+static void ca0132_generic_init_hook(struct hda_codec *codec)
+{
+    struct ca0132_spec *spec = codec->spec;
+
+    snd_hda_sequence_write(codec, spec->spec_init_verbs);
+}
+
+static int ca0132_generic_probe(struct hda_codec *codec)
+{
+    struct ca0132_spec *spec = codec->spec;
+    struct auto_pin_cfg *cfg = &spec->gen.autocfg;
+    int err;
+
+    snd_hda_gen_spec_init(&spec->gen);
+
+    snd_hda_apply_pincfgs(codec, ca0132_generic_pincfgs);
+
+    ca0132_init_chip(codec);
+
+    err = ca0132_prepare_verbs(codec);
+    if (err < 0)
+        return err;
+
+    err = snd_hda_parse_pin_def_config(codec, cfg, NULL);
+    if (err < 0)
+        return err;
+    err = snd_hda_gen_parse_auto_config(codec, cfg);
+    if (err < 0)
+        return err;
+
+    spec->gen.init_hook = ca0132_generic_init_hook;
+    spec->gen.automute_speaker = 0;
+    spec->gen.automute_lo = 0;
+
+    snd_hda_sequence_write(codec, spec->spec_init_verbs);
+    return 0;
+}
+
  static void ca0132_codec_remove(struct hda_codec *codec)
  {
      struct ca0132_spec *spec = codec->spec;

-    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
+    switch (ca0132_quirk(spec)) {
+    case QUIRK_GENERIC:
+        snd_hda_gen_remove(codec);
+        return;
+    case QUIRK_ZXR_DBPRO:
          return dbpro_free(codec);
-    else
+    default:
          return ca0132_free(codec);
+    }
  }

  static int ca0132_codec_probe(struct hda_codec *codec,
@@ -9906,14 +9969,21 @@ static int ca0132_codec_probe(struct hda_codec 
*codec,
      codec->spec = spec;
      spec->codec = codec;

-    /* Detect codec quirk */
-    snd_hda_pick_fixup(codec, ca0132_quirk_models, ca0132_quirks, NULL);
-    if (ca0132_quirk(spec) == QUIRK_SBZ)
-        sbz_detect_quirk(codec);
-
+    /* These must be set before any path is taken */
      codec->pcm_format_first = 1;
      codec->no_sticky_stream = 1;

+    /* Detect codec quirk */
+    snd_hda_pick_fixup(codec, ca0132_quirk_models, ca0132_quirks, NULL);
+    switch (ca0132_quirk(spec)) {
+    case QUIRK_SBZ:
+        sbz_detect_quirk(codec);
+        break;
+    case QUIRK_GENERIC:
+        return ca0132_generic_probe(codec);
+    default:
+        break;
+    }

      spec->dsp_state = DSP_DOWNLOAD_INIT;
      spec->num_mixers = 1;
@@ -10014,36 +10084,51 @@ static int ca0132_codec_build_controls(struct 
hda_codec *codec)
  {
      struct ca0132_spec *spec = codec->spec;

-    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
+    switch (ca0132_quirk(spec)) {
+    case QUIRK_GENERIC:
+        return snd_hda_gen_build_controls(codec);
+    case QUIRK_ZXR_DBPRO:
          return dbpro_build_controls(codec);
-    else
+    default:
          return ca0132_build_controls(codec);
+    }
  }

  static int ca0132_codec_build_pcms(struct hda_codec *codec)
  {
      struct ca0132_spec *spec = codec->spec;

-    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
+    switch (ca0132_quirk(spec)) {
+    case QUIRK_GENERIC:
+        return snd_hda_gen_build_pcms(codec);
+    case QUIRK_ZXR_DBPRO:
          return dbpro_build_pcms(codec);
-    else
+    default:
          return ca0132_build_pcms(codec);
+    }
  }

  static int ca0132_codec_init(struct hda_codec *codec)
  {
      struct ca0132_spec *spec = codec->spec;

-    if (ca0132_quirk(spec) == QUIRK_ZXR_DBPRO)
+    switch (ca0132_quirk(spec)) {
+    case QUIRK_GENERIC:
+        return snd_hda_gen_init(codec);
+    case QUIRK_ZXR_DBPRO:
          return dbpro_init(codec);
-    else
+    default:
          return ca0132_init(codec);
+    }
  }

  static int ca0132_codec_suspend(struct hda_codec *codec)
  {
      struct ca0132_spec *spec = codec->spec;

+    if (ca0132_quirk(spec) == QUIRK_GENERIC)
+        return 0;
+
      cancel_delayed_work_sync(&spec->unsol_hp_work);
      return 0;
  }
-- 
2.54.0

Signed-off-by: Ezio Galeazzi <eziogale@gmail.com>

