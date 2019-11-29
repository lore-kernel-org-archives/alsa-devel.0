Return-Path: <SRS0=Vfj9=ZV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A91C432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:42:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDD7217BA
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="do7AApYK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Fdk/00cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDD7217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6D4D16C0;
	Fri, 29 Nov 2019 15:41:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6D4D16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575038517;
	bh=d68w+32GC9Fgb7MsvgnmaaIM6nCnOuwjmt+yLGOEhio=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=do7AApYKCGlgXf4uXs4SuU01KW9H6PAPB+WkaxThcgT7+xigS1iTZ8tgSQK/Abl+J
	 gv04an1E0ZBZexRTHLruF6u0D6n9stDNIqTElb3CFZ51oAEC1A0kMDkJPe9leK49wP
	 A3+EIu4Rb91EKx1YikP8hIZljtOPZpe7GylOdix8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BA93F8013B;
	Fri, 29 Nov 2019 15:41:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B45DF80141; Fri, 29 Nov 2019 15:41:05 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAFDFF80106
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2019 15:41:02 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EB1CCA0040;
 Fri, 29 Nov 2019 15:41:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EB1CCA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575038462; bh=w6O0vZI56T+78y+JXku/lkI7ucYY5A63AaGWkDCMjeU=;
 h=From:To:Cc:Subject:Date:From;
 b=Fdk/00cS9crQS+QOgAnu8QWY9EPD0+iIqKMH3Tzriz+cQbCSLDPW3rL4J8PloHEsz
 Q2dDGN7lZXgRLz/D4vVmBGrm+8rB4/ieb8vidXPHgIjnKtF4/gCcrplu6dy9DuQRKs
 PIuw7sXzBfmv9ceXkCXxLO0rk4pkKExZb3xG7SWw=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 29 Nov 2019 15:40:58 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Date: Fri, 29 Nov 2019 15:40:27 +0100
Message-Id: <20191129144027.14765-1-perex@perex.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [alsa-devel] [PATCH] ALSA: hda - fixup for the bass speaker on
	Lenovo Carbon X1 7th gen
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The auto-parser assigns the bass speaker to DAC3 (NID 0x06) which
is without the volume control. I do not see a reason to use DAC2,
because the shared output to all speakers produces the sufficient
and well balanced sound. The stereo support is enough for this
purpose (laptop).

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/patch_realtek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d2bf70a1d2fd..a596790d4245 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5544,6 +5544,16 @@ static void alc295_fixup_disable_dac3(struct hda_codec *codec,
 	}
 }
 
+/* force NID 0x17 (Bass Speaker) to DAC1 to share it with the main speaker */
+static void alc285_fixup_speaker2_to_dac1(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		hda_nid_t conn[1] = { 0x02 };
+		snd_hda_override_conn_list(codec, 0x17, 1, conn);
+	}
+}
+
 /* Hook to update amp GPIO4 for automute */
 static void alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
 					  struct hda_jack_callback *jack)
@@ -5846,6 +5856,7 @@ enum {
 	ALC225_FIXUP_DISABLE_MIC_VREF,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC295_FIXUP_DISABLE_DAC3,
+	ALC285_FIXUP_SPEAKER2_TO_DAC1,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -6646,6 +6657,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_disable_dac3,
 	},
+	[ALC285_FIXUP_SPEAKER2_TO_DAC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7221,6 +7236,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x2293, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
@@ -7405,6 +7421,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_DELL_SPK_NOISE, .name = "dell-spk-noise"},
 	{.id = ALC225_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "alc225-dell1"},
 	{.id = ALC295_FIXUP_DISABLE_DAC3, .name = "alc295-disable-dac3"},
+	{.id = ALC285_FIXUP_SPEAKER2_TO_DAC1, .name = "alc285-speaker2-to-dac1"},
 	{.id = ALC280_FIXUP_HP_HEADSET_MIC, .name = "alc280-hp-headset"},
 	{.id = ALC221_FIXUP_HP_FRONT_MIC, .name = "alc221-hp-mic"},
 	{.id = ALC298_FIXUP_SPK_VOLUME, .name = "alc298-spk-volume"},
-- 
2.20.1
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
