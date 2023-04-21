Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A3C77B71
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 14:14:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B4BDEA4;
	Fri, 21 Apr 2023 16:13:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B4BDEA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682086451;
	bh=4/X6uguuEYQZT3NhDy05/iRHji2b1ogAEm8v/y/sMos=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YSgyH9raSUdVmWLMlk7W+L2uDE7Nafqxc9JvM52kB+bMn0uOTVjbdEyatl8JW7tA9
	 VWxauXVHUIw2Z08R6c1nYZJaDGpepOton+GN4Ko1xn+/xojoGjnfkJcWmrZ8ldJD0V
	 eDRchiGXa0MCf3drfGQwuDutyxCFGDFEwyFZaPlU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B649F8059F;
	Fri, 21 Apr 2023 16:10:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEC7BF8055C; Fri, 21 Apr 2023 16:10:32 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13C64F80212
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 16:10:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13C64F80212
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 8E791240F9;
	Fri, 21 Apr 2023 10:10:06 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pprSg-DZb-00; Fri, 21 Apr 2023 16:10:06 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/7] ALSA: emu10k1: remove unused snd_emu10k1_voice.emu field
Date: Fri, 21 Apr 2023 16:10:04 +0200
Message-Id: <20230421141006.1005452-5-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230421141006.1005452-1-oswald.buddenhagen@gmx.de>
References: <20230421141006.1005452-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: T5ENRU62OLZG2ZYC2ODUPOJU4EXPPXTW
X-Message-ID-Hash: T5ENRU62OLZG2ZYC2ODUPOJU4EXPPXTW
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T5ENRU62OLZG2ZYC2ODUPOJU4EXPPXTW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

It was written, but never read from. Its value is available via the epcm
field.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 include/sound/emu10k1.h          | 1 -
 sound/pci/emu10k1/emu10k1_main.c | 4 +---
 sound/pci/emu10k1/p16v.c         | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 9a6ede9ac18a..d1bae032c05f 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1485,7 +1485,6 @@ enum {
 struct snd_emu10k1;
 
 struct snd_emu10k1_voice {
-	struct snd_emu10k1 *emu;
 	int number;
 	unsigned int use: 1,
 	    pcm: 1,
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index cbfaa4bc70a2..b862f6e7163b 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1970,10 +1970,8 @@ int snd_emu10k1_create(struct snd_card *card,
 		pgtbl[idx] = cpu_to_le32(silent_page | idx);
 
 	/* set up voice indices */
-	for (idx = 0; idx < NUM_G; idx++) {
-		emu->voices[idx].emu = emu;
+	for (idx = 0; idx < NUM_G; idx++)
 		emu->voices[idx].number = idx;
-	}
 
 	err = snd_emu10k1_init(emu, enable_ir);
 	if (err < 0)
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 18a1b0740e6b..f5e0972187a7 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -181,7 +181,6 @@ static int snd_p16v_pcm_open_playback_channel(struct snd_pcm_substream *substrea
   
 	runtime->hw = snd_p16v_playback_hw;
 
-        channel->emu = emu;
         channel->number = channel_id;
 
         channel->use=1;
@@ -230,7 +229,6 @@ static int snd_p16v_pcm_open_capture_channel(struct snd_pcm_substream *substream
   
 	runtime->hw = snd_p16v_capture_hw;
 
-	channel->emu = emu;
 	channel->number = channel_id;
 
 	channel->use=1;
-- 
2.40.0.152.g15d061e6df

