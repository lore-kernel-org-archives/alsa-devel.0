Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CBFC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 03:05:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682FA6102A
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 03:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682FA6102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AF931686;
	Mon, 19 Apr 2021 05:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AF931686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618801540;
	bh=m3T0hiKwLeCRZrEForeqvQSL34bw4XaMVeLDXtFcYe4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rh+i6HLhcAEzv69mVnf2bW9rdRXy/KTit9ba/SPMq8cdJKnLXOBttovk8rz6JXA2H
	 FSVpO/s8dz0j+WMYpd553hy/98i7NFKZZkjQSAAYhV2iljVfEcFGsvAcVib7rN7yW0
	 NAeoPKq4b5yBU3qT9HG5ZIjS5wskuJdYpXAhb2Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9361FF800C5;
	Mon, 19 Apr 2021 05:04:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C980EF80227; Mon, 19 Apr 2021 05:04:43 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50A70F80164
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 05:04:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50A70F80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="CAePTiRR"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 403602393;
 Sun, 18 Apr 2021 23:04:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 18 Apr 2021 23:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PrOcHHFjzXKX2Ja1y
 caapbHixLxJ7oQd8IfTQ5NlARA=; b=CAePTiRRNxkbokWAAOxtUpQdP5l6h+mav
 Ofx1reP35MXo22Cfw/X0lLEYVh5QdcIyPmvvQkWCj1aTJ+rXkFsOtkiSCfuF4afm
 r1mZsGFN8qCbNqf7gFDhCsip8AyTU/UdFjGDJgyH/0+GCzXohDQBw1sLT4SDgXw7
 iP9uejYCxR2YtaH44iHME20FURg/O5geLFOykb1bvqc+eO7E/uifY8PNS+YCvGKP
 sHTHVwN+oQdrf1pfXGqUtmC7g75gGb0xD4o1wFUy1yrQ3cDAiQxtbmIfrDUm837R
 +On0NOKlHXFS/yEKUZXAWu5cni8mC1s+OoPqSaSdNMdoboaas9/Uw==
X-ME-Sender: <xms:PPN8YNToraQIyQHnFtTVFAmxC6swwMMdVKTQyeCtUr3B6dyjAuqtvA>
 <xme:PPN8YGy2oCBPoypb1tTY0GoC-X78XLAiUZ2EjrnaFRSX119gsp0SZ0lNaJbHXoQpe
 OXLi7AwR8gMtqL5bso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtvddguddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpefnuhhkvgcuffculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
 rdguvghvqeenucggtffrrghtthgvrhhnpeffgffhheehkefgtddtiefhudegteekudeihf
 dvudejudeigfdtheeijeetvdejvdenucfkphepudduiedrvdehuddrudelfedrudelieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
 eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:PPN8YC0MQxO51LhyO8a7eZKOwDbJCPWU8njfEJMiMmbGb6bnt7lqEA>
 <xmx:PPN8YFAJ3PQhVEFcL6Uo9d0aItoKidj0101AFAZCfZUB38kIhG1lLQ>
 <xmx:PPN8YGibESQL-YQReBlG9Yl5u08u_-hoGA-y8sZluXVJoE46z2uKlw>
 <xmx:PfN8YBUrd9dTG1M1CICPXPn9yZQGOxFY5b7cUQcTbrNLdfD268LFCg>
Received: from fedora.. (unknown [116.251.193.196])
 by mail.messagingengine.com (Postfix) with ESMTPA id AA9AA1080066;
 Sun, 18 Apr 2021 23:04:24 -0400 (EDT)
From: Luke D Jones <luke@ljones.dev>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: GA503 use same quirks as GA401
Date: Mon, 19 Apr 2021 15:04:11 +1200
Message-Id: <20210419030411.28304-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kailang@realtek.com,
 linux-kernel@vger.kernel.org, Luke D Jones <luke@ljones.dev>,
 chenhuacai@kernel.org, jhp@endlessos.org, hui.wang@canonical.com,
 kai.heng.feng@canonical.com
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

The GA503 has almost exactly the same default setup as the GA401
model with the same issues. The GA401 quirks solve all the issues
so we will use the full quirk chain.

Signed-off-by: Luke D Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 290645516313..9a5546df1e6a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8019,6 +8019,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
+	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
-- 
2.31.1

