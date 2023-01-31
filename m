Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B996C636CC
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Jan 2023 19:21:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 764A51ED;
	Tue, 31 Jan 2023 20:20:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 764A51ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675192904;
	bh=rD4UrLZwXK8DU4DCSY46sEKlI3vueEFAJ37f7Y4AjR4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=r2U38ribuCBfqzLLzCrzPknOQyGzFoZkVYQ+8e4VJ6UYjQjd61yeeHWEVcyGoGpnc
	 RAUzk5P0hGbVSRoysPZyLQPeKWGrozKTr22MiiLQ+SFYU1Ei+c1bo3/ZE4eo2S82KF
	 7yf/Cn6AT/z8oGscRcjnkj+t3nQzXgj2kfICqvxk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16978F80245;
	Tue, 31 Jan 2023 20:20:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9221F804C2; Tue, 31 Jan 2023 20:20:52 +0100 (CET)
Received: from ovh.texitoi.eu (ovh.texitoi.eu [51.254.137.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D797F80155
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2023 20:20:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D797F80155
Received: from book360.numericable.fr (55.174.26.93.rev.sfr.net [93.26.174.55])
 by ovh.texitoi.eu (OpenSMTPD) with ESMTPSA id c10cb12c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 31 Jan 2023 20:20:47 +0100 (CET)
From: Guillaume Pinot <texitoi@texitoi.eu>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy
 Book2 Pro 360
Date: Tue, 31 Jan 2023 20:18:11 +0100
Message-Id: <20230131191809.24012-1-texitoi@texitoi.eu>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Guillaume Pinot <texitoi@texitoi.eu>, stable@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Samsung Galaxy Book2 Pro 360 (13" 2022 NP930QED-KA1FR) with codec SSID
144d:ca03 requires the same workaround for enabling the speaker amp
like other Samsung models with ALC298 codec.

Cc: <stable@vger.kernel.org>
Signed-off-by: Guillaume Pinot <texitoi@texitoi.eu>
---
I've tested this fix on my laptop with success. I've took "inspiration" from
https://lore.kernel.org/all/20221115170235.18875-1-tiwai@suse.de

This is my first contribution, so feel free to give me feedbacks!

Also, I've tried to send this patch a few days ago, but I forgot to subscribe
before, so the old submission might be lost in the moderation stack. I hope it
doesn't pose any problem.

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6fab7c8fc19a..c4496206c3e7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9521,6 +9521,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc830, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc832, "Samsung Galaxy Book Flex Alpha (NP730QCJ)", ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xca03, "Samsung Galaxy Book2 Pro 360 (NP930QED)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
-- 
2.30.2

