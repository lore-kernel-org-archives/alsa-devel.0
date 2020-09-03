Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBEC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:34:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBAF206E7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LvV9gw0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBAF206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9B4E18D2;
	Thu,  3 Sep 2020 10:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9B4E18D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599122045;
	bh=8CI5dt1ZOkRcb/O18HzS10d/hu+IMqyGHEHlBXUkcJE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LvV9gw0NZQ43fVmlqsQOM78xINTPxNN7sEx7DuW1yAwAQXOH47YPxDwtrHHl4VtS6
	 p0gSLU5Ds5ubP98D9Q4BokMI5Gjld5xKrT97eGo6G2aOZ8qu6uq7UDyIGkLm0u/SC+
	 p5oN9msfjtKoE4MUEW61sAruHrtAP4os8yP+KAa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3630AF801DA;
	Thu,  3 Sep 2020 10:33:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81F5FF8025F; Thu,  3 Sep 2020 10:33:13 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3455F801DA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 10:33:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3455F801DA
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3D022AFA8;
 Thu,  3 Sep 2020 08:33:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek - Improved routing for Thinkpad X1 7th/8th
 Gen
Date: Thu,  3 Sep 2020 10:33:00 +0200
Message-Id: <20200903083300.6333-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Benjamin Poirier <benjamin.poirier@gmail.com>
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

There've been quite a few regression reports about the lowered volume
(reduced to ca 65% from the previous level) on Lenovo Thinkpad X1
after the commit d2cd795c4ece ("ALSA: hda - fixup for the bass speaker
on Lenovo Carbon X1 7th gen").  Although the commit itself does the
right thing from HD-audio POV in order to have a volume control for
bass speakers, it seems that the machine has some secret recipe under
the hood.

Through experiments, Benjamin Poirier found out that the following
routing gives the best result:
* DAC1 (NID 0x02) -> Speaker pin (NID 0x14)
* DAC2 (NID 0x03) -> Shared by both Bass Speaker pin (NID 0x17) &
                     Headphone pin (0x21)
* DAC3 (NID 0x06) -> Unused

DAC1 seems to have some equalizer internally applied, and you'd get
again the output in a bad quality if you connect this to the
headphone pin.  Hence the headphone is connected to DAC2, which is now
shared with the bass speaker pin.  DAC3 has no volume amp, hence it's
not connected at all.

For achieving the routing above, this patch introduced a couple of
workarounds:

* The connection list of bass speaker pin (NID 0x17) is reduced not to
  include DAC3 (NID 0x06)
* Pass preferred_pairs array to specify the fixed connection

Here, both workarounds are needed because the generic parser prefers
the individual DAC assignment over others.

When the routing above is applied, the generic parser creates the two
volume controls "Front" and "Bass Speaker".  Since we have only two
DACs for three output pins, those are not fully controlling each
output individually, and it would confuse PulseAudio.  For avoiding
the pitfall, in this patch, we rename those volume controls to some
unique ones ("DAC1" and "DAC2").  Then PulseAudio ignore them and
concentrate only on the still good-working "Master" volume control.
If a user still wants to control each DAC volume, they can still
change manually via "DAC1" and "DAC2" volume controls.

Fixes: d2cd795c4ece ("ALSA: hda - fixup for the bass speaker on Lenovo Carbon X1 7th gen")
Reported-by: Benjamin Poirier <benjamin.poirier@gmail.com>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Tested-by: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207407#c10
BugLink: https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3214171
BugLink: https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3276276
Link: https://lore/kernel.org/r/20200829112746.3118-1-benjamin.poirier@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2ef8b080d84b..c521a1f17096 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5868,6 +5868,39 @@ static void alc275_fixup_gpio4_off(struct hda_codec *codec,
 	}
 }
 
+/* Quirk for Thinkpad X1 7th and 8th Gen
+ * The following fixed routing needed
+ * DAC1 (NID 0x02) -> Speaker (NID 0x14); some eq applied secretly
+ * DAC2 (NID 0x03) -> Bass (NID 0x17) & Headphone (NID 0x21); sharing a DAC
+ * DAC3 (NID 0x06) -> Unused, due to the lack of volume amp
+ */
+static void alc285_fixup_thinkpad_x1_gen7(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	static const hda_nid_t conn[] = { 0x02, 0x03 }; /* exclude 0x06 */
+	static const hda_nid_t preferred_pairs[] = {
+		0x14, 0x02, 0x17, 0x03, 0x21, 0x03, 0
+	};
+	struct alc_spec *spec = codec->spec;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		spec->gen.preferred_dacs = preferred_pairs;
+		break;
+	case HDA_FIXUP_ACT_BUILD:
+		/* The generic parser creates somewhat unintuitive volume ctls
+		 * with the fixed routing above, and the shared DAC2 may be
+		 * confusing for PA.
+		 * Rename those to unique names so that PA doesn't touch them
+		 * and use only Master volume.
+		 */
+		rename_ctl(codec, "Front Playback Volume", "DAC1 Playback Volume");
+		rename_ctl(codec, "Bass Speaker Playback Volume", "DAC2 Playback Volume");
+		break;
+	}
+}
+
 static void alc233_alc662_fixup_lenovo_dual_codecs(struct hda_codec *codec,
 					 const struct hda_fixup *fix,
 					 int action)
@@ -6136,6 +6169,7 @@ enum {
 	ALC289_FIXUP_DUAL_SPK,
 	ALC294_FIXUP_SPK2_TO_DAC1,
 	ALC294_FIXUP_ASUS_DUAL_SPK,
+	ALC285_FIXUP_THINKPAD_X1_GEN7,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_HPE,
 	ALC294_FIXUP_ASUS_COEF_1B,
@@ -7281,11 +7315,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_SPK2_TO_DAC1
 	},
+	[ALC285_FIXUP_THINKPAD_X1_GEN7] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_thinkpad_x1_gen7,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
+	},
 	[ALC285_FIXUP_THINKPAD_HEADSET_JACK] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_jack,
 		.chained = true,
-		.chain_id = ALC285_FIXUP_SPEAKER2_TO_DAC1
+		.chain_id = ALC285_FIXUP_THINKPAD_X1_GEN7
 	},
 	[ALC294_FIXUP_ASUS_HPE] = {
 		.type = HDA_FIXUP_VERBS,
-- 
2.16.4

