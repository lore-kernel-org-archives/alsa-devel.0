Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047B4C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 15:54:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 106D72D59;
	Fri,  5 May 2023 17:53:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 106D72D59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683302051;
	bh=7nznjXcOlkL3r4CBDAiXh+lu3tYPdz6ucFyVan6SVG0=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iYULXEUK7bd+nQiKQmZzUBBLm7wpFS3s1Stz9ouPixxf15M3151R9cFl0C32bgP/d
	 3T+JCF2qBkqkhgKLt4q2Lh8iEFfaSyo41RZZxP7tBSOC49oJ9X79BL1sQF3zAmJpMm
	 Rfy1Js5gwJw68Dmp/03UGssSZ/t3YaEaUE85R75k=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A1AAF80552;
	Fri,  5 May 2023 17:52:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3107EF80549; Fri,  5 May 2023 17:52:53 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 945B0F80534
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 17:52:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 945B0F80534
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 48305240D5;
	Fri,  5 May 2023 11:52:45 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1puxjh-hW4-00; Fri, 05 May 2023 17:52:45 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 4/7] ALSA: pcm: playback silence - remove extra code
Date: Fri,  5 May 2023 17:52:41 +0200
Message-Id: <20230505155244.2312199-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230505155244.2312199-1-oswald.buddenhagen@gmx.de>
References: <20230505155244.2312199-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: L7YZKSGXI6BKW3TZU5ZDEXSUINL5U5DI
X-Message-ID-Hash: L7YZKSGXI6BKW3TZU5ZDEXSUINL5U5DI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L7YZKSGXI6BKW3TZU5ZDEXSUINL5U5DI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jaroslav Kysela <perex@perex.cz>

The removed condition handles de facto only one situation where
runtime->silence_filled variable is equal to runtime->buffer_size,
because this variable cannot go over the buffer size. This case is
implicitly caught by the required comparison of the noise distance
with the threshold.

Suggested-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- improved language of commit message
---
 sound/core/pcm_lib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 5ddb74a12030..a1838130c830 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -61,8 +61,6 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 				runtime->silence_filled = 0;
 			runtime->silence_start = appl_ptr;
 		}
-		if (runtime->silence_filled >= runtime->buffer_size)
-			return;
 		/* initialization outside pointer updates */
 		if (new_hw_ptr == ULONG_MAX)
 			new_hw_ptr = runtime->status->hw_ptr;
-- 
2.40.0.152.g15d061e6df

