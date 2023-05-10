Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E71C77B7C
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 17:40:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3BDF1014;
	Wed, 10 May 2023 19:39:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3BDF1014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683740444;
	bh=VcfD+ZrVl9FHLlbLXLOsKfQGrdVbm5OgBHSE6sVGP3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ir1J+uUxURu+AHETPTyi6WOaDY1NUbspU6Mn5aZO4eSO6Y8hhfB6T5KQLYXsswBHW
	 I9Ophx6fwZa6J24wtHIuTZFe/aI6lQQmKnkpzXW8XM92hKQV+TA+f4HqUCfz4JU4Rc
	 CYOMxs32Fm+sLkLg+3NuR3eR5HQVnb0Ddymr5WGI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD851F80552;
	Wed, 10 May 2023 19:39:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E30FF8053B; Wed, 10 May 2023 19:39:23 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE550F802E8
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 19:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE550F802E8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 176AF240B5;
	Wed, 10 May 2023 13:39:18 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pwnmX-tSi-00; Wed, 10 May 2023 19:39:17 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 01/14] ALSA: emu10k1: make tone control switch mono
Date: Wed, 10 May 2023 19:39:04 +0200
Message-Id: <20230510173917.3073107-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230510173917.3073107-1-oswald.buddenhagen@gmx.de>
References: <20230510173917.3073107-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IOC7TICGN77I6NYZ5572QKAP47N62UHK
X-Message-ID-Hash: IOC7TICGN77I6NYZ5572QKAP47N62UHK
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IOC7TICGN77I6NYZ5572QKAP47N62UHK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

It controls the whole surround set, so stereo can't work. As a
consequence, only the left channel was paid attention to.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emufx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 98785110ef63..6442028fe48a 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1543,13 +1543,13 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 #undef TREBLE_GPR
 
 	for (z = 0; z < 8; z++) {
-		A_SWITCH(icode, &ptr, tmp + 0, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, gpr + 0);
-		A_SWITCH_NEG(icode, &ptr, tmp + 1, gpr + 0);
+		A_SWITCH(icode, &ptr, tmp + 0, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, gpr);
+		A_SWITCH_NEG(icode, &ptr, tmp + 1, gpr);
 		A_SWITCH(icode, &ptr, tmp + 1, playback + z, tmp + 1);
 		A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
 	}
-	snd_emu10k1_init_stereo_onoff_control(controls + nctl++, "Tone Control - Switch", gpr, 0);
-	gpr += 2;
+	snd_emu10k1_init_mono_onoff_control(controls + nctl++, "Tone Control - Switch", gpr, 0);
+	gpr++;
 
 	/* Master volume (will be renamed later) */
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
@@ -2263,13 +2263,13 @@ static int _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 #undef TREBLE_GPR
 
 	for (z = 0; z < 6; z++) {
-		SWITCH(icode, &ptr, tmp + 0, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, gpr + 0);
-		SWITCH_NEG(icode, &ptr, tmp + 1, gpr + 0);
+		SWITCH(icode, &ptr, tmp + 0, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, gpr);
+		SWITCH_NEG(icode, &ptr, tmp + 1, gpr);
 		SWITCH(icode, &ptr, tmp + 1, playback + z, tmp + 1);
 		OP(icode, &ptr, iACC3, GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + z), GPR(tmp + 0), GPR(tmp + 1), C_00000000);
 	}
-	snd_emu10k1_init_stereo_onoff_control(controls + i++, "Tone Control - Switch", gpr, 0);
-	gpr += 2;
+	snd_emu10k1_init_mono_onoff_control(controls + i++, "Tone Control - Switch", gpr, 0);
+	gpr++;
 
 	/*
 	 *  Process outputs
-- 
2.40.0.152.g15d061e6df

