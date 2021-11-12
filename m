Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE00C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 11:08:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9BA60F90
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 11:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B9BA60F90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 397FD165D;
	Fri, 12 Nov 2021 12:07:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 397FD165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636715289;
	bh=+Ztv6nDpXmZ2wTJB0aGyrOpUipBdb2wfitgP0dg3jfo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gQtNY4CR7+PO4/Z9LzBuMTCjETI8T04AThrPXiH+gleVgtdLdLDmGBJ4eb42UjXVv
	 HOhW9hZaYXJLiochrOSZmA+/zG3+GWyMzppvCYIGPyXOZVYVpdT3ypV2hwau9w2CIw
	 /xKZGpCd3Qprt+LVVLDdNLVYmquyKHfXEzggPHJ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A33B4F80227;
	Fri, 12 Nov 2021 12:07:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15C89F8049E; Fri, 12 Nov 2021 12:07:17 +0100 (CET)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8A2CF800C1
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 12:07:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8A2CF800C1
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id E3CEDC8009D;
 Fri, 12 Nov 2021 12:07:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id l3sTf6RsUn9l; Fri, 12 Nov 2021 12:07:04 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box
 (host-212-18-30-247.customer.m-online.net [212.18.30.247])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id 8F553C8009C;
 Fri, 12 Nov 2021 12:07:04 +0100 (CET)
From: Werner Sembach <wse@tuxedocomputers.com>
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for ASRock NUC Box 1100
Date: Fri, 12 Nov 2021 12:07:04 +0100
Message-Id: <20211112110704.1022501-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This applies a SND_PCI_QUIRK(...) to the ASRock NUC Box 1100 series. This
fixes the issue of the headphone jack not being detected unless warm
rebooted from a certain other OS.

When booting a certain other OS some coeff settings are changed that enable
the audio jack. These settings are preserved on a warm reboot and can be
easily dumped.

The relevant indexes and values where gathered by naively diff-ing and
reading a working and a non-working coeff dump.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 sound/pci/hda/patch_realtek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2f1727faec69..701c80ed83dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6521,6 +6521,27 @@ static void alc256_fixup_tongfang_reset_persistent_settings(struct hda_codec *co
 	alc_write_coef_idx(codec, 0x45, 0x5089);
 }
 
+static const struct coef_fw alc233_fixup_no_audio_jack_coefs[] = {
+	WRITE_COEF(0x1a, 0x9003), WRITE_COEF(0x1b, 0x0e2b), WRITE_COEF(0x37, 0xfe06),
+	WRITE_COEF(0x38, 0x4981), WRITE_COEF(0x45, 0xd489), WRITE_COEF(0x46, 0x0074),
+	WRITE_COEF(0x49, 0x0149),
+	{}
+};
+
+static void alc233_fixup_no_audio_jack(struct hda_codec *codec,
+				       const struct hda_fixup *fix,
+				       int action)
+{
+	/*
+	 * The audio jack input and output is not detected on the ASRock NUC Box
+	 * 1100 series when cold booting without this fix. Warm rebooting from a
+	 * certain other OS makes the audio functional, as COEF settings are
+	 * preserved in this case. This fix sets these altered COEF values as
+	 * the default.
+	 */
+	alc_process_coef_fw(codec, alc233_fixup_no_audio_jack_coefs);
+}
+
 enum {
 	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
@@ -6740,6 +6761,7 @@ enum {
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	ALC233_FIXUP_NO_AUDIO_JACK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8460,6 +8482,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	},
+	[ALC233_FIXUP_NO_AUDIO_JACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_no_audio_jack,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8894,6 +8920,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
 	SND_PCI_QUIRK(0x1b35, 0x1236, "CZC TMI", ALC269_FIXUP_CZC_TMI),
-- 
2.25.1

