Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A25C432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 03:02:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8E0600D1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 03:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E8E0600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00DC21655;
	Tue, 24 Aug 2021 05:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00DC21655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629774137;
	bh=vVNJKMI+615yMLaxXTQxjKbW/z996wR88WR6opmQneI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HvXYdoEWmvORQ+xETg/bR7eZmdARCuDsHAMb2YsnKZzVlodkut7F8nJQy0SwlI0zr
	 s9HOQS47D/WW5n8rsMZ5bFouwfSRZ4VHylQihr9vNOWfrJqfK/47P3rrf5nCVguV+9
	 pQkdXRijd2YtUg8nG19Ql7+/r0GVe+ktPBGmqNfs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F5D0F8051B;
	Tue, 24 Aug 2021 04:58:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DBD4F80517; Tue, 24 Aug 2021 04:58:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84A23F80518
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 04:58:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84A23F80518
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="btqO1FPv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D91611F0;
 Tue, 24 Aug 2021 02:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629773922;
 bh=vVNJKMI+615yMLaxXTQxjKbW/z996wR88WR6opmQneI=;
 h=From:To:Cc:Subject:Date:From;
 b=btqO1FPvpsQwPn+GEnP6a8Ei2PQ1ik+YHJwREjbbNPM2YtEWnH7d4tuYcf0wHWMEW
 cfOzpdt+qaK9KOdk3kSou7QWXGBAOxWAHLxeLE+mShCAPkf/g2eY0KbKvB1Lexw6Jq
 hlgshy+NCWW56slzB5bkFoXB04CdbRI1PTgj5FkXg0E8TnY3OPShnduseBPeBR8EA0
 C1lqSi6IbTbOx2Abbb7+l6E6MpCowk5oacF3nOsrNiXmqYG6eG/erdKMrYDhrdeykO
 e0hdjy3859PA1IqJD71E/Q910pLyU017Y7dggHwNzXI37dZR5Cgx6OqvrkgqR+k/jw
 uAMI2CCmHvZbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kristin@tombom.co.uk
Subject: FAILED: Patch "ALSA: hda/realtek: Enable 4-speaker output for Dell
 XPS 15 9510 laptop" failed to apply to 4.9-stable tree
Date: Mon, 23 Aug 2021 22:58:40 -0400
Message-Id: <20210824025840.659728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

The patch below does not apply to the 4.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From da94692001ea45ffa1f5e9f17ecdef7aecd90c27 Mon Sep 17 00:00:00 2001
From: Kristin Paget <kristin@tombom.co.uk>
Date: Sat, 14 Aug 2021 15:46:05 -0700
Subject: [PATCH] ALSA: hda/realtek: Enable 4-speaker output for Dell XPS 15
 9510 laptop

The 2021-model XPS 15 appears to use the same 4-speakers-on-ALC289 audio
setup as the Precision models, so requires the same quirk to enable woofer
output. Tested on my own 9510.

Signed-off-by: Kristin Paget <kristin@tombom.co.uk>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/e1fc95c5-c10a-1f98-a5c2-dd6e336157e1@tombom.co.uk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a065260d0d20..96f32eaa24df 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8332,6 +8332,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0a2e, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a30, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a58, "Dell", ALC255_FIXUP_DELL_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0a61, "Dell XPS 15 9510", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.30.2




