Return-Path: <SRS0=4jWs=BD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD25C433EB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:10:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCCB20674
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JMANFTPq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="ZjTCwoqw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="Q8snL7pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCCB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=retarded.farm
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F0AA167F;
	Fri, 24 Jul 2020 16:09:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F0AA167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595599801;
	bh=Cg949X7IAeu9wfN9Utwbw0fjiU47o69X2CSm/Q0xv24=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JMANFTPqAvLsN3oPCZneDh/+SGtcbXtaF0Kh86wX8Rt1ZzmBayaMt1rXRcCGI/pUq
	 yyiMWJGQmSgiCybGc/uW/UWXWzkwxNb+zCYo2wVZQ56ZgNF3NEGZse2uX/ppU4qMhk
	 /Mo+e2aDLyl3D1ew69m6daDUv7XXDJ0qFrG2yhNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02A25F80141;
	Fri, 24 Jul 2020 16:09:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E66C4F80150; Fri, 24 Jul 2020 16:09:06 +0200 (CEST)
Received: from mail.bin-co.de (mail.bin-co.de [IPv6:2a02:c207:3002:169::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19F9BF800DF
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 16:08:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19F9BF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="ZjTCwoqw"; 
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="Q8snL7pP"
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 68D5E44437D3;
 Fri, 24 Jul 2020 16:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1595599727;
 bh=Cg949X7IAeu9wfN9Utwbw0fjiU47o69X2CSm/Q0xv24=;
 h=From:To:Cc:Subject:Date:From;
 b=ZjTCwoqwsedW0lq3vfSQRvbIVtr2O5N1aRuelHBzgZpKBaLhrTy0hzF7oqYkW06Bn
 ySRPROIVRcJe5jlUaYj7dJNOwgH6L8tneE0ELUkOGutWs5RBdsuN7oIqkFsWXx7UIu
 a0jZmowJhRBrA1xQFpp9g8CkKwRHYq/f+k6qWAjIs2wEEkT/GKnoJuDv4mDdvF1siN
 e4GZd/DXsgHZCtK6lrjYjW9tNOjcQhU+FfUGKxWVj54lsGm0CMF3UnAdN9HR9yfe8H
 c/F5u14AdIRsUUoq8MHpZHE90l/08D5deyMtbl+ya3IW4PWqavaC0FM9Jz29QWhBNk
 30cWDN9CCd4Vg==
X-Virus-Scanned: amavisd-new at bin-co.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dxmnwVh0LiuJ; Fri, 24 Jul 2020 16:08:47 +0200 (CEST)
Received: from DeepBlue.toennjes.com (unknown [90.187.13.225])
 (Authenticated sender: zappel@retarded.farm)
 by mail.bin-co.de (Postfix) with ESMTPSA id B9A9B44437CB;
 Fri, 24 Jul 2020 16:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1595599726;
 bh=Cg949X7IAeu9wfN9Utwbw0fjiU47o69X2CSm/Q0xv24=;
 h=From:To:Cc:Subject:Date:From;
 b=Q8snL7pPiPFhB0BYHrF5zZ5BuMThGJ7oFQ6oY90qwah//t8eJdoG6wvSI21a/n4e6
 qlAN7/97NZflRSCP3+Hd2BWX93Hy5HwMNg6RxDX7IORp1HlMIC/36fJ63SQK1aX6/X
 WqoV7W/Yb6M40hgnXrzla2Kafw0BOEfAiF08zMqWONiSTz3jh6CtL9XpPjBJ7a5apt
 WuVHyNGlf803tSLXkPRPlnM5mMftGEqgdZbq15LD6keOsCqnTplUDxkHe3VcgjX+OV
 G/gwzwI/eRDuh9w3sQ0hBfw61RifXoiDEtM+c48+SJ6n8C16ACSYjq60c/UrWWhrzA
 nH1KX4CZfMIWA==
From: Armas Spann <zappel@retarded.farm>
To: alsa-devel@alsa-project.org
Subject: [PATCH v1] ALSA: hda/realtek: typo_fix: enable headset mic of ASUS
 ROG Zephyrus G14(GA401) series with ALC289
Date: Fri, 24 Jul 2020 16:08:37 +0200
Message-Id: <20200724140837.302763-1-zappel@retarded.farm>
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

This patch fixes a small typo I accidently submitted with the initial patch. The board should be named GA401 not G401.

Signed-off-by: Armas Spann <zappel@retarded.farm>
---
 sound/pci/hda/patch_realtek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1b2d8e56390a..2dd7150ff6da 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6152,7 +6152,7 @@ enum {
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
-	ALC289_FIXUP_ASUS_G401,
+	ALC289_FIXUP_ASUS_GA401,
 	ALC256_FIXUP_ACER_MIC_NO_PRESENCE,
 };
 
@@ -7363,7 +7363,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
-	[ALC289_FIXUP_ASUS_G401] = {
+	[ALC289_FIXUP_ASUS_GA401] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x19, 0x03a11020 }, /* headset mic with jack detect */
@@ -7561,7 +7561,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
-	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_G401),
+	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
-- 
2.27.0

