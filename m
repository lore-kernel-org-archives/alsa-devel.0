Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E31C77B7D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 08:42:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B0BC822;
	Mon, 15 May 2023 10:41:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B0BC822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684140155;
	bh=GCjBjR6Wy4GKDSV/RsKMrw7IJIr1jrKGwN8maZkTeyA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iHI8YsNjKf80s4Fx5BEpcoZAybXlIHWDQJvXdhT4NfWo26IssIPePdkE3C5jlL14t
	 nN5a4kOqpNN1VwsOz923JlaV0uv/ELh2nwmCPDDAl2bEj1DohP8a3OH4Vrd78tNytY
	 dqG0rm9NLY+KRDZNqK6I3OyhV4HMREId13+edTD0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64E63F80272; Mon, 15 May 2023 10:41:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17705F802E8;
	Mon, 15 May 2023 10:41:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E4B4F80272; Mon, 15 May 2023 10:41:14 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6CD8FF8024E
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 10:41:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CD8FF8024E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id F0FCA24060;
	Mon, 15 May 2023 04:41:06 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pyTlS-StX-00; Mon, 15 May 2023 10:41:06 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] pcm: hw: reinterpret the drain_silence setting
Date: Mon, 15 May 2023 10:41:05 +0200
Message-Id: <20230515084106.3447657-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JQEJ73KVE4WEKLSJ3ZVD5477RFB23Z6Q
X-Message-ID-Hash: JQEJ73KVE4WEKLSJ3ZVD5477RFB23Z6Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JQEJ73KVE4WEKLSJ3ZVD5477RFB23Z6Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

It makes no sense to have a config option which determines the entire
silencing time, because useful values strongly depend on the period size
runtime setting.

So instead we interpret the setting as an override for the "overhang"
which is used to compensate FIFOs and IRQ delays. The reasonable worst
case of this is determined by the hardware, so it makes sense to have
this as a config option.

In a next step, we may want to derive the default value from the
declared FIFO size (whiche few drivers do) and the minimal period size
(which is generally linked to the FIFO size).

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 src/pcm/pcm_hw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 8ffebed9..ecc47a76 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -737,18 +737,19 @@ static int snd_pcm_hw_drain(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
 	snd_pcm_sw_params_t sw_params;
+	snd_pcm_uframes_t silence_slack;
 	snd_pcm_uframes_t silence_size;
 	int err;
 
 	if (pcm->stream != SND_PCM_STREAM_PLAYBACK)
 		goto __skip_silence;
 	if (hw->drain_silence == 0 || hw->perfect_drain)
 		goto __skip_silence;
 	snd_pcm_sw_params_current_no_lock(pcm, &sw_params);
-	if (hw->drain_silence > 0) {
-		silence_size = (pcm->rate * hw->drain_silence) / 1000;
-		goto __manual_silence;
-	}
+	if (hw->drain_silence > 0)
+		silence_slack = (pcm->rate * hw->drain_silence) / 1000;
+	else
+		silence_slack = pcm->rate / 10;	/* 1/10th of second */
 	/* compute end silence size, align to period size + extra time */
 	if ((pcm->boundary % pcm->period_size) == 0) {
 		silence_size = pcm->period_size - (*pcm->appl.ptr % pcm->period_size);
@@ -761,8 +762,7 @@ static int snd_pcm_hw_drain(snd_pcm_t *pcm)
 		 */
 		silence_size = pcm->period_size;
 	}
-	silence_size += pcm->rate / 10;	/* 1/10th of second */
-__manual_silence:
+	silence_size += silence_slack;
 	if (sw_params.silence_size < silence_size) {
 		/* fill the silence soon as possible (in the bellow ioctl
 		 * or the next period wake up)
-- 
2.40.0.152.g15d061e6df

