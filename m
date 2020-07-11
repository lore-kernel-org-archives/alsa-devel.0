Return-Path: <SRS0=MUjV=AW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68993C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:07:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EA42077D
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WF66SXKD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="DO+JqXC5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="glJsy8z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EA42077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=retarded.farm
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62C1015F2;
	Sat, 11 Jul 2020 13:06:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62C1015F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594465659;
	bh=ZQfoaKJ0+CASnrgZ0VUOy3rNf1fjg9HOI2nkW7LEY+Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WF66SXKDIqsfFEjwXUeoZgEYEStbzHJttIajvRgRCVe+UtWx6O8GYv8EgpLswM2ZF
	 gfBO7/v7fyszWgnMtYCBbUBmKXYh/eToPx17onQqz6aWF/4bpt9+TJ1LCqDfXzStI4
	 9f0o8rt3zKyGZXm8cYtV8r5vQdDLv2atW6SAFV/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1533F80084;
	Sat, 11 Jul 2020 13:06:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D6A7F80216; Sat, 11 Jul 2020 13:06:47 +0200 (CEST)
Received: from mail.bin-co.de (mail.bin-co.de [173.212.200.19])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B52BDF80084
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2020 13:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B52BDF80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="DO+JqXC5"; 
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="glJsy8z5"
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 09E5D4443DAB;
 Sat, 11 Jul 2020 13:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1594465599;
 bh=ZQfoaKJ0+CASnrgZ0VUOy3rNf1fjg9HOI2nkW7LEY+Q=;
 h=From:To:Cc:Subject:Date:From;
 b=DO+JqXC5da/jOpftjYq2A02aPEvOMf2aTzj8Cj6MDE4IkbJSzCPunbm3LBBXlonqC
 Vt1CvTrkaJPfmVEBEy/rYc4110TuHIiJmNJecrz6dB8LEFLAMa165NMZPYuTw8s8cg
 8tAhdKS806YPCn4iaYvtkAPN537AYz6EjcU8tnRfKdApfV/XUqfHLemPKfH65O/Jk2
 ndYr//prYHhEYGj3vtw5bRsdqTHsC19nooFGQwTwZDRJLRNSeGxOe3G+QlVieciMHC
 aWHB0TEiaNeTC1ZpI8PGHOer7D56rbs/nIVaQ48CS4rj6chXMYPhLDaQwMYHn+l/Lr
 jkNMxQL1/IOEA==
X-Virus-Scanned: amavisd-new at bin-co.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTD240McClFO; Sat, 11 Jul 2020 13:06:38 +0200 (CEST)
Received: from DeepBlue.zlan.intra (unknown [90.187.13.225])
 (Authenticated sender: zappel@retarded.farm)
 by mail.bin-co.de (Postfix) with ESMTPSA id EB4864442DBA;
 Sat, 11 Jul 2020 13:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1594465598;
 bh=ZQfoaKJ0+CASnrgZ0VUOy3rNf1fjg9HOI2nkW7LEY+Q=;
 h=From:To:Cc:Subject:Date:From;
 b=glJsy8z5at/vCjGwaXmFnz9O6QT2CZZalp0Xxycpj860OKxsr/rfnRKcdoOxFS2sF
 ozMtXMGFtDodDVL8t739zqeMQrmWSaXMjo/6di6EXhbmYjnCKMiBOWWD9Mgm3As1xP
 UKgl4/Qn2DPkmFqNQhjdIk25B5OKMn6McTqfZkt3MlgvdHy/2bnsvxlyQH9Bx9Vhc/
 Sd6vUfTEjRjf8H2baI/9InU9hsmhsrQwZAnpJSKVwWEG3a+RY6/YvbdCJeIV5pxQAR
 mBwdcHCuSz89UHokHrOGo/JLhANWuFggQfItdfivcxE51OmQMwkl0pW5z+zth+S7ha
 EwZiG4+3uhiVQ==
From: Armas Spann <zappel@retarded.farm>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3] ALSA: hda/realtek: enable headset mic of ASUS ROG Zephyrus
 G14(G401) series with ALC289
Date: Sat, 11 Jul 2020 13:05:57 +0200
Message-Id: <20200711110557.18681-1-zappel@retarded.farm>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Armas Spann <zappel@retarded.farm>, tiwai@suse.com
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

Signed-off-by: Armas Spann <zappel@retarded.farm>
---
 Description:
 This patch adds support for headset mic to the ASUS ROG Zephyrus G14(GA401) 
 notebook series by adding the corresponding vendor/pci_device id, as well as
 adding a new fixup for the used realtek ALC289. The fixup stets the correct
 pin to get the headset mic correctly recognized on audio-jack.

 Changelog:
 v1: initial
 v2: added missing vendor and device(pci) id
 v3: added description

 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 194ffa8c66ce..ff4f3eeedfd0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6152,6 +6152,7 @@ enum {
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
+	ALC289_FIXUP_ASUS_G401,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7359,6 +7360,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC289_FIXUP_ASUS_G401] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11020 }, /* headset mic with jack detect */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7539,6 +7547,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_G401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
-- 
2.27.0

