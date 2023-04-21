Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193C6C7618E
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 14:12:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9153EAA;
	Fri, 21 Apr 2023 16:11:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9153EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682086369;
	bh=wYf7Sr+9FjR0436UXWcXRigu8zUHp3x8XavooJ8pfxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bQpPpkqicetJJfJJ5aOhTpxSyhQs3gv5TWUfu7jmSbfuDUl/N16T31IkMwCTHE08T
	 JOu/fH6l+sqT8U0/aw/IAantrPjbqGDS7UeWDQrHt8stgP20YaGs69BcCi9RczKVck
	 tN3rWCtp92iHVSTFx+wgJXtnuG0Mr17XqdCOwdkM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1008DF80557;
	Fri, 21 Apr 2023 16:10:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A394F80548; Fri, 21 Apr 2023 16:10:19 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5BBF7F800F8
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 16:10:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BBF7F800F8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 8479923FF1;
	Fri, 21 Apr 2023 10:10:06 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pprSg-DZJ-00; Fri, 21 Apr 2023 16:10:06 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/7] ALSA: emu10k1: drop redundant
 snd_emu10k1_efx_playback_pointer()
Date: Fri, 21 Apr 2023 16:10:01 +0200
Message-Id: <20230421141006.1005452-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230421141006.1005452-1-oswald.buddenhagen@gmx.de>
References: <20230421141006.1005452-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7AERNHVUCC3OCDDM3SGDJVAQU273BE6C
X-Message-ID-Hash: 7AERNHVUCC3OCDDM3SGDJVAQU273BE6C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7AERNHVUCC3OCDDM3SGDJVAQU273BE6C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

It's just an (outdated) copy of snd_emu10k1_playback_pointer().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/pci/emu10k1/emupcm.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index b89382aa4db6..b7830fd5c2b4 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -76,23 +76,6 @@ static void snd_emu10k1_pcm_efx_interrupt(struct snd_emu10k1 *emu,
 	snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
 }	 
 
-static snd_pcm_uframes_t snd_emu10k1_efx_playback_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_emu10k1 *emu = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_emu10k1_pcm *epcm = runtime->private_data;
-	unsigned int ptr;
-
-	if (!epcm->running)
-		return 0;
-	ptr = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
-	ptr += runtime->buffer_size;
-	ptr -= epcm->ccca_start_addr;
-	ptr %= runtime->buffer_size;
-
-	return ptr;
-}
-
 static int snd_emu10k1_pcm_channel_alloc(struct snd_emu10k1_pcm * epcm, int voices)
 {
 	int err, i;
@@ -1345,7 +1328,7 @@ static const struct snd_pcm_ops snd_emu10k1_efx_playback_ops = {
 	.hw_free =		snd_emu10k1_playback_hw_free,
 	.prepare =		snd_emu10k1_efx_playback_prepare,
 	.trigger =		snd_emu10k1_efx_playback_trigger,
-	.pointer =		snd_emu10k1_efx_playback_pointer,
+	.pointer =		snd_emu10k1_playback_pointer,
 };
 
 int snd_emu10k1_pcm(struct snd_emu10k1 *emu, int device)
-- 
2.40.0.152.g15d061e6df

