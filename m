Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804ACC77B7C
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 10:34:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B55E32C48;
	Fri,  5 May 2023 12:34:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B55E32C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683282892;
	bh=jUhZv4Z7PxT4f22fUgngH2PsdOC0JqQUHIy9EYEB04A=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=esBion4rdKvrlPxDlwEeOfVeUIYGXmWASvbSXnj6zjHM8lcLRhSg6ASclr+8MfyvB
	 AHVzLX0dRyRQXROWqwjbIadP0q7fbJhVqR50LPlDQ0QiCCe94u7c2X6vXJUrR2/OCQ
	 pMX0jjYSKfHNlynLxbRkxl8M+ByCKJ5w5yc+jQsw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3460F80578;
	Fri,  5 May 2023 12:32:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94C5FF80553; Fri,  5 May 2023 12:32:00 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 96A39F8053B
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 12:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96A39F8053B
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 4BFE624172;
	Fri,  5 May 2023 06:31:41 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pusiz-abJ-00; Fri, 05 May 2023 12:31:41 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/7] ALSA: pcm: fix playback silence - correct incremental
 silencing
Date: Fri,  5 May 2023 12:31:36 +0200
Message-Id: <20230505103140.2285622-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230505103140.2285622-1-oswald.buddenhagen@gmx.de>
References: <20230505103140.2285622-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4RMZGSNLCZ3NC7RBYGVMRNNMICGCQ37A
X-Message-ID-Hash: 4RMZGSNLCZ3NC7RBYGVMRNNMICGCQ37A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RMZGSNLCZ3NC7RBYGVMRNNMICGCQ37A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jaroslav Kysela <perex@perex.cz>

Commit 9a826ddba6e ("[ALSA] pcm core: fix silence_start calculations")
came with exactly the right commit message, but the patch just made
things broken in a different way: We'd fill at a too low address if the
area was already partially zeroed, so we'd under-fill. This affected
both thresholded mode (where it was somewhat less likely) and top-up
mode (where it would be the case consistently).

Suggested-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- rewrote commit message
- postponed the addition of comments to a subsequent patch where it
  makes more sense
- dropped the part which the subsequent refactoring obsoletes.
  this reduces the patch to its essentials, making it easier to
  understand, and reducing churn.
---
 sound/core/pcm_lib.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6ad67e7e740c..5ddb74a12030 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -87,29 +87,25 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 			if (avail > runtime->buffer_size)
 				avail = runtime->buffer_size;
 			runtime->silence_filled = avail > 0 ? avail : 0;
-			runtime->silence_start = (runtime->status->hw_ptr +
-						  runtime->silence_filled) %
-						 runtime->boundary;
+			runtime->silence_start = runtime->status->hw_ptr;
 		} else {
 			ofs = runtime->status->hw_ptr;
 			frames = new_hw_ptr - ofs;
 			if ((snd_pcm_sframes_t)frames < 0)
 				frames += runtime->boundary;
 			runtime->silence_filled -= frames;
 			if ((snd_pcm_sframes_t)runtime->silence_filled < 0) {
 				runtime->silence_filled = 0;
-				runtime->silence_start = new_hw_ptr;
-			} else {
-				runtime->silence_start = ofs;
 			}
+			runtime->silence_start = new_hw_ptr;
 		}
 		frames = runtime->buffer_size - runtime->silence_filled;
 	}
 	if (snd_BUG_ON(frames > runtime->buffer_size))
 		return;
 	if (frames == 0)
 		return;
-	ofs = runtime->silence_start % runtime->buffer_size;
+	ofs = (runtime->silence_start + runtime->silence_filled) % runtime->buffer_size;
 	while (frames > 0) {
 		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
 		err = fill_silence_frames(substream, ofs, transfer);
-- 
2.40.0.152.g15d061e6df

