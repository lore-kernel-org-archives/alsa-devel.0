Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0815C4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Dec 2022 09:37:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24B272126;
	Thu, 15 Dec 2022 10:37:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24B272126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671097072;
	bh=K5IzDCWVlYzH0FrIDIcK+8IhqkaZcnzSMXBXD9x+Xw4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DTzXQSW1mNRKryHPZxZnSRCHzL36TC/WwRE/i802h+KnTN1PaWuar/wFlRxqxaLiK
	 dLF6afisiZwJQiM38IY8r0c0P3YyNXwHw44Fcczu85Ep8c8At0OIBNMdJvXzO0TZIJ
	 fmZNFel3J8LGRDrniz5JInkpaC40eO42mo/v6X30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB920F804FD;
	Thu, 15 Dec 2022 10:36:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED789F804ED; Thu, 15 Dec 2022 10:36:36 +0100 (CET)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13D38F804E7
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2022 10:36:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13D38F804E7
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=NRrPSD+Q
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E21F98546A;
 Thu, 15 Dec 2022 10:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1671096994;
 bh=vUFV5R8bOhefsqOpqWAdoI5RFb/9UxmbNJq1tx/Av7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NRrPSD+QLVUK3bepqgOCbe1axpXNykKURsTidZFGb2i2YHXhFlYKXkVB3df1TllF9
 cee8OuERe/R8yjf67/nDbOdl+ZV57tykGA3vsSCscbzk+BLAdQtOGyIPCeuZydFMKt
 uTzrY2xSzlRoQMb5MuCE/gyvmv+v7MO4W0DPJA2CKRof26JAhrEryHfcWaVJYLvaKT
 D5O6ursxmW1VLyAiInpTi+Mv7mEO+WRkWWAe8rbLj7g8CcXK6yRzXZods/jwRbUmxm
 IywzQZWnSkAXjsYV/GH8Vtudl/SAR5G0P6q1bJyIgSMWs7+ZeHje1F9V4lA1DohMkx
 X/t6BZBh0oErg==
From: Lukasz Majewski <lukma@denx.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 3/3] ASoC: wm8940: Read chip ID when wm8940 codec probing
Date: Thu, 15 Dec 2022 10:36:15 +0100
Message-Id: <20221215093615.3794156-3-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221215093615.3794156-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221215093615.3794156-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Stephen Kitt <steve@sk2.org>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The wm8940 provides the chip ID information via I2C. In this
patch this information is read and if not matching expected
value, the probe function is aborted.

This prevents from using (i.e. inserting) other wm89* modules
which use the same I2C bus address.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Changes for v2:
- None
---
 sound/soc/codecs/wm8940.c | 11 +++++++++++
 sound/soc/codecs/wm8940.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 1b02d5e8a007..8eb4782c9232 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -760,6 +760,17 @@ static int wm8940_probe(struct snd_soc_component *component)
 	int ret;
 	u16 reg;
 
+	/*
+	 * Check chip ID for wm8940 - value of 0x00 offset
+	 * SOFTWARE_RESET on write
+	 * CHIP_ID on read
+	 */
+	reg = snd_soc_component_read(component, WM8940_SOFTRESET);
+	if (reg != WM8940_CHIP_ID) {
+		dev_err(component->dev, "Wrong wm8940 chip ID: 0x%x\n", reg);
+		return -ENODEV;
+	}
+
 	ret = wm8940_reset(component);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to issue reset\n");
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
index 0d4f53ada2e6..86bbf902ef5a 100644
--- a/sound/soc/codecs/wm8940.h
+++ b/sound/soc/codecs/wm8940.h
@@ -95,5 +95,8 @@ struct wm8940_setup_data {
 #define WM8940_OPCLKDIV_3 2
 #define WM8940_OPCLKDIV_4 3
 
+/* Chip ID */
+#define WM8940_CHIP_ID 0x8940
+
 #endif /* _WM8940_H */
 
-- 
2.20.1

