Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E519FC4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Apr 2022 01:14:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCD941742;
	Thu,  7 Apr 2022 03:13:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCD941742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649294073;
	bh=zYBeZSmWVUsvZOrwcGFWfuK0yc2qJdKqXYxquMyxDZ0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+B+QZgDN19ZphPvu5IxvEY3qlEsJqqNAigPU+DMDoL4ZKLA2xZXQc+NxhjsxDz7y
	 4aiN9q94kzbljH4nlChM6VK/BHSHqeb6fVeKIxeffaZhGbrdFRBOcroaHGzusG5vve
	 yLCnjG4RdSmNIviQAoi+YdaPo9Dh1Xg4ghgWF7NY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69AD9F80141;
	Thu,  7 Apr 2022 03:13:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BEA7F800D2; Thu,  7 Apr 2022 03:13:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45DF2F800D2
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2022 03:13:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45DF2F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G/OiqVs1"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 278CC61DA8;
 Thu,  7 Apr 2022 01:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C555AC385A1;
 Thu,  7 Apr 2022 01:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649294013;
 bh=zYBeZSmWVUsvZOrwcGFWfuK0yc2qJdKqXYxquMyxDZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G/OiqVs1v//Z7Cup98IXqYUbwENwZj9Rl5NQ7DL3Yey46mJx6xtapYkcjX5fY042m
 mjvzKXIIXX768X+k8M/dFxCN3KvwBu9b3YfeYRXu/YfXn3etXzs3AjzmENXW2Qyj5j
 p1xFf/rdUjS6ncMFVE3Hf7R4f4ntE9wjM/anCWX/3W0x72cuJtk/A6bm8i4Js9VjvU
 TjkHwkAl4CAOwMm5BumeL5OfKdtYE/Eyn17w1ObvbzRPRezF6gR7ywHOTB7uLqfj1+
 ffWzzxJpDbt59RJkiQkX7h8zLgYe56VV4O1hW/cXKOtQhLrc1j8v18uGtbXpue5igE
 JsGZEIUhfyO7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/27] ALSA: hda/realtek: Enable headset mic on
 Lenovo P360
Date: Wed,  6 Apr 2022 21:12:43 -0400
Message-Id: <20220407011257.114287-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011257.114287-1-sashal@kernel.org>
References: <20220407011257.114287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 kailang@realtek.com, tanureal@opensource.cirrus.com, jeremy.szu@canonical.com,
 Takashi Iwai <tiwai@suse.de>, tiwai@suse.com, wse@tuxedocomputers.com,
 hui.wang@canonical.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 sami@loone.fi, cam@neo-zeon.de
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 5a8738571747c1e275a40b69a608657603867b7e ]

Lenovo P360 is another platform equipped with ALC897, and it needs
ALC897_FIXUP_HEADSET_MIC_PIN quirk to make its headset mic work.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20220325160501.705221-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 08bf8a77a3e4..31228896638f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10931,6 +10931,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
+	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
-- 
2.35.1

