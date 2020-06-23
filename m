Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8572FC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:26:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A43D20723
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZbZGWMTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A43D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D1571727;
	Tue, 23 Jun 2020 08:25:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D1571727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592893572;
	bh=Sogd8AyIqh4nPSIAmZW0SrYhuNkFzmgvMwbPZ5EqEB4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZbZGWMTeNpK+bwf6KGXczuitWsfj1nBSTSJglnjpdXL8okbnqa7o0goJPd48hmmMw
	 OPG2dvCFTCOrB0nI9oaKk2tv5VUePU3sH3hCXDXASSFpBCa/1KH3d+w+/22+LyKET9
	 R/lYMY4D1G+RXvUQ1wa2ExogrHegNMsJLYuFLe9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 186C1F80218;
	Tue, 23 Jun 2020 08:25:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EBA4F80234; Tue, 23 Jun 2020 08:25:19 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8387FF8012F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 08:25:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8387FF8012F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8A7B1AAF1
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 06:25:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/conexant: Fix missing headphone node after reboot
 from Windows
Date: Tue, 23 Jun 2020 08:25:10 +0200
Message-Id: <20200623062510.27499-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

When Lenovo Thinkpad E495 is rebooted from Windows, the headphone
control is lost.  This seems because BIOS doesn't initialize the
headphone node (NID 0x16) properly after the reboot from Windows, as
Windows likely turns off the power at its exit.  The node is left
as a vendor-specific unknown node and ignored by the HD-audio parser.

This patch forcibly initializes the node at the probe time, by
overriding the widget caps and the connection list, so that the
headphone control is detected always at probe time.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207741
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 396b5503038a..37c8add48791 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -215,6 +215,7 @@ enum {
 	CXT_FIXUP_MUTE_LED_GPIO,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
+	CXT_FIXUP_THINKPAD_E495,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -673,6 +674,22 @@ static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 				    spec->gpio_led);
 }
 
+static void cxt_fixup_thinkpad_e495(struct hda_codec *codec,
+				    const struct hda_fixup *fix,
+				    int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		static const hda_nid_t conns[] = { 0x10, 0x11 };
+		/* BIOS invalidates the headphone pin NID 0x16 when rebooted
+		 * after Windows by some reason;
+		 * forcibly restoring the whole setup
+		 */
+		snd_hda_override_wcaps(codec, 0x16, 0x400581);
+		snd_hda_codec_set_pincfg(codec, 0x16, 0x03211040);
+		snd_hda_override_conn_list(codec, 0x16, ARRAY_SIZE(conns),
+					   conns);
+	}
+}
 
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
@@ -846,6 +863,12 @@ static const struct hda_fixup cxt_fixups[] = {
 		.chained = true,
 		.chain_id = CXT_FIXUP_HEADSET_MIC,
 	},
+	[CXT_FIXUP_THINKPAD_E495] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_thinkpad_e495,
+		.chained = true,
+		.chain_id = CXT_FIXUP_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -932,6 +955,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo G50-70", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x5124, "Lenovo Thinkpad E495", CXT_FIXUP_THINKPAD_E495),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
-- 
2.16.4

