Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69149E7106D
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 13:27:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D887EBB;
	Thu, 21 Sep 2023 15:27:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D887EBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695302876;
	bh=XmkGZAgcKaoBjYFNNgYwDqM8bkiEHH21JFMb9s21EL0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YXTqo3yfsIb42kYXfx6ce0fdM7IQhhgd3Fqj8B/CVdK1VLlWrl0pLbGN6WS7tDV02
	 QoGN3ezKe8s7ur/eP7cbGwR9CbWWGsB46bAXBF+C2HIEDbPxzb0hZkHltoY6v61gF7
	 JaOW5AQN7uwmNS5h404Exikntu2geNDx3Z3WBQJY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC67CF80589; Thu, 21 Sep 2023 15:24:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 00F6DF80589;
	Thu, 21 Sep 2023 15:24:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0E99F8047D; Thu, 21 Sep 2023 08:43:27 +0200 (CEST)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by alsa1.perex.cz (Postfix) with ESMTP id 01E05F80124
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 08:43:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01E05F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=XNUZWv3P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hoYvh
	nvFhXuWGdVJICSo9bwmHG2MJM7Vx2tCTDFfS0E=; b=XNUZWv3PbfNOnsVbyFoVX
	hJs/psJ0J87nKU9Km8gO/BN/3FW2/oukjLhImZ+J68Cq6pcqEENYZgitWRQskzX0
	+vpV+pvXQk9ooEWXGXtFpc6Uw9BijOToE3mSnYHimaBloyfzJs2iMyD2UEMV5HQ3
	1wgaIeqtC9mv1a7CXY7Ubs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id
 _____wCXs9355Qtl37mnCg--.7888S4;
	Thu, 21 Sep 2023 14:43:17 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: perex@perex.cz,
	tiwai@suse.com,
	Liam.Howlett@Oracle.com,
	rppt@kernel.org,
	mgorman@techsingularity.net,
	mhocko@suse.com,
	make_ruc2021@163.com,
	surenb@google.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: pcm: oss: Fix race at SNDCTL_DSP_SETTRIGGER
Date: Thu, 21 Sep 2023 14:42:58 +0800
Message-Id: <20230921064258.3582115-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXs9355Qtl37mnCg--.7888S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW7trWUKF1UAw47ZF4Utwb_yoW8uw15pr
	s2g34Fqr9rJFWvvw1kJwnFvr15Xr95ta45Kw48C34Fyws5Wr4F9F93KF9Y9FZYkFWDWan0
	vr4DA34UCr13AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR2sUiUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyAXxC1p7L1Zx8QAAsv
X-MailFrom: make_ruc2021@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: LJLYNIXK7BG4RMOCCB5DAZZQIJYWTACZ
X-Message-ID-Hash: LJLYNIXK7BG4RMOCCB5DAZZQIJYWTACZ
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:24:00 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJLYNIXK7BG4RMOCCB5DAZZQIJYWTACZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There is a small race window at snd_pcm_oss_set_trigger() that is
called from OSS PCM SNDCTL_DSP_SETTRIGGER ioctl; namely the function
calls snd_pcm_oss_make_ready() at first, then takes the params_lock
mutex for the rest. When the stream is set up again by another thread
between them, it leads to inconsistency, and may result in unexpected
results such as NULL dereference of OSS buffer as a fuzzer spotted
recently.
The fix is simply to cover snd_pcm_oss_make_ready() call into the same
params_lock mutex with snd_pcm_oss_make_ready_locked() variant.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 sound/core/oss/pcm_oss.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 728c211142d1..f6340a2fe52b 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2083,21 +2083,15 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss_file *pcm_oss_file, int tr
 	psubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	csubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
 
-	if (psubstream) {
-		err = snd_pcm_oss_make_ready(psubstream);
-		if (err < 0)
-			return err;
-	}
-	if (csubstream) {
-		err = snd_pcm_oss_make_ready(csubstream);
-		if (err < 0)
-			return err;
-	}
       	if (psubstream) {
       		runtime = psubstream->runtime;
 		cmd = 0;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		err = snd_pcm_oss_make_ready_locked(psubstream);
+		if (err < 0)
+			mutex_unlock(&runtime->oss.params_lock);
+			return err;
 		if (trigger & PCM_ENABLE_OUTPUT) {
 			if (runtime->oss.trigger)
 				goto _skip1;
@@ -2128,6 +2122,10 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss_file *pcm_oss_file, int tr
 		cmd = 0;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		err = snd_pcm_oss_make_ready_locked(csubstream);
+		if (err < 0)
+			mutex_unlock(&runtime->oss.params_lock);
+			return err;
 		if (trigger & PCM_ENABLE_INPUT) {
 			if (runtime->oss.trigger)
 				goto _skip2;
-- 
2.37.2

