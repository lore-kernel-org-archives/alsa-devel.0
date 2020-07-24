Return-Path: <SRS0=4jWs=BD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8EDC433E8
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:07:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD06206D8
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WfCR16p/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="bdP/fYQ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=retarded.farm header.i=@retarded.farm header.b="tCby+o+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD06206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=retarded.farm
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74EE4167C;
	Fri, 24 Jul 2020 16:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74EE4167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595599676;
	bh=HOBWx15UZ9oe1AghDpsvvWA3rAeWtKEmFzrdhr5sKGA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WfCR16p/IKSvHeJ2/4YUEeZOXD/G9XDjjPHtby3ZYqxDk71tyViSFy9KslSfLbORs
	 6vfpy3JjqP63aa/Rs/PIl2p4gBZlT7RyiD+2/sN6hlPMTKB3z8Szv+L+SQ87+LzKyQ
	 BGKfhRiU2fs+jVsTgaADsis/1HeuMQUI6fXDzSdY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF920F8011F;
	Fri, 24 Jul 2020 16:07:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69F64F8014C; Fri, 24 Jul 2020 16:07:04 +0200 (CEST)
Received: from mail.bin-co.de (mail.bin-co.de [173.212.200.19])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CB7EF800DF
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 16:06:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CB7EF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="bdP/fYQ9"; 
 dkim=pass (2048-bit key) header.d=retarded.farm header.i=@retarded.farm
 header.b="tCby+o+s"
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id 3DCDC44437D3;
 Fri, 24 Jul 2020 16:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1595599613;
 bh=HOBWx15UZ9oe1AghDpsvvWA3rAeWtKEmFzrdhr5sKGA=;
 h=From:To:Cc:Subject:Date:From;
 b=bdP/fYQ9epKJEvFigP301uz3dmF7FjQ7OYks8CGH4wA3IG7wOzAEAhXyndDcb+iR8
 2dAI5/9H9XxTk8McAYgo7CGt5C0zlvrfYrzS0i1wc+LD8BmIxY48nStVSgLebRNDp7
 EDUPqGZjw00HpSxfp5NfNLsE5S2P27vCMf5LyvfwHJM2f2/0K77gZW9CriPKu0edZQ
 gDBLYSkBlfrlV374XdgnMuJFKSKV0Gx2Cn7aeAB170QMkns+yHrBjdq+eP+oZcUFSK
 1Anliv2QdEPPAHMUgQAP8tHflVebqY5Kn+P+8LBadrRRc5TguecvwnvcFZJyrTUxMy
 qf4ljFXjhPuqg==
X-Virus-Scanned: amavisd-new at bin-co.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id II-TjgURs9jW; Fri, 24 Jul 2020 16:06:52 +0200 (CEST)
Received: from DeepBlue.toennjes.com (unknown [90.187.13.225])
 (Authenticated sender: zappel@retarded.farm)
 by mail.bin-co.de (Postfix) with ESMTPSA id 8628E44437CB;
 Fri, 24 Jul 2020 16:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retarded.farm;
 s=201801; t=1595599612;
 bh=HOBWx15UZ9oe1AghDpsvvWA3rAeWtKEmFzrdhr5sKGA=;
 h=From:To:Cc:Subject:Date:From;
 b=tCby+o+sAIXouFL9TZahoPbre5DPjWUv6LIYpAfvAi7mEDxNofjWqqN/eHEh0rRX5
 HtFDUzwxjZ58k0Nq8y1vk8nhhl6T4/ELQY4ebMcQgvA4MSWb84ZEgq2kvERy24QEPl
 RUJf8X4B4+pelhzb27K9rAFnhyMkrggiLZx5BFM2ZI1NnGKofBfk92PSzjUBDi2XWO
 RSPBS22mKDJd0bUb0o1ZirXpvXRqu+fRP6F8hlbrp8ocVNgHR+SHWzPpYhhjO61Qqt
 bvSV+g4r54Hb5inawvPVjOPLVhA/vnfk5qFpiFMJrj53yU1wrRU963Uts09tvKiSc/
 gggKa8bUHqDkg==
From: Armas Spann <zappel@retarded.farm>
To: alsa-devel@alsa-project.org
Subject: [PATCH v1] ALSA: hda/realtek: enable headset mic of ASUS ROG Zephyrus
 G15(GA502) series with ALC289
Date: Fri, 24 Jul 2020 16:06:16 +0200
Message-Id: <20200724140616.298892-1-zappel@retarded.farm>
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

This patch adds support for headset mic to the ASUS ROG Zephyrus
G15(GA502) notebook series by adding the corresponding
vendor/pci_device id, as well as adding a new fixup for the used
realtek ALC289. The fixup stets the correct pin to get the headset mic
correctly recognized on audio-jack.

Signed-off-by: Armas Spann <zappel@retarded.farm>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1b2d8e56390a..a2c48a7f4594 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6153,6 +6153,7 @@ enum {
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC289_FIXUP_ASUS_G401,
+	ALC289_FIXUP_ASUS_GA502,
 	ALC256_FIXUP_ACER_MIC_NO_PRESENCE,
 };
 
@@ -7370,6 +7371,13 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
+	[ALC289_FIXUP_ASUS_GA502] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11020 }, /* headset mic with jack detect */
+			{ }
+		},
+	},
 	[ALC256_FIXUP_ACER_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7561,6 +7569,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_G401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
-- 
2.27.0

