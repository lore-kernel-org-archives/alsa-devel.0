Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3855C19F28
	for <alsa-devel@archiver.kernel.org>; Sun, 31 Jul 2022 03:23:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20E8A1621;
	Sun, 31 Jul 2022 05:23:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20E8A1621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659237830;
	bh=8L3iSV6Fhb/kd2suEXA7ctal18082QYrfvGep8laowk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H1yNXQKRIImr/tYn/z1eht1pYa/lg+AKCeNUPU1geUDGJ+mDFUKCmmQQY9cQbZXvS
	 18VTeVyCzapQqBiRCWHLpq577J0zrxyBgYomz1ubB79vRsbktQOfOCVvEBJFCmwX3K
	 TZP11MQPrt+npe8ZjuuJmyCe7ch5oYN7QKn4MUw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88AC7F80154;
	Sun, 31 Jul 2022 05:22:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1732CF801F5; Sun, 31 Jul 2022 05:22:57 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34003F8014B
 for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2022 05:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34003F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com
 header.b="lD/nf8ln"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="tJpJJFv8"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 2EE2F32002D8;
 Sat, 30 Jul 2022 23:22:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sat, 30 Jul 2022 23:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=system76.com; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1659237765; x=1659324165; bh=QKfP3L7eXqZEsPZ2E17RGwE+o
 phRxKOdVjtL3L1P/BE=; b=lD/nf8lnFlCsgemrrvt8MYdkLnSYpCKMryhdJzYkn
 3UFR3V9PiIT9U1KWpzcq6E6pJwKZtageITYiZvN8ZLB0s1VJQMPBZaMmZDwTYAdU
 FibbPgQShP+Sx2pxqFN8Sb0OI+Lp+oW3GyvMdAUSv7FJGNIofbos9fLC5yiYpB7y
 xavkenlJsovqk7quiOlG15mybKX7R6gNH53idJHlBICrTjzBT3Qfy5R3Pxl6hJiK
 6szlwpB9pu/mSkMqUMWtRYRlmFJrNZZEULYTNB9LLQ4Hw0RW8BefSG59I9eBCCzN
 34eePsSTCFdd5/F0Uu8k4waO+nkp5Iv2TG4hG/7fsWjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1659237765; x=1659324165; bh=QKfP3L7eXqZEsPZ2E17RGwE+ophRxKOdVjt
 L3L1P/BE=; b=tJpJJFv8kDvt6B1VFiqOhgmXTjLxVk+GLqmVNxpRL/3qvok65/T
 eZG5xstEPGigpgRd/Dl0pt6rAL6NlfV36m07ebkUPWrAGwE89oH4pBNgvz+PpuAV
 n5K3ZOmWNJuTOfLL2ohJcuLzs+6c+cDAulNroOiY59MrIAakwOS+wWcwi+KOknUv
 zEiDej/mnzDowhdACxg3X5xQkUDxajLGXPBBRh/coPUtH1YuJQJfMtvWxdelkTzl
 ov+BibSpqm3/6dkeIJRdds3MzsiadkOt+B1CK9t1yG/Ljvu3xdSw5pnbSaLHwDdL
 awGjAj4Ajl5eSGdBFM+WhdK+H4Ox5haWyHw==
X-ME-Sender: <xms:hfXlYgIAk3i1RvA-DaLHUiXiQ7JN-z4nOnlCYMqY_2hxDU-_hRksaw>
 <xme:hfXlYgLpZm51VV7-jsFtxwbei3jqgXfN49e8RUWuSGZgUXqqcGXVeEeMUh8qrwMfM
 OB1Rp1JZHXjA0MQPA>
X-ME-Received: <xmr:hfXlYgtaYfg8t-uDpWCRkGci7gaVq744orZ_dDzmTYDAM4WSqmgL1Bth>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvtddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpefvihhmucevrhgrfihfohhrugcuoehttghrrgiffhhorhgusehs
 hihsthgvmhejiedrtghomheqnecuggftrfgrthhtvghrnhepkefgteefvdeivdfhffdtff
 fgieffhfetgeduudekieefueeutdelfedtveeuheefnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthgtrhgrfihfohhrugesshihshhtvghmje
 eirdgtohhm
X-ME-Proxy: <xmx:hfXlYtakYAnRU0j66KqIPbbSPPoWWSGigHRjhB-N10x9BDbFbvD7qg>
 <xmx:hfXlYnY3ypcUPyxp9hN27QuJNyMblRNXl93M4uTGgHGkbBPTm0Xi5Q>
 <xmx:hfXlYpA9nERLdS7m4oX0z_BQnb-va3NYqp7uvvqdv5Hm0fngYSNFlg>
 <xmx:hfXlYuw0GxTzfQR-08wBEEBqr1YjRiNzGRONAVjTHwfqR01vBXXy6w>
Feedback-ID: i1761444e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Jul 2022 23:22:44 -0400 (EDT)
From: Tim Crawford <tcrawford@system76.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Clevo NV45PZ
Date: Sat, 30 Jul 2022 21:22:43 -0600
Message-Id: <20220731032243.4300-1-tcrawford@system76.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, productdev@system76.com
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

Fixes headset detection on Clevo NV45PZ.

Signed-off-by: Tim Crawford <tcrawford@system76.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cca093cb643e..105468acde90 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9347,6 +9347,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x4041, "Clevo NV4[15]PZ", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x40a1, "Clevo NL40GU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x40c1, "Clevo NL40[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x40d1, "Clevo NL41DU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.37.1

