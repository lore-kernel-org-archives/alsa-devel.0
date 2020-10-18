Return-Path: <SRS0=oKMh=DZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C0CC433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 19:25:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AB52137B
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 19:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W9YI35/1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flFPY79O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AB52137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E5C917CE;
	Sun, 18 Oct 2020 21:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E5C917CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603049119;
	bh=EXKjmf2dHMoOEj6HotJpnsmavptkQ4nEpZ27eAhHmB8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9YI35/1CYVm3F2v6DSe0Ru2iNB7AB9TAKiUF06Ke4C32IuScdrE2jSsAmoEXD5TZ
	 EHD80Ra/+FkzBwJ4pPQF9Dxs8kSjhHCdUB0LYxhQn4syf7mYc9UgwuGzDP/PIXJKQu
	 Ga4/HHbckAH42dkZh2qXuFDUYxcUraHCgPwsGseg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2A87F80225;
	Sun, 18 Oct 2020 21:24:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AEABF80226; Sun, 18 Oct 2020 21:24:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E023DF801F2
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 21:24:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E023DF801F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="flFPY79O"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2A2F222E9;
 Sun, 18 Oct 2020 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603049043;
 bh=EXKjmf2dHMoOEj6HotJpnsmavptkQ4nEpZ27eAhHmB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=flFPY79OMYf8nvHYtP+8fOUO1mHQoTf6SiCHF5UhWPtES3zfzeSWgpzYizA+HAh6p
 s0bu8mETtijDffaNJ/+Bx3Tzfph7r0+3VbIHkx/ztXlsIgnyVc3wZne4nb929b87y5
 5PZDIbfWf0fHdDLUzpAOe7f3gN+3teACIv0usToQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 73/80] ALSA: hda/ca0132 - Add new quirk ID for
 SoundBlaster AE-7.
Date: Sun, 18 Oct 2020 15:22:24 -0400
Message-Id: <20201018192231.4054535-73-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 Connor McAdams <conmanx360@gmail.com>, alsa-devel@alsa-project.org
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

From: Connor McAdams <conmanx360@gmail.com>

[ Upstream commit 620f08eea6d6961b789af3fa3ea86725c8c93ece ]

Add a new PCI subsystem ID for the SoundBlaster AE-7 card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Link: https://lore.kernel.org/r/20200825201040.30339-11-conmanx360@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 98a11c38e7a8e..459aff6c10bc5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1065,6 +1065,7 @@ enum {
 	QUIRK_R3DI,
 	QUIRK_R3D,
 	QUIRK_AE5,
+	QUIRK_AE7,
 };
 
 #ifdef CONFIG_PCI
@@ -1184,6 +1185,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
+	SND_PCI_QUIRK(0x1102, 0x0081, "Sound Blaster AE-7", QUIRK_AE7),
 	{}
 };
 
-- 
2.25.1

