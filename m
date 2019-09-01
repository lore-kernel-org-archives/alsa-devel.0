Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD30C3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:22:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B1E2087E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YI2Rle+w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KJakSu1u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9oMpixH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B1E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fastmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 882D216E7;
	Mon,  2 Sep 2019 17:21:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 882D216E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567437766;
	bh=JtFh11j8ZVVHSHMGnL7pa385oSeFoxH8KnXE72iShmU=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YI2Rle+wCG8IPkZInVuhnoeQ7pKVu0ZmZKKPQVTZqp5u69QuAFLnNfcU++ML4T55e
	 NlkKOvOPOC7HCGfRZXQ7StjXsTHPcis9eJhZ7PGAXTVbZ5+PRokPDX/Dd3b9FnJ78B
	 e6D29liicD30x+yiqoWN4gpCVhoqsrYHiZ0CgCjg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F10CCF805F7;
	Mon,  2 Sep 2019 17:20:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55D52F803D7; Sun,  1 Sep 2019 04:31:41 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD5ACF801DF
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2019 04:31:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD5ACF801DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com
 header.b="KJakSu1u"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="i9oMpixH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id A22E1431;
 Sat, 31 Aug 2019 22:31:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sat, 31 Aug 2019 22:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 date:from:to:cc:subject:message-id:mime-version:content-type; s=
 fm3; bh=Fo0oQ0WtdqAoWBVLoEOMh4lWt0MWd2jdToSDMXaYfdk=; b=KJakSu1u
 kM25osrvNsaYs2HHwEZHhiPOP8Ap1Zgf2kJiku8Msfwhn25B5lXbsFEpEay9YNVY
 BggNQkNgLT18WcGh9gMfLl0BAGzM8RpvsVzCU1LVgOPa6DHdWNcBomSyHJeMY8Iv
 melAztRdHTtYQSJPAotjyWQ7uZ2fQ743p2ZcuyLxbTyzgcUDO4bm/yh8e3kHGosf
 uj9lDle4sTryCLtvZyWpWDRTIqAjkyEHRDSnDo2tCAAk4KYx3n1G9LVGGvUM6E0A
 Wgd1LArn0PH7YD0BXr/ATkniidsMslwQe1Ef2ZH2zHEyTIt9UB6RLnBWAVUjZB2A
 jg4XnKYmyUhNgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=Fo0oQ0WtdqAoWBVLoEOMh4lWt0MWd
 2jdToSDMXaYfdk=; b=i9oMpixHxJ4CBkPb+L9AAzVFiOgRaRNRK7Qso2v8NLtMY
 0YAWKfTz4IqZDAiU8jEnrUDnGrZJrMXmYzyafifxs8JhoNYvwpQ9DjarL1OayY8S
 RATrKy/9fj0TnZ1P7r5m0zZEDjDvKscs9gAvecj+PU6rfImrzUoymESBc2hUYy6I
 kcPRcIDfQKhlQ3xO4QOpSiH58JGMOL0okgiTD8rbIaji2Q32k7Eo/BOGX/Qaeozo
 PLsAGH8sIbkUdTtf0ac5waYXlukkQS9InIbG4BhjkkZ8vrNZVHoBHJisvtbfqK+D
 xwFLaCyitIMzyt+UpG0V3dxeniEYQUoHOzNWvz4+Q==
X-ME-Sender: <xms:hC1rXSVC86DWolV6nqXJw4QodyZ7j76ttQSbUY_mQs_ua1SYK9NK_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeijedgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
 dtredvnecuhfhrohhmpefurghmuceurgiilhgvhicuoehsrghmsggriihlvgihsehfrghs
 thhmrghilhdrtghomheqnecukfhppeekiedriedrleehrddvfeegnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehsrghmsggriihlvgihsehfrghsthhmrghilhdrtghomhenucevlhhu
 shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hC1rXexdZVnGs5vJuoDhEtwDLVxmLuxK2yluLlOPxAmOZy3qIHtVNA>
 <xmx:hC1rXYNO9Ye4xAtfUCodWGBG-QBecQ6GISeDVyiJcdDvMXiUHToEJg>
 <xmx:hC1rXX6dhixV5SahNB5lDYUvJVFGmdY5KBRQK7SypN6IMkjemnUQiA>
 <xmx:hS1rXUKbP2ar-N_-DFr6fdPMVZKJ2B4eYykqav5rjd1-SoPM65A8_w>
Received: from SamLinux (cpc88606-newt36-2-0-cust1001.19-3.cable.virginm.net
 [86.6.95.234])
 by mail.messagingengine.com (Postfix) with ESMTPA id E368AD6005E;
 Sat, 31 Aug 2019 22:31:31 -0400 (EDT)
Date: Sun, 1 Sep 2019 03:31:30 +0100
From: Sam Bazley <sambazley@fastmail.com>
To: tiwai@suse.com
Message-ID: <20190901023130.GA15295@SamLinux>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Mailman-Approved-At: Mon, 02 Sep 2019 17:20:12 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 sambazley@fastmail.com
Subject: [alsa-devel] [PATCH] ALSA: hda/realtek - Add quirk for HP Pavilion
	15
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190901023130.FB6LsgTUs3xJVwwvvh8qQc8JghnbQPoYyEz7lEYDBfU@z>

HP Pavilion 15 (AMD Ryzen-based model) with 103c:84e7 needs the same
quirk like HP Envy/Spectre x360 for enabling the mute LED over Mic3 pin.

Signed-off-by: Sam Bazley <sambazley@fastmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e333b3e30e31..31ba8d68c16d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6973,6 +6973,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x802e, "HP Z240 SFF", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP G3 mini", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
