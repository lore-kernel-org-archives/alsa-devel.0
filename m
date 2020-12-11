Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D85C4167B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 22:57:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C27207A8
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 22:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C27207A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2DEF1774;
	Fri, 11 Dec 2020 23:56:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2DEF1774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607727426;
	bh=AUUzZyNg3c0CE9nPW9PcNtKG/wrDPico+7lhI5tEc8s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzI+QZhPRXuLE4ETFaUtP5+yIoumASDSZ/OBV4EkPVtIqqOdxf1aGJE1Ia6Z1wzwE
	 qk47L6rtFE2xLRs/I/Dx3L2B/+RkNJQ3Vy69rnHDMc4ofPBAxVPoRoWfHrPRNUAn8U
	 GmGlf+7r7Dj/ntpAoN8npXEzFget2Z63Vzyw9ESY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BD2BF80240;
	Fri, 11 Dec 2020 23:55:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 071E3F8020D; Fri, 11 Dec 2020 23:55:23 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91571F801D8
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 23:55:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91571F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="AqqtCb4W"
Received: by mail-qk1-x742.google.com with SMTP id z188so10109997qke.9
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 14:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=91dC1JVTlycX9DwyWLDLt83zlsH68mf4lgen207BrgI=;
 b=AqqtCb4WjaYw2Ac8A65qbodZn5poIM0B6PsVJIFeXpreANb9qzaLOz+waqPB8KjOSZ
 Th3T0aFrAHW+duJIr0BCw6QzA1rTF+34wELRflkAvCngFjNM8nRoorwrHEL8bmctLQHV
 R1O856qVaN1IC6VUuhzIPH/3j4tqykuflXZECUAr3Q813KoM1LM22wEF2BcECN2A3BhF
 sy5kXMifjhFulcCKdpsr71ppeMHLKDshrXqEyzI3IAWi2lF+lpjaKODaogKVL6dD7JbT
 IN1caiGOx+wJBGv9RYgFkWb5vJ+LKiM8hXY9EI2i528jdih6OlvEhcHFDGBSipFaWe4y
 vg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=91dC1JVTlycX9DwyWLDLt83zlsH68mf4lgen207BrgI=;
 b=mrwlHhuepppCxDGvRLGRzDKLuYZ6WzOoMKj2dGlaIJvW9ClKAetibC+GQA1fv3Lvx2
 hSFQlic9UUtjamtLn/xPLe+rnv6ogxisOZvzw3l9SIzKUZy8nS9kutJdg9+rz5ZBctub
 kBsmYNfKsCMsARWaLOH4Nb3YIHebkuRmxv5pOIb0CH61UxUEjmvrB1GNg6CXNsvai84w
 7Mey8vfqfI4AvfLYX6S+1nEsKm0HhPKs9g/8DBVfOlamjy1NDvvFckJ/9XafGaTXmeuC
 /ABKpa4dZjfWtll1yQ+iUSJzErrelKrn7bXsJNDpQ8lZ/Sbz6VN7hk7XnLDaZFW2U5A9
 VjVg==
X-Gm-Message-State: AOAM532TMln7Wb/iSaGQAugrdJmuXKeN5FU0t9xDy1lSqHZxtPjs+UWC
 cEAHAgqb7ZC0X7xbEf0eb2M=
X-Google-Smtp-Source: ABdhPJyiFdSxAUB9dEi6Qy9MMSVXa3+du6Eo6hrKhLi6zRvgDTfGZwi4SINrjvOUh97ryrGV6EAjUw==
X-Received: by 2002:a37:4fc4:: with SMTP id d187mr175606qkb.200.1607727319502; 
 Fri, 11 Dec 2020 14:55:19 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id i4sm7409594qti.78.2020.12.11.14.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 14:55:19 -0800 (PST)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 2/2] ALSA: hda/ca0132 - Add ZxR surround DAC setup.
Date: Fri, 11 Dec 2020 17:55:03 -0500
Message-Id: <20201211225504.4508-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211225504.4508-1-conmanx360@gmail.com>
References: <20201211225504.4508-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, conmanx360@gmail.com
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

Add pre-dsp download initialization for the DAC's used in the surround
sound configuration. Fixes issues of no audio on surround channels.

Fixes: 2e492b8ee5da8 ("ALSA: hda/ca0132 - Add ZxR init commands")
Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9b6b7601a881..7e62aed172a9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -9186,6 +9186,44 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
 }
 
+/*
+ * The ZxR seems to use alternative DAC's for the surround channels, which
+ * require PLL PMU setup for the clock rate, I'm guessing. Without setting
+ * this up, we get no audio out of the surround jacks.
+ */
+static void zxr_pre_dsp_setup(struct hda_codec *codec)
+{
+	static const unsigned int addr[] = { 0x43, 0x40, 0x41, 0x42, 0x45 };
+	static const unsigned int data[] = { 0x08, 0x0c, 0x0b, 0x07, 0x0d };
+	unsigned int i;
+
+	chipio_write(codec, 0x189000, 0x0001f100);
+	msleep(50);
+	chipio_write(codec, 0x18900c, 0x0001f100);
+	msleep(50);
+
+	/*
+	 * This writes a RET instruction at the entry point of the function at
+	 * 0xfa92 in exram. This function seems to have something to do with
+	 * ASI. Might be some way to prevent the card from reconfiguring the
+	 * ASI stuff itself.
+	 */
+	chipio_8051_write_exram(codec, 0xfa92, 0x22);
+
+	chipio_8051_write_pll_pmu(codec, 0x51, 0x98);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x725, 0x82);
+	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 3);
+
+	chipio_write(codec, 0x18902c, 0x00000000);
+	msleep(50);
+	chipio_write(codec, 0x18902c, 0x00000003);
+	msleep(50);
+
+	for (i = 0; i < ARRAY_SIZE(addr); i++)
+		chipio_8051_write_pll_pmu(codec, addr[i], data[i]);
+}
+
 /*
  * These are sent before the DSP is downloaded. Not sure
  * what they do, or if they're necessary. Could possibly
@@ -9447,8 +9485,10 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
 		break;
 	case QUIRK_ZXR:
+		chipio_8051_write_pll_pmu(codec, 0x49, 0x88);
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		zxr_pre_dsp_setup(codec);
 		break;
 	default:
 		break;
-- 
2.25.1

