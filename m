Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022AFC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:13:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF25208C3
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oCnrkeHz";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3qD+PC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF25208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D60515E4;
	Tue,  9 Jun 2020 01:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D60515E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591658020;
	bh=YWRFeZLqbyxcn8OCfgjqQuvPxNXETBJGT6gVLioON2w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCnrkeHzZIHNb6JvCUQ2nZGJJEeazsrLOqokoIptGQ+gYgbN/g+6EaPp4cOPwVB1f
	 2LkzLTi9EMd1uBgQ9CRtmwQ9vlvvC6IwETg0N806Elz/dq9ULD1yqBzciyXrHq12hF
	 FMi5POf86XAQkAmgBAl8IZ2uoz0koKQqxFFJB4is=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FDBBF8021E;
	Tue,  9 Jun 2020 01:12:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5D25F8021E; Tue,  9 Jun 2020 01:12:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEBD5F801F7
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 01:12:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEBD5F801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h3qD+PC2"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 32A50208C7;
 Mon,  8 Jun 2020 23:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657957;
 bh=YWRFeZLqbyxcn8OCfgjqQuvPxNXETBJGT6gVLioON2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h3qD+PC20OcU6HzH2vPCc++8RwivMs7PmKMwBQ7CbiROXeZCXLefi82OQBYG+4ZFJ
 8L/HwLodqM2jlVpGQwwb7bVBc5xL+IQ0FmOlxY34+x22J3xsWFSPfYKvpagIBBWbjh
 MJqgZr6CA2GE1Eg9AQe1QK9aE+cfBGoNihV7xlGY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 022/606] ALSA: hda/realtek - Limit int mic boost
 for Thinkpad T530
Date: Mon,  8 Jun 2020 19:02:27 -0400
Message-Id: <20200608231211.3363633-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
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

From: Takashi Iwai <tiwai@suse.de>

commit b590b38ca305d6d7902ec7c4f7e273e0069f3bcc upstream.

Lenovo Thinkpad T530 seems to have a sensitive internal mic capture
that needs to limit the mic boost like a few other Thinkpad models.
Although we may change the quirk for ALC269_FIXUP_LENOVO_DOCK, this
hits way too many other laptop models, so let's add a new fixup model
that limits the internal mic boost on top of the existing quirk and
apply to only T530.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1171293
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200514160533.10337-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 611498270c5e..e787792770be 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5856,6 +5856,7 @@ enum {
 	ALC269_FIXUP_HP_LINE1_MIC1_LED,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
+	ALC269_FIXUP_LENOVO_DOCK_LIMIT_BOOST,
 	ALC269_FIXUP_NO_SHUTUP,
 	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
@@ -6175,6 +6176,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT
 	},
+	[ALC269_FIXUP_LENOVO_DOCK_LIMIT_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_LENOVO_DOCK,
+	},
 	[ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
@@ -7317,7 +7324,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21ca, "Thinkpad L412", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21e9, "Thinkpad Edge 15", ALC269_FIXUP_SKU_IGNORE),
-	SND_PCI_QUIRK(0x17aa, 0x21f6, "Thinkpad T530", ALC269_FIXUP_LENOVO_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x21f6, "Thinkpad T530", ALC269_FIXUP_LENOVO_DOCK_LIMIT_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x21fa, "Thinkpad X230", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x21f3, "Thinkpad T430", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_DOCK),
@@ -7456,6 +7463,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_HEADSET_MODE, .name = "headset-mode"},
 	{.id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC, .name = "headset-mode-no-hp-mic"},
 	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
+	{.id = ALC269_FIXUP_LENOVO_DOCK_LIMIT_BOOST, .name = "lenovo-dock-limit-boost"},
 	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
 	{.id = ALC269_FIXUP_HP_DOCK_GPIO_MIC1_LED, .name = "hp-dock-gpio-mic1-led"},
 	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
-- 
2.25.1

