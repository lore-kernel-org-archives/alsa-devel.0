Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5350FC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 14:42:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6437B610CB
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 14:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6437B610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15D451680;
	Wed, 18 Aug 2021 16:41:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15D451680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629297761;
	bh=ZxikT1XXvzJQ9Ae02oMPYenOGcfe0yNLiqjBWEb8cEE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NPrI4qMwN+jJ4aHeOTJ0hzo/ZivqZkrf1K8fJ1McTaiLz2cDOKRAUxDt6a72p9D6z
	 /HUogemEPZ3ija08s56imQkP1+I9o6y3aggEyNAjFb8xQljVubJrhc3dzoR+Bjru/R
	 cG6bXP7MA5K02GIfaVoZFOWvChVd9Ar8VzqZBeGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6789FF80246;
	Wed, 18 Aug 2021 16:41:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82174F80249; Wed, 18 Aug 2021 16:41:48 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBE44F80163
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 16:41:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBE44F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="AnznNO2B"
Received: from localhost.localdomain (1-171-94-217.dynamic-ip.hinet.net
 [1.171.94.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6266F3F22D; 
 Wed, 18 Aug 2021 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629297693;
 bh=rpYQZJkVgHmqwjumc9YZsbkB/HagkENpYBYIqPk3wwM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=AnznNO2B+u1KZWg60EjPbLMutpwzbgyrY+ojeRNxn6JmhlkoxUi5ja7MhwYdyid5p
 2dkdOoNWeoENtk8O+nNWbPTj+vlgjytzkE502ojh6qSX0Zi8vLZfT8EakRzkcZLQyN
 qOvan470Ux70EcuZ+5qGfdjvIUdIi7jKE04IoO6q+ILHfTaxsP3pppqUbTl2/I70P0
 pxwZW+uHkm0HT/Cwz5WdOcDQCAzL8fRdMs3hxJjPFeZltx6QVjBnU3Bkw3UtzG6SPq
 DKtIm/BoDeTW2BDs/TaZAE5ADB904609yQT47wlIJpLJApRvzjyCLD0wI0MdFJP9z7
 5mHN98cM5PdCw==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: Limit mic boost on HP ProBook 445 G8
Date: Wed, 18 Aug 2021 22:41:18 +0800
Message-Id: <20210818144119.121738-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Chris Chiu <chris.chiu@canonical.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Jeremy Szu <jeremy.szu@canonical.com>,
 open list <linux-kernel@vger.kernel.org>, Luke D Jones <luke@ljones.dev>,
 Jian-Hong Pan <jhp@endlessos.org>, Werner Sembach <wse@tuxedocomputers.com>,
 Hui Wang <hui.wang@canonical.com>, PeiSen Hou <pshou@realtek.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Sami Loone <sami@loone.fi>
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

The mic has lots of noises if mic boost is enabled. So disable mic boost
to get crystal clear audio capture.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8b72064f83211..cdd87917dd8cf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6645,6 +6645,7 @@ enum {
 	ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP,
 	ALC623_FIXUP_LENOVO_THINKSTATION_P340,
 	ALC255_FIXUP_ACER_HEADPHONE_AND_MIC,
+	ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8229,6 +8230,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_XIAOMI_HEADSET_MIC
 	},
+	[ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8425,8 +8432,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8862, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
-	SND_PCI_QUIRK(0x103c, 0x8863, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8862, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x103c, 0x8863, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.32.0

