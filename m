Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC26EC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 21:29:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050F123B1A
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 21:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050F123B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A38616E1;
	Tue,  8 Dec 2020 22:28:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A38616E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607462941;
	bh=y4a3G1H1O+mXzsmzvTdacRS5Ne7mFqPqgLDmdr4Uz2Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k65cGTP7/l4zN3ocuD0cwQxXzBiOBmbl2gGhpMwezZoye+PcAOszPd425rj9vfh23
	 e5u98c2ZwIOZTp14fP+x9CJxhmg1S35S3I4FNA7tDOocmgkpLXLsLCQigaWE8dLGGd
	 IQp2fVYDdfUerq177uOeD2LHBITDTEvaSxUvNXFg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70247F804DF;
	Tue,  8 Dec 2020 22:26:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74691F80253; Tue,  8 Dec 2020 22:26:31 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7343CF80269
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 22:26:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7343CF80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ouekelFv"
Received: by mail-qk1-x742.google.com with SMTP id b144so28836qkc.13
 for <alsa-devel@alsa-project.org>; Tue, 08 Dec 2020 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XsyJ3gRTYQTAHCmnlDsIOFfZYOcu+GEmry0fZOE/64g=;
 b=ouekelFvEGX4aWZ0CakOks1nK7SgGIo3nLeWVGG6Rqckiqqf2JL+udHXM27b01EGTa
 R/IixshboMWM1uHCkG6iT9LGJODk78beR8NsMpN9Z8ZSphrI+no3e6iOzI6OjXqbP+Py
 QphZNjPmiMEsmq8CWKGbNWG7qeTFdhHE67Ng1UU4PW+TiMpV5UEPACAaRU7Ny10RfRvL
 uE27JDGgcJYTvJHJu/Ung9Smm7CbGYwZsASncTonRgiQY7+ObOs8dH7EM+JwoZ1VtLU8
 +nlnLoBxjZzBHK9ymN0yd6wZshTrbsEvG+dizGwAUecpxTGv9NZoS3e5qW5IHecAuIfw
 Xb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XsyJ3gRTYQTAHCmnlDsIOFfZYOcu+GEmry0fZOE/64g=;
 b=UwOk6mvm/mcXsKmZmq/HR7SPqrv/wBc2VOGE/A9H7NCpSvKn8LDZXYc/7K+z4VvhNR
 I1Vr2JNPC/HdGRR0ZdmxLL1zGyf1E8hneGmsvlzTETG3I/X7kiHruPZmmdfmSe14X9Vl
 GaiPuZ+Bk3vhtTAJEc+TWheQ3B2LDczZACu1LusKo4F6zKPIU0k6WCqCfYFGxZ101pYi
 XtsnR+jGxSRe7ZMwomB8G4CAZxmb1Q2Kw2hLW4FJcyRPKbOxm7TNqY4hRnDCikHQGHhq
 dIj3vg6/Doj3dO0lJmw6r6jl6NwelYQoYZ/ZAZGuJuxp4eW/PxMsY69gaC0SB0pYALby
 aeFw==
X-Gm-Message-State: AOAM532Ph6P/HGPfJEQ44qP/DDx9mfP/KBAbEqi1vK2C5sWN8ISnjMkB
 jeY/VCuXkfbadjPhItJuuoY=
X-Google-Smtp-Source: ABdhPJwRqfeo69ee1GtzvXdcEFMUHjl9hP2aNtT+aDgUwXl5+wpPulO6P2XaFWGE5coAuEkdM/ftDA==
X-Received: by 2002:a37:a315:: with SMTP id m21mr14315303qke.279.1607462785552; 
 Tue, 08 Dec 2020 13:26:25 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id l1sm16018572qkj.101.2020.12.08.13.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 13:26:25 -0800 (PST)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 3/5] ALSA: hda/ca0132 - Add 8051 exram helper functions.
Date: Tue,  8 Dec 2020 16:25:43 -0500
Message-Id: <20201208212546.428392-4-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208212546.428392-1-conmanx360@gmail.com>
References: <20201208212546.428392-1-conmanx360@gmail.com>
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

Add functions for both reading and writing to the 8051's exram. Also,
add a little bit of documentation on how the addresses are segmented.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 138 ++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 58 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 650a7e2bd311..cb725586d38b 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1901,6 +1901,71 @@ static void chipio_8051_write_direct(struct hda_codec *codec,
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, verb, addr);
 }
 
+/*
+ * Writes to the 8051's exram, which has 16-bits of address space.
+ * Data at addresses 0x2000-0x7fff is mirrored to 0x8000-0xdfff.
+ * Data at 0x8000-0xdfff can also be used as program memory for the 8051 by
+ * setting the pmem bank selection SFR.
+ * 0xe000-0xffff is always mapped as program memory, with only 0xf000-0xffff
+ * being writable.
+ */
+static void chipio_8051_write_exram(struct hda_codec *codec,
+		unsigned int addr, unsigned int data, bool use_mutex)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	if (use_mutex)
+		mutex_lock(&spec->chipio_mutex);
+
+	/* Lower 8-bits. */
+	tmp = addr & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, tmp);
+
+	/* Upper 8-bits. */
+	tmp = (addr >> 8) & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, tmp);
+
+	/* 8-bits of data. */
+	tmp = data & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, tmp);
+
+	if (use_mutex)
+		mutex_unlock(&spec->chipio_mutex);
+}
+
+/* Readback data from the 8051's exram. */
+static void chipio_8051_read_exram(struct hda_codec *codec,
+		unsigned int addr, unsigned int *data, bool use_mutex)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	if (use_mutex)
+		mutex_lock(&spec->chipio_mutex);
+
+	/* Lower 8-bits. */
+	tmp = addr & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, tmp);
+
+	/* Upper 8-bits. */
+	tmp = (addr >> 8) & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, tmp);
+
+	/* 8-bits of data. */
+	*data = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
+				   VENDOR_CHIPIO_8051_DATA_READ,
+				   0);
+
+	if (use_mutex)
+		mutex_unlock(&spec->chipio_mutex);
+}
+
 /*
  * Enable clocks.
  */
@@ -7422,18 +7487,10 @@ static void ca0132_init_analog_mic2(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	mutex_lock(&spec->chipio_mutex);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x2D);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+
+	chipio_8051_write_exram(codec, 0x1920, 0x00, false);
+	chipio_8051_write_exram(codec, 0x192d, 0x00, false);
+
 	mutex_unlock(&spec->chipio_mutex);
 }
 
@@ -7504,18 +7561,11 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 static void chipio_remap_stream(struct hda_codec *codec,
 		const struct chipio_stream_remap_data *remap_data)
 {
-	unsigned int i, stream_offset, tmp;
+	unsigned int i, stream_offset;
 
 	/* Get the starting port for the stream to be remapped. */
-	tmp = 0x1578 + remap_data->stream_id;
-	for (i = 0; i < 2; i++) {
-		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-				    VENDOR_CHIPIO_8051_ADDRESS_LOW + i,
-				    ((tmp >> (i * 8)) & 0xff));
-	}
-
-	stream_offset = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
-				   VENDOR_CHIPIO_8051_DATA_READ, 0);
+	chipio_8051_read_exram(codec, 0x1578 + remap_data->stream_id,
+			&stream_offset, false);
 
 	/*
 	 * Check if the stream's port value is 0xff, because the 8051 may not
@@ -7526,9 +7576,8 @@ static void chipio_remap_stream(struct hda_codec *codec,
 		for (i = 0; i < 5; i++) {
 			msleep(25);
 
-			stream_offset = snd_hda_codec_read(codec,
-					WIDGET_CHIP_CTRL, 0,
-					VENDOR_CHIPIO_8051_DATA_READ, 0);
+			chipio_8051_read_exram(codec, 0x1578 + remap_data->stream_id,
+					&stream_offset, false);
 
 			if (stream_offset != 0xff)
 				break;
@@ -7863,12 +7912,7 @@ static void ae5_post_dsp_param_setup(struct hda_codec *codec)
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x724, 0x83);
 	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x92);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0xfa);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x22);
+	chipio_8051_write_exram(codec, 0xfa92, 0x22, true);
 }
 
 static void ae5_post_dsp_pll_setup(struct hda_codec *codec)
@@ -8134,12 +8178,7 @@ static void ae7_post_dsp_asi_setup(struct hda_codec *codec)
 	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
 	snd_hda_codec_write(codec, 0x17, 0, 0x794, 0x00);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x92);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0xfa);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x22);
+	chipio_8051_write_exram(codec, 0xfa92, 0x22, true);
 
 	ae7_post_dsp_pll_setup(codec);
 	ae7_post_dsp_asi_stream_setup(codec);
@@ -9133,12 +9172,7 @@ static void r3d_pre_dsp_setup(struct hda_codec *codec)
 {
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
+	chipio_8051_write_exram(codec, 0x1c1e, 0x5b, true);
 
 	snd_hda_codec_write(codec, 0x11, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
@@ -9148,21 +9182,9 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
 {
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
-
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x40);
+	chipio_8051_write_exram(codec, 0x1c1e, 0x5b, true);
+	chipio_8051_write_exram(codec, 0x1920, 0x00, true);
+	chipio_8051_write_exram(codec, 0x1921, 0x40, true);
 
 	snd_hda_codec_write(codec, 0x11, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
-- 
2.25.1

