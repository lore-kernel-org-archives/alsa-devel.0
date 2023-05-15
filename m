Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77186C77B7D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 08:43:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7E49836;
	Mon, 15 May 2023 10:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7E49836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684140181;
	bh=g87RweiRVYEUQN9Oo8a04W6MJeIdKddNLYZCLONeNys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kmJzFU6fIrSuDsT/t6sf4HnjCn8rWqaEXzZheWPdcxdtiIJ+5B326cixhUqn38m/P
	 cp1nnAPG8UjUdh4khmbZenhqZ8q88AX90HwtX0qJHT4DWBKhCsUiH8th0BROhJ2cLr
	 SKpzDGkrKJpHbUItiBy/uDOJbUO6uY0m4fDkuv0g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E387FF80553; Mon, 15 May 2023 10:41:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 876D4F80552;
	Mon, 15 May 2023 10:41:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E13D4F80272; Mon, 15 May 2023 10:41:17 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BF1A0F8024E
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 10:41:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF1A0F8024E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 050E62424B;
	Mon, 15 May 2023 04:41:07 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pyTlS-Std-00; Mon, 15 May 2023 10:41:06 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] pcm: hw: fix excessive silence fill on drain
Date: Mon, 15 May 2023 10:41:06 +0200
Message-Id: <20230515084106.3447657-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230515084106.3447657-1-oswald.buddenhagen@gmx.de>
References: <20230515084106.3447657-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RLIMAND3XSZAPWLMHN3MX3RNONQ772AI
X-Message-ID-Hash: RLIMAND3XSZAPWLMHN3MX3RNONQ772AI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RLIMAND3XSZAPWLMHN3MX3RNONQ772AI/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Setting the threshold to the size of the buffer results in additional
filling each time a period elapses. As draining is usually initiated
with a rather full buffer, this would usually result in filling way in
excess of what was intended.

A sufficient threshold is the required worst-case fill, that is, one
period size plus the "overhang".

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---

This patch is entirely untested! But it's derived from my previously
posted v3 kernel patch, which was successfully tested.
---
 src/pcm/pcm_hw.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index ecc47a76..a5f87215 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -764,12 +764,11 @@ static int snd_pcm_hw_drain(snd_pcm_t *pcm)
 	}
 	silence_size += silence_slack;
 	if (sw_params.silence_size < silence_size) {
-		/* fill the silence soon as possible (in the bellow ioctl
-		 * or the next period wake up)
-		 */
-		sw_params.silence_threshold = pcm->buffer_size;
-		if (silence_size > pcm->buffer_size)
-			silence_size = pcm->buffer_size;
+		sw_params.silence_threshold = pcm->period_size + silence_slack;
+		if (sw_params.silence_threshold > pcm->buffer_size)
+			sw_params.silence_threshold = pcm->buffer_size;
+		if (silence_size > sw_params.silence_threshold)
+			silence_size = sw_params.silence_threshold;
 		sw_params.silence_size = silence_size;
 		if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SW_PARAMS, &sw_params) < 0) {
 			err = -errno;
-- 
2.40.0.152.g15d061e6df

