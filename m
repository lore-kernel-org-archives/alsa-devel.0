Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905CC4363D
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:08:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322B206CA
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pAIhNZVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322B206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6672C1930;
	Sat,  3 Oct 2020 11:08:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6672C1930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601716130;
	bh=ocLrftqbADq8hZAhQ14P5tQq1OTH6fafG00QQ3+Gus8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pAIhNZVPpjopWXGLJj6cyqDnvfNrfLsdF73N8cMOav6Q+TjeZ9+w9D1tBCqbqrQmN
	 p8rrhTXwrY8fhMZfY74lthtlVwBMrHMba5vJ91bL772G7QiGMI1tEmPMCSzQwTD3Q5
	 korj4rv4TWhKSh0HJcFdi5+NS8UdaSfehrG3Y/8o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDBC3F802DD;
	Sat,  3 Oct 2020 11:06:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A3DBF801F9; Fri,  2 Oct 2020 14:45:22 +0200 (CEST)
Received: from qq.com (smtpbg467.qq.com [59.36.132.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91A4BF800AB
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 14:45:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91A4BF800AB
X-QQ-mid: bizesmtp12t1601642697tq8zxrni
Received: from localhost.localdomain (unknown [111.18.95.252])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 02 Oct 2020 20:44:56 +0800 (CST)
X-QQ-SSF: 0140000000200050B000B00A0000000
X-QQ-FEAT: pDrqMl8+oMGqCTa8V5HDW6z+OxSfqmTEjSEx+R4wgDEym9Ey52MAT6wLgqTJD
 p5NJS8gGJ2XioavrkPpg5i/1zUzf+ztGF2/EzeTES4aTDpdReN6KlGTXvKywp+VlHY3uFkp
 EEisDUCLxiF9mGaxN2EIdZJl8oB+hMUO9TVHyFZwLCj5ZoUkZKbN3CiNIFUI4oEdyGJ2GPE
 DapQ3Dq5yS+RqDaPhojOWLy7MNXr2p/c/dw9jyhVS4znKTfJms3e8L+vTInXI++YnIfOaiN
 bWEPrrlDV59NzoAmJO3ivRa1AB1opLVeMWlXDdGoQiDvpDyZSa+V9iQL/ZPJzrppTr3A==
X-QQ-GoodBg: 2
From: Qiu Wenbo <qiuwenbo@kylinos.com.cn>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Kailang Yang <kailang@realtek.com>
Subject: [PATCH] ALSA: hda/realtek - Add mute Led support for HP Elitebook 845
 G7
Date: Fri,  2 Oct 2020 20:44:54 +0800
Message-Id: <20201002124454.7240-1-qiuwenbo@kylinos.com.cn>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.com.cn:qybgweb:qybgweb14
X-Mailman-Approved-At: Sat, 03 Oct 2020 11:06:14 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

After installing archlinux, the mute led and micmute led are not working
at all. This patch fix this issue by applying a fixup from similar
model. These mute leds are confirmed working on HP Elitebook 845 G7.

Signed-off-by: Qiu Wenbo <qiuwenbo@kylinos.com.cn>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d4f17b465892..8239c4dd4a90 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7763,6 +7763,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8729, "HP", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.28.0

