Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2EEC77B7D
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 10:33:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 511222C4E;
	Fri,  5 May 2023 12:32:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 511222C4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683282817;
	bh=k7n7eqlG/TRgKNkzu/hg5+IuiMF7Q2VmP7rofJw5Y8I=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AxtrP5aY/xHeWSD0pWMHFb4+xL9ht3vVLz/UwiGzDC3QGHjrfoGR4GLjihvNTm23D
	 Mbu6TkYN2x5VlA8+laQYBw3Axj89NscfwRZPrcDtLMO053RD3Z0V2tO/U6HSS6cBj7
	 Ya/AysMvHqtB65BKGmCOaGsyrrGaOl5W0SKXofbQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 97B9CF80544;
	Fri,  5 May 2023 12:31:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F519F8053D; Fri,  5 May 2023 12:31:50 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 607ADF80529
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 12:31:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 607ADF80529
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 61761241B4;
	Fri,  5 May 2023 06:31:41 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pusiz-abh-00; Fri, 05 May 2023 12:31:41 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 7/7] ALSA: pcm: use exit controlled loop in
 snd_pcm_playback_silence()
Date: Fri,  5 May 2023 12:31:40 +0200
Message-Id: <20230505103140.2285622-7-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230505103140.2285622-1-oswald.buddenhagen@gmx.de>
References: <20230505103140.2285622-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FVBKWDLLFWJNNVE4UF64SYI3ERRJN2XX
X-Message-ID-Hash: FVBKWDLLFWJNNVE4UF64SYI3ERRJN2XX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FVBKWDLLFWJNNVE4UF64SYI3ERRJN2XX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We already know that `frames` is greater than zero, because we just
checked it. So we don't need to check the loop condition on the first
iteration.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/core/pcm_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 17fc80a654be..9c121a921b04 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -123,14 +123,14 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 	if (frames == 0)
 		return;
 	ofs = (runtime->silence_start + runtime->silence_filled) % runtime->buffer_size;
-	while (frames > 0) {
+	do {
 		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
 		err = fill_silence_frames(substream, ofs, transfer);
 		snd_BUG_ON(err < 0);
 		runtime->silence_filled += transfer;
 		frames -= transfer;
 		ofs = 0;
-	}
+	} while (frames > 0);
 	snd_pcm_dma_buffer_sync(substream, SNDRV_DMA_SYNC_DEVICE);
 }
 
-- 
2.40.0.152.g15d061e6df

