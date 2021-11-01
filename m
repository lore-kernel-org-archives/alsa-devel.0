Return-Path: <SRS0=20LX=PU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A75DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Nov 2021 16:22:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD26661165
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Nov 2021 16:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD26661165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=system76.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C41416BE;
	Mon,  1 Nov 2021 17:21:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C41416BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635783761;
	bh=3svNDNN2tcTzRRbqqQyURXFueyAcR8l5Cx16fdJXfPk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VCDpjIrShLMu6U2JWMlfdX6teNSfVmDL/pazeQKSPDmwpLnu8RJ/vaE73zUcIbHNv
	 +BdkPhIxtYnmX4NhGV3klbkXJpdtbYH0K0aY9eH15PIZVkI8GjkyztPS7VdI8kLzsu
	 lf7M2OjOwPP9MDTv9SE8r4P8KeGdZ+b5JLLLS8Yo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D824AF8025F;
	Mon,  1 Nov 2021 17:21:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1A51F80269; Mon,  1 Nov 2021 17:21:49 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4745F8012E
 for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2021 17:21:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4745F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="n4i+nYCA"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 297A85C00DD;
 Mon,  1 Nov 2021 12:21:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 01 Nov 2021 12:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=karhIAzFui4vZwjPe
 Z0ysI5AHF+/7X/2QFaI+/Z91mk=; b=n4i+nYCAgQeP9BnYkB2wq3vTyFICYJzGw
 LQh0kywuCZwx63ZmGlOTvulsO5SWaCSv/mqhEzDqOHk17B6C7eJTKWx8C2NRVEHm
 ok1oKwan2xJcuF8a/v8rw5t69jK9aJ0C2aWYTRLtLIbFjTaMVis6g2wWSFLhyjLF
 Pa5/NkiquQrI3UMbVy1Vphl1jlAUIoZwUJsLFhRpnogFTIBz8VfUn7/JHvtYet8P
 ZLxHumB4qo2lSBlBB2apzgMYH7ZBoeXQlRDAoCrzL/1aV8z8EDLDcTs5VXoQFHap
 YC3zXotWW8UxvcXuUGv+8KDgpj2WuaLZgbm4uWggsWBGiiUJZ6OPA==
X-ME-Sender: <xms:DxSAYTAzhBT6C-G4GWfDzgM-BX1vzBsYcr3Oh0-F-r_kUgCxgRW5Gg>
 <xme:DxSAYZgHfZpK4D4lD7R86_1eyvapIjBRclep6EB0CkiO7ZLD90PDlCpL28nA-Ncc8
 xU2Uugy8LgBty9QCw>
X-ME-Received: <xmr:DxSAYekjj-Mwk_HpOJfQnqRMaAHj1hFqWrfbiyL_TK4WWaPogNTBzxmkbYo8iwDl1zVSgDSUrjzMe0EjocFuFavfsGacJgTMsDTqyfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdehvddgkeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfhimhcuvehrrgiffhhorhguuceothgtrhgrfihfohhrugesshih
 shhtvghmjeeirdgtohhmqeenucggtffrrghtthgvrhhnpeeguefghfeigeelvddutdegtd
 eitedvffekledtjefhjeevgfetgfelteetheefgfenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehttghrrgiffhhorhgusehshihsthgvmhejie
 drtghomh
X-ME-Proxy: <xmx:DxSAYVwM5etRWfxPowHaydVVYHHrcS6x0xu7JBoW7olNUKTcSop37A>
 <xmx:DxSAYYSvtKJDMZH3mdt_RRlYszxjdMYxdPkR9w0XfXhUJe6hfk-DpQ>
 <xmx:DxSAYYbvNWNmlZMiiOI7PbIq6xcSd2uKGntEJOtzxduk6VCijKaFAQ>
 <xmx:EBSAYR51u0z__LbgAt1icLL6s-e5CxhzQXD2pITqjA4tGGUxMS-AJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Nov 2021 12:21:35 -0400 (EDT)
From: Tim Crawford <tcrawford@system76.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH RESEND] ALSA: hda/realtek: Add quirk for Clevo PC70HS
Date: Mon,  1 Nov 2021 10:21:34 -0600
Message-Id: <20211101162134.5336-1-tcrawford@system76.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: productdev@system76.com
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

Apply the PB51ED PCI quirk to the Clevo PC70HS. Fixes audio output from
the internal speakers.

Signed-off-by: Tim Crawford <tcrawford@system76.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6322fac9e694..8a3e2fe42106 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2539,6 +2539,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x67d1, "Clevo PB71[ER][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67e1, "Clevo PB71[DE][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67e5, "Clevo PC70D[PRS](?:-D|-G)?", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x67f1, "Clevo PC70H[PRS]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x70d1, "Clevo PC70[ER][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x7714, "Clevo X170SM", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x7715, "Clevo X170KM-G", ALC1220_FIXUP_CLEVO_PB51ED),
-- 
2.31.1

