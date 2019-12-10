Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3FAC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:13:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0428D206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OXmVLSbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0428D206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D57DE38;
	Tue, 10 Dec 2019 07:12:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D57DE38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958427;
	bh=hA4WdJGwRPExDmHOrNlEL8ODQxIXp9bVi8/KBjdFDuY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OXmVLSbNRUHpnhR4Qt+LBWuL5N+/VVadWCpp8Nhwz4gwWQzZRlrOOaGUMA9dhdHV/
	 efTGmfHMuyLC93XhkhCcxDlTDRxdOCfnWCiZ4B87lvhPwWA/YIbD0Gx+Nnfn/8dEZQ
	 J4f+3eFRFJVgHYVUrmLHrCn2QY4ImMpB5xReWp6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D7F2F80273;
	Tue, 10 Dec 2019 07:12:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2A76F80271; Tue, 10 Dec 2019 07:12:08 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92FE2F801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92FE2F801D8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9AE58B1D0
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:26 +0100
Message-Id: <20191210061145.24641-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 04/23] ALSA: drivers: Drop superfluous ioctl
	PCM ops
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
 sound/drivers/aloop.c         | 1 -
 sound/drivers/dummy.c         | 2 --
 sound/drivers/ml403-ac97cr.c  | 2 --
 sound/drivers/pcsp/pcsp_lib.c | 1 -
 sound/drivers/vx/vx_pcm.c     | 2 --
 5 files changed, 8 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 104fb738cf48..8090812dcecb 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1299,7 +1299,6 @@ static int loopback_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops loopback_pcm_ops = {
 	.open =		loopback_open,
 	.close =	loopback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_free =	loopback_hw_free,
 	.prepare =	loopback_prepare,
 	.trigger =	loopback_trigger,
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index ab6062dcd1b3..cef5b391cc44 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -647,7 +647,6 @@ static struct page *dummy_pcm_page(struct snd_pcm_substream *substream,
 static struct snd_pcm_ops dummy_pcm_ops = {
 	.open =		dummy_pcm_open,
 	.close =	dummy_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	dummy_pcm_hw_params,
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
@@ -657,7 +656,6 @@ static struct snd_pcm_ops dummy_pcm_ops = {
 static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.open =		dummy_pcm_open,
 	.close =	dummy_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	dummy_pcm_hw_params,
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index fad63783b4ae..d1e01d89c722 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -731,7 +731,6 @@ static int snd_ml403_ac97cr_capture_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_ml403_ac97cr_playback_ops = {
 	.open = snd_ml403_ac97cr_playback_open,
 	.close = snd_ml403_ac97cr_playback_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = snd_ml403_ac97cr_pcm_playback_prepare,
 	.trigger = snd_ml403_ac97cr_pcm_playback_trigger,
 	.pointer = snd_ml403_ac97cr_pcm_pointer,
@@ -740,7 +739,6 @@ static const struct snd_pcm_ops snd_ml403_ac97cr_playback_ops = {
 static const struct snd_pcm_ops snd_ml403_ac97cr_capture_ops = {
 	.open = snd_ml403_ac97cr_capture_open,
 	.close = snd_ml403_ac97cr_capture_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = snd_ml403_ac97cr_pcm_capture_prepare,
 	.trigger = snd_ml403_ac97cr_pcm_capture_trigger,
 	.pointer = snd_ml403_ac97cr_pcm_pointer,
diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 4fdc4dbdae57..05244b11ed5e 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -322,7 +322,6 @@ static int snd_pcsp_playback_open(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_pcsp_playback_ops = {
 	.open = snd_pcsp_playback_open,
 	.close = snd_pcsp_playback_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = snd_pcsp_playback_hw_params,
 	.hw_free = snd_pcsp_playback_hw_free,
 	.prepare = snd_pcsp_playback_prepare,
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 615e8b2b85f6..664b9efa9a50 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -843,7 +843,6 @@ static int vx_pcm_prepare(struct snd_pcm_substream *subs)
 static const struct snd_pcm_ops vx_pcm_playback_ops = {
 	.open =		vx_pcm_playback_open,
 	.close =	vx_pcm_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	vx_pcm_prepare,
 	.trigger =	vx_pcm_trigger,
 	.pointer =	vx_pcm_playback_pointer,
@@ -1061,7 +1060,6 @@ static snd_pcm_uframes_t vx_pcm_capture_pointer(struct snd_pcm_substream *subs)
 static const struct snd_pcm_ops vx_pcm_capture_ops = {
 	.open =		vx_pcm_capture_open,
 	.close =	vx_pcm_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	vx_pcm_prepare,
 	.trigger =	vx_pcm_trigger,
 	.pointer =	vx_pcm_capture_pointer,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
