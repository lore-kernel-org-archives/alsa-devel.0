Return-Path: <SRS0=MUjV=AW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142FAC433E1
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:43:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1E620725
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JJRGKkrF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="Hd6yQK7w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="Hd6yQK7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1E620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=retarded.farm
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E297115E5;
	Sat, 11 Jul 2020 11:42:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E297115E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594460613;
	bh=SFAjyT3q05ZULONF36LDRYwHJ4n7phGDJ0Un7uXT01E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JJRGKkrFvMHF1WG+knYGX/mHpR+RYz0QjKa6hJKBysxWwMY17zO8ddpDzertr+waz
	 Elm3Psu8FWuFdVzhUhIZZe94UyjSVz0TKvkwZj9pjlrD20ILHXtGZj31PMizIKGtzB
	 0gt9evh34zYu4E4/o/nmtn1K6d8HhLQz3osa4HYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 591ECF8011C;
	Sat, 11 Jul 2020 11:42:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 889C5F80216; Sat, 11 Jul 2020 11:42:40 +0200 (CEST)
Received: from mail.bin-co.de (mail.bin-co.de [IPv6:2a02:c207:3002:169::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E0A3F8011C
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2020 11:42:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E0A3F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="Hd6yQK7w"; 
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="Hd6yQK7w"
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id EE9D74443EB0;
 Sat, 11 Jul 2020 11:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1594460552;
 bh=SFAjyT3q05ZULONF36LDRYwHJ4n7phGDJ0Un7uXT01E=;
 h=From:To:Cc:Subject:Date:From;
 b=Hd6yQK7wZ4FR02r9WJQ4vBx4ldLZ5J/NEB41CXHzHuLNsGNKLKRaXQtIQi4xtmQoe
 XDyWG0QjVePP1S1p7zWditPHJp3cpSoiDtGBFF6zuYlBD4t2FkKUdXTJx9D3YwCdZG
 5FkAm3q4SGoHTKqutYRejIrZL2lQHTfqH/E9vsNY5pl7kBXSbbGI+D7S3cuj1vk1G2
 DVzL0miJAXJ7QdhHSyn42GqCPvJGQXZU0yanH4zUn1BqvCowJE0FaEPQ/Rnc30ve9R
 l3+x27fwxZCUQDGnQkqiJRhwy4L/LTZ+3kPD+QPyAV9SbqJdL7o1sDnZ7LNJ4N1/Mb
 Z1LIvC8wB4U6A==
X-Virus-Scanned: amavisd-new at bin-co.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vdf2t4eWkG92; Sat, 11 Jul 2020 11:42:32 +0200 (CEST)
Received: from DeepBlue.zlan.intra (unknown [90.187.13.225])
 (Authenticated sender: zappel@retarded.farm)
 by mail.bin-co.de (Postfix) with ESMTPSA id 565774443EAC;
 Sat, 11 Jul 2020 11:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1594460552;
 bh=SFAjyT3q05ZULONF36LDRYwHJ4n7phGDJ0Un7uXT01E=;
 h=From:To:Cc:Subject:Date:From;
 b=Hd6yQK7wZ4FR02r9WJQ4vBx4ldLZ5J/NEB41CXHzHuLNsGNKLKRaXQtIQi4xtmQoe
 XDyWG0QjVePP1S1p7zWditPHJp3cpSoiDtGBFF6zuYlBD4t2FkKUdXTJx9D3YwCdZG
 5FkAm3q4SGoHTKqutYRejIrZL2lQHTfqH/E9vsNY5pl7kBXSbbGI+D7S3cuj1vk1G2
 DVzL0miJAXJ7QdhHSyn42GqCPvJGQXZU0yanH4zUn1BqvCowJE0FaEPQ/Rnc30ve9R
 l3+x27fwxZCUQDGnQkqiJRhwy4L/LTZ+3kPD+QPyAV9SbqJdL7o1sDnZ7LNJ4N1/Mb
 Z1LIvC8wB4U6A==
From: Armas Spann <zappel@retarded.farm>
To: alsa-devel@alsa-project.org
Subject: [PATCH v1] ALSA: hda/realtek: enable headset mic of ASUS ROG Zephyrus
 G14(G401) series with ALC289
Date: Sat, 11 Jul 2020 11:42:09 +0200
Message-Id: <20200711094209.6184-1-zappel@retarded.farm>
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
 ALSA: hda/realtek: enable headset mic of ASUS ROG Zephyrus G14(G401) series with ALC289

 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 194ffa8c66ce..2e7d4ebf8ce7 100644
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
-- 
2.27.0

