Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB3FA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:33:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0761020820
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZMcvQ0P2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Mg1uX9tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76E8B10E;
	Thu, 17 Oct 2019 10:15:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76E8B10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571300168;
	bh=lWTvA1CnvqmXyQ9jf0TS57x/Xl6ccH7J2CQQ6olHC9o=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZMcvQ0P2DrTJD/eLs46Ne6wwdxuqLdBb+1OuV7+ZOLyV4EsP+EdNG5nOp1Rwl3IGy
	 WqCQDV/yShoW1EDIY0ijuD0VUW7gSZ4bofWO/+fOheWjB7+bLZ8pVzlBiv3Sa/2J0D
	 PbK9CQkz9CaTDM39M+NLDAiDHJoUYsJ7hwcuQXK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAED8F804A9;
	Thu, 17 Oct 2019 10:15:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41A95F804AA; Thu, 17 Oct 2019 10:15:16 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B31FF80322
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 10:15:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B31FF80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com
 header.i=@endlessm-com.20150623.gappssmtp.com header.b="Mg1uX9tc"
Received: by mail-pg1-x541.google.com with SMTP id i76so905434pgc.0
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HY5lOA4BNY1FK/SRRfqykiftlf7bb+htjjsAKEHZzI8=;
 b=Mg1uX9tc9TY9aIf4vVBEZtvE50A2YSsdYNl0d01jxJYvTqw3bEJ9QmaHECm3djZQ/V
 LaQsPflsqQctbjvxr7hR5ofwJ2qP0Y5q0vZqfkrMiQ6t7oJsOpn0K77Y4G/4hcvKU1jq
 nkCwrtAyNPYXlONa5HRjBu62bgbbaR2OusDb/IyXsSHlDPPvgp0Ryf//7eFYw0r2tiM0
 SJXqvEH557nFFoKj0v8kiBlZ8JaeyL6Pg4jv0qQsYHU8VIFNip1P5JMBZnnFOE/6L91j
 yTbNOwRChJoKN8RJRWGaWOMg85/Kabn2R/zc1rTXG41C+EKMbsjIkgUr6ud7Lm/DGFfe
 7MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HY5lOA4BNY1FK/SRRfqykiftlf7bb+htjjsAKEHZzI8=;
 b=khJUgZfXWoh7PRSNoDjQJiYzNOEIy50/8njCzLGhs3scb6Su7nxMe6L2gjpFZj2MbL
 6HDGBICty2JyFCIWRYovAKGBfNk2jPd49NDSQxbKRake6OXE8LKnF3cqxmL6lLieCB6j
 aKmr4UNRPBWlkD1xFaZ18rHswymiOE1gdsL2IJXVKBiU8u+t04A6mJdCqLXKP4zyunlm
 H0QRJ1kv8SWlF1MdD9uzYfmkeaIsr48dD2mQtluQ3Oj02qa8IztBqE5ncgee+KXmwRKD
 nPByRqjN0CPdFztz32EXOOn41PaVxgLYyhFz9yvHn+dhG+lZqvKHrQZP4TOdPzMnltwJ
 zcEw==
X-Gm-Message-State: APjAAAUde5ezBLdeIOo9Dh8Ug6vCG4LAwiExkCPpxoYaQNiyAF7TmhtO
 u4t9T1oVBkyCQue1N2XzBit6Dw==
X-Google-Smtp-Source: APXvYqzwPSnSjXZJZfXSnH6xAxx+fNYPuhpbP3OqjtmvcHJ1YfY9QnpX6zvH6xuFERtoK+LhO5+fJg==
X-Received: by 2002:aa7:9538:: with SMTP id c24mr2429056pfp.8.1571300111164;
 Thu, 17 Oct 2019 01:15:11 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id dw19sm1589877pjb.27.2019.10.17.01.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 01:15:10 -0700 (PDT)
From: Daniel Drake <drake@endlessm.com>
To: perex@perex.cz,
	tiwai@suse.com
Date: Thu, 17 Oct 2019 16:15:01 +0800
Message-Id: <20191017081501.17135-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux@endlessm.com
Subject: [alsa-devel] [PATCH] ALSA: hda/realtek - Enable headset mic on Asus
	MJ401TA
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Asus MJ401TA (with Realtek ALC256), the headset mic is connected to
pin 0x19, with default configuration value 0x411111f0 (indicating no
physical connection).

Enable this by quirking the pin. Mic jack detection was also tested and
found to be working.

This enables use of the headset mic on this product.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b000b36ac3c6..e9fc5d8ff497 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5869,6 +5869,7 @@ enum {
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
+	ALC256_FIXUP_ASUS_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
 	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
@@ -6912,6 +6913,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
 	},
+	[ALC256_FIXUP_ASUS_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11020 }, /* headset mic with jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 	[ALC256_FIXUP_ASUS_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7108,6 +7118,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
