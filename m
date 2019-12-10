Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66545C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:27:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF5A20637
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BFcj0hTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF5A20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23032167C;
	Tue, 10 Dec 2019 07:27:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23032167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575959277;
	bh=E6ihk6jW5VUgrGqs0puvQW72fSdgIrR3Wsz51qBf9V4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFcj0hThEsJYZa0xITuC7/ve+ZBYdbkFaSDzyiSCao+XTqSK8OZq2X7nMyfOBZQQF
	 Qk++3EBNY/VaSxhNO7eQPbMSXcAAPLgMR0sIym3IrWxt7ospOxLotC7jMqJ11ys4tv
	 4LWbmOSf0eccRgBoHPnrz9zJWJczbV7KRMrdBza8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21519F80351;
	Tue, 10 Dec 2019 07:13:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4167CF802E9; Tue, 10 Dec 2019 07:13:14 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4355EF8026A
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4355EF8026A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7B0B9B2F4
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:43 +0100
Message-Id: <20191210061145.24641-22-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 21/23] ALSA: usb: Drop superfluous ioctl PCM ops
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

PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/6fire/pcm.c           | 1 -
 sound/usb/caiaq/audio.c         | 1 -
 sound/usb/hiface/pcm.c          | 1 -
 sound/usb/line6/capture.c       | 1 -
 sound/usb/line6/playback.c      | 1 -
 sound/usb/misc/ua101.c          | 2 --
 sound/usb/pcm.c                 | 2 --
 sound/usb/usx2y/usbusx2yaudio.c | 1 -
 sound/usb/usx2y/usx2yhwdeppcm.c | 1 -
 9 files changed, 11 deletions(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 706aa3fac351..7168f1c6a37a 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -542,7 +542,6 @@ static snd_pcm_uframes_t usb6fire_pcm_pointer(
 static const struct snd_pcm_ops pcm_ops = {
 	.open = usb6fire_pcm_open,
 	.close = usb6fire_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = usb6fire_pcm_prepare,
 	.trigger = usb6fire_pcm_trigger,
 	.pointer = usb6fire_pcm_pointer,
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 8513b120e57e..72212153cb1f 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -321,7 +321,6 @@ snd_usb_caiaq_pcm_pointer(struct snd_pcm_substream *sub)
 static const struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.open =		snd_usb_caiaq_substream_open,
 	.close =	snd_usb_caiaq_substream_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_free =	snd_usb_caiaq_pcm_hw_free,
 	.prepare =	snd_usb_caiaq_pcm_prepare,
 	.trigger =	snd_usb_caiaq_pcm_trigger,
diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index cc0639a1b419..a148caa5f48e 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -500,7 +500,6 @@ static snd_pcm_uframes_t hiface_pcm_pointer(struct snd_pcm_substream *alsa_sub)
 static const struct snd_pcm_ops pcm_ops = {
 	.open = hiface_pcm_open,
 	.close = hiface_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = hiface_pcm_prepare,
 	.trigger = hiface_pcm_trigger,
 	.pointer = hiface_pcm_pointer,
diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 82abef3fe90d..663d608c4287 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -247,7 +247,6 @@ static int snd_line6_capture_close(struct snd_pcm_substream *substream)
 const struct snd_pcm_ops snd_line6_capture_ops = {
 	.open = snd_line6_capture_open,
 	.close = snd_line6_capture_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = snd_line6_hw_params,
 	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 2e8ead3f9bc2..01930ce7bd75 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -392,7 +392,6 @@ static int snd_line6_playback_close(struct snd_pcm_substream *substream)
 const struct snd_pcm_ops snd_line6_playback_ops = {
 	.open = snd_line6_playback_open,
 	.close = snd_line6_playback_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = snd_line6_hw_params,
 	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index a7b68447f3ad..884e740a785c 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -870,7 +870,6 @@ static snd_pcm_uframes_t playback_pcm_pointer(struct snd_pcm_substream *subs)
 static const struct snd_pcm_ops capture_pcm_ops = {
 	.open = capture_pcm_open,
 	.close = capture_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = capture_pcm_hw_params,
 	.prepare = capture_pcm_prepare,
 	.trigger = capture_pcm_trigger,
@@ -880,7 +879,6 @@ static const struct snd_pcm_ops capture_pcm_ops = {
 static const struct snd_pcm_ops playback_pcm_ops = {
 	.open = playback_pcm_open,
 	.close = playback_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = playback_pcm_hw_params,
 	.prepare = playback_pcm_prepare,
 	.trigger = playback_pcm_trigger,
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 7caaa04ae546..33c1e971e61e 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1763,7 +1763,6 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 static const struct snd_pcm_ops snd_usb_playback_ops = {
 	.open =		snd_usb_pcm_open,
 	.close =	snd_usb_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_usb_hw_params,
 	.hw_free =	snd_usb_hw_free,
 	.prepare =	snd_usb_pcm_prepare,
@@ -1774,7 +1773,6 @@ static const struct snd_pcm_ops snd_usb_playback_ops = {
 static const struct snd_pcm_ops snd_usb_capture_ops = {
 	.open =		snd_usb_pcm_open,
 	.close =	snd_usb_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_usb_hw_params,
 	.hw_free =	snd_usb_hw_free,
 	.prepare =	snd_usb_pcm_prepare,
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 7eb9805a4326..8ac4ce0e8965 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -893,7 +893,6 @@ static const struct snd_pcm_ops snd_usX2Y_pcm_ops =
 {
 	.open =		snd_usX2Y_pcm_open,
 	.close =	snd_usX2Y_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_usX2Y_pcm_hw_params,
 	.hw_free =	snd_usX2Y_pcm_hw_free,
 	.prepare =	snd_usX2Y_pcm_prepare,
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 419d9f07d197..d8d91f2fb799 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -581,7 +581,6 @@ static const struct snd_pcm_ops snd_usX2Y_usbpcm_ops =
 {
 	.open =		snd_usX2Y_usbpcm_open,
 	.close =	snd_usX2Y_usbpcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_usX2Y_pcm_hw_params,
 	.hw_free =	snd_usX2Y_usbpcm_hw_free,
 	.prepare =	snd_usX2Y_usbpcm_prepare,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
