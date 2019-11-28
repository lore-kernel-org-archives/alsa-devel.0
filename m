Return-Path: <SRS0=87PQ=ZU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6429AC432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:27:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F360216F4
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o4AEXo/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F360216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0750E16D5;
	Thu, 28 Nov 2019 21:26:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0750E16D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574972850;
	bh=mydFtl4zJnC7ybCEFtVH1rWCn7YobdBZ9VyipX2B0kI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o4AEXo/pMxlKYO7kvZHyB1c8EseA4VOsDIqHQEM2ESY1e6TjuO3eVNbFjzDZsSU++
	 ZTVIhKli92N98ZOMv1xsc6XHQU4hiDB86t6jYw3567kqu0SOlfKXPb/kmdDK4nbTue
	 d2YdTvrCgHVCHrMX1imMxgGEpIjXxwPFmWJY6e0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74CE4F8013A;
	Thu, 28 Nov 2019 21:26:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D82AF80149; Thu, 28 Nov 2019 21:26:37 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CC32F800CB
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2019 21:26:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CC32F800CB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C8C93ABC7;
 Thu, 28 Nov 2019 20:26:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 28 Nov 2019 21:26:30 +0100
Message-Id: <20191128202630.6626-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Subject: [alsa-devel] [PATCH] ALSA: hda/realtek - Fix inverted bass GPIO pin
	on Acer 8951G
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

We've added the bass speaker support on Acer 8951G by the commit
00066e9733f6 ("Add Acer Aspire Ethos 8951G model quirk"), but it seems
that the GPIO pin was wrongly set: while the commit turns off the bit
to power up the amp, the actual hardware reacts other way round,
i.e. GPIO bit on = amp on.

So this patch fixes the bug, turning on the GPIO bit 0x02 as default.
Since turning on the GPIO bit can be more easily managed with
alc_setup_gpio() call, we simplify the quirk code by integrating the
GPIO setup into the existing alc662_fixup_aspire_ethos_hp() and
dropping the whole ALC669_FIXUP_ACER_ASPIRE_ETHOS_SUBWOOFER quirk.

Fixes: 00066e9733f6 ("Add Acer Aspire Ethos 8951G model quirk")
Reported-and-tested-by: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9f355b2f7d7b..c7a232fd5a5b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8427,6 +8427,8 @@ static void alc662_fixup_aspire_ethos_hp(struct hda_codec *codec,
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		snd_hda_jack_detect_enable_callback(codec, 0x1b,
 				alc662_aspire_ethos_mute_speakers);
+		/* subwoofer needs an extra GPIO setting to become audible */
+		alc_setup_gpio(codec, 0x02);
 		break;
 	case HDA_FIXUP_ACT_INIT:
 		/* Make sure to start in a correct state, i.e. if
@@ -8509,7 +8511,6 @@ enum {
 	ALC662_FIXUP_USI_HEADSET_MODE,
 	ALC662_FIXUP_LENOVO_MULTI_CODECS,
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS,
-	ALC669_FIXUP_ACER_ASPIRE_ETHOS_SUBWOOFER,
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
 };
 
@@ -8841,18 +8842,6 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc662_fixup_aspire_ethos_hp,
 	},
-	[ALC669_FIXUP_ACER_ASPIRE_ETHOS_SUBWOOFER] = {
-		.type = HDA_FIXUP_VERBS,
-		/* subwoofer needs an extra GPIO setting to become audible */
-		.v.verbs = (const struct hda_verb[]) {
-			{0x01, AC_VERB_SET_GPIO_MASK, 0x02},
-			{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x02},
-			{0x01, AC_VERB_SET_GPIO_DATA, 0x00},
-			{ }
-		},
-		.chained = true,
-		.chain_id = ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET
-	},
 	[ALC669_FIXUP_ACER_ASPIRE_ETHOS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -8862,7 +8851,7 @@ static const struct hda_fixup alc662_fixups[] = {
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC669_FIXUP_ACER_ASPIRE_ETHOS_SUBWOOFER
+		.chain_id = ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET
 	},
 };
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
