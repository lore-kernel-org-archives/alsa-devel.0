Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138EDC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 14:23:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E12161056
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 14:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E12161056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21F5B112;
	Wed,  6 Oct 2021 16:22:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21F5B112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633530195;
	bh=TcLockZDsiZfUvRI7di06OiBWPwxydUHmhaXArRM6wo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QH0v7pdwj4hvUE75TSIGrlERxLB+6r6T0hE+J6LToWT3x7siTZyfiszav2TEEj/FY
	 Cch1pimgp4vHS00REhXQXjA7NZw+urlmJ9VDzk9oFt/FGQ/bnT4UdhorOdzCZS0Rb8
	 NG2TJ+a3j9PqIUqd9n8X/LFxUyho7hs4FGzRRTY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7AAFF80229;
	Wed,  6 Oct 2021 16:22:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E2C6F80240; Wed,  6 Oct 2021 16:22:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4657CF800FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 16:22:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4657CF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="E2tD0mWl"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="fqx5IFkX"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7346F20381
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633530135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xXxwFenG/k8cWETpOyg7be8nPd54vJIBdFHX7OE5JHU=;
 b=E2tD0mWlhsoZlqikY87LH2anAz5JlOGTpVrs95sIn7yvu8krs7L9IYbKlm0fhmuxRSf996
 fMoMRE2OZOwPBmSX48ky7JEBrfmS30DX6+vc4GDscdVVx6CrL4DOVVcUEB8WQxUBG/wzur
 jJynSJBP4rK6GUHLEhmxLBdE0BbQvX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633530135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xXxwFenG/k8cWETpOyg7be8nPd54vJIBdFHX7OE5JHU=;
 b=fqx5IFkX/uvhYt7z1WzdXZspWkP3ycuk/Jnr1JXTRLarSKSDW1UaAzFW2nPpSpmZwIlM10
 LW86LBXIi8q1UOBA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 624ACA3BDB;
 Wed,  6 Oct 2021 14:22:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: Add more disconnection checks at file ops
Date: Wed,  6 Oct 2021 16:22:14 +0200
Message-Id: <20211006142214.3089-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In the case of hot-disconnection of a PCM device, all file operations
except for close should be rejected.  This patch adds more sanity
checks in the file operation code paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ee6d17caf2ce..0c0a825af773 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3234,6 +3234,9 @@ static int snd_pcm_common_ioctl(struct file *file,
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+		return -EBADFD;
+
 	res = snd_power_wait(substream->pcm->card);
 	if (res < 0)
 		return res;
@@ -3360,6 +3363,9 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 	snd_pcm_uframes_t *frames = arg;
 	snd_pcm_sframes_t result;
 	
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+		return -EBADFD;
+
 	switch (cmd) {
 	case SNDRV_PCM_IOCTL_FORWARD:
 	{
@@ -3402,7 +3408,8 @@ static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count,
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!frame_aligned(runtime, count))
 		return -EINVAL;
@@ -3426,7 +3433,8 @@ static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!frame_aligned(runtime, count))
 		return -EINVAL;
@@ -3452,7 +3460,8 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!iter_is_iovec(to))
 		return -EINVAL;
@@ -3488,7 +3497,8 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!iter_is_iovec(from))
 		return -EINVAL;
@@ -3527,6 +3537,9 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
 		return ok | EPOLLERR;
 
 	runtime = substream->runtime;
+	if (runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+		return ok | EPOLLERR;
+
 	poll_wait(file, &runtime->sleep, wait);
 
 	mask = 0;
@@ -3836,6 +3849,8 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+		return -EBADFD;
 
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
@@ -3872,6 +3887,8 @@ static int snd_pcm_fasync(int fd, struct file * file, int on)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
+	if (runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+		return -EBADFD;
 	return fasync_helper(fd, file, on, &runtime->fasync);
 }
 
-- 
2.31.1

