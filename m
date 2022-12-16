Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714C1C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Dec 2022 09:47:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A35101711;
	Fri, 16 Dec 2022 10:46:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A35101711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671184053;
	bh=IeD0B8wrVHUUYf30Gdom7+YGLGN0G/Z2xIwMgcFoYgk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=rM+hphO1bKLY5AwqmIMfue+w2CiRl9EX5L2DAI3iPHV9taf7dKuaPtsA+uaMr2Td2
	 uwqF/H3TD0vo6fh4uwfv3oK/Q7QK8l2DHg8MlyS2G2yTw7vs6gZA/nfS7eCSSGAaof
	 jbDL7NbbJsw/iMEtlRLxA2/o1140GRM3PA1TJ+c0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C7B5F804E0;
	Fri, 16 Dec 2022 10:46:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDA21F804E0; Fri, 16 Dec 2022 10:46:41 +0100 (CET)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31D02F804E0
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2022 10:46:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31D02F804E0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=fNAU4cYJ
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 48ECD85205;
 Fri, 16 Dec 2022 10:46:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1671183999;
 bh=/H6fBZQRWEmDLxoUqkA4ISnIrcRGBzcSkN81MSyyxEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fNAU4cYJpyQEcY4v4lZZsysJ4r16bYRseOWLGq0HSYwdeMNCAyO5EUouJzYFPioMU
 hMkozV+HklaqCTbdk3M23L20P6nBwrnCiJ6OBWxtrmjWVU27GcvsELssJeqCQzAFGh
 9Lr9w8sLCj8fHEK0WPbbHAiIS42BcXtYCjjcbQBhLXzZeg8OzABuccZB8E8jf/ZGWq
 2qgk/dbQlWo/LoTNm6LTkyxNPCmiZMsjNhV1JmPIRtAHSC3I+x0fSeqMgnsYpimBmP
 cWjhGUjkH/DDNO5zLx/FqTcf5iQdfpedBgVjf7txkeOvXB28+W3fPt+M4vk5/UWwQ7
 zqoXWfkOko0sA==
From: Lukasz Majewski <lukma@denx.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v3 3/3] ASoC: wm8940: Read chip ID when wm8940 codec probing
Date: Fri, 16 Dec 2022 10:46:24 +0100
Message-Id: <20221216094624.3849278-3-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216094624.3849278-1-lukma@denx.de>
References: <20221216094624.3849278-1-lukma@denx.de>
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
Changes for v3:
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

