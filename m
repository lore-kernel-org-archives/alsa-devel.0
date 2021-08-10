Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E952C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 12:23:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0233861008
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 12:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0233861008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86A92850;
	Tue, 10 Aug 2021 14:22:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86A92850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628598183;
	bh=Tty/ZYYlJMWpX3y5EnF6lfUBr/bHDht3kpzrHrIOUes=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pr/YNzvwNX15TwSVf0O8g5zZFzhq+pT5gSXpsOkYEE3NXk+NvsB0Vo5QEO05LYt4H
	 cilyvUYH+J8EGc9S7IQ4G4Pdzx1gbgj7RD6KTMJtuN5nokVRN0zN0QtqAlpY6q+Wjo
	 Cr1vOnKG5kwJKPZxsCM/JtIsif9AUThD34rxyC24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87D07F80245;
	Tue, 10 Aug 2021 14:22:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84217F804CF; Tue, 10 Aug 2021 14:22:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3B6EF800FD
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 14:22:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3B6EF800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="KrUr+MnT"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="dWmdiOL2"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B51EC22057
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628598123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0FD5nrINFqCCoPx3+7o4pDTVtYbBzeVdUPOeiSDBhY=;
 b=KrUr+MnTWaqDvWsOeaLZB+VEhwolofLORTBV7M8U/gFEsbnN7HUXtIx6q7PHwV4GXJ/qQb
 aDt281/TpO2ivMfUZeyTJL1HqUiOdR6aEfy8jkKqqHXFAcw8U1YoEWxkaFzOjwAZvH/mnc
 it/O8ea2JVQYY0TqoCH/fwwkhsWoYbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628598123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0FD5nrINFqCCoPx3+7o4pDTVtYbBzeVdUPOeiSDBhY=;
 b=dWmdiOL2FDS4MzDX4wwG2GZITbyzpe95YdyL1k0nE81jSi2OkUmU10CDeeBQSHuYKQcRRZ
 TFMmQmu8trrijSAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A4A22A3B85;
 Tue, 10 Aug 2021 12:22:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH RFC 2/5] ALSA: pcm: Add SNDRV_PCM_INFO_EXPLICIT_SYNC flag
Date: Tue, 10 Aug 2021 14:21:57 +0200
Message-Id: <20210810122200.971-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210810122200.971-1-tiwai@suse.de>
References: <20210810122200.971-1-tiwai@suse.de>
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

ALSA PCM core has an optimized way to communicate with user-space for
its control and status data via mmap on the supported architectures
like x86.  Depending on the situation, however, we'd rather want to
enforce user-space notifying the applptr or hwptr change explicitly
via ioctl.  For example, the upcoming non-contig and non-coherent
buffer handling would need an explicit sync, and this needs to catch
the applptr and hwptr changes.

This patch adds the new PCM hardware info flag,
SNDRV_PCM_INFO_EXPLICIT_SYNC.  When this flag is set, PCM core
disables both the control and the status mmap, which enforces
user-space to update via SYNC_PTR ioctl.  In that way, drivers can
catch the applptr and hwptr update and apply the sync operation if
needed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h | 1 +
 sound/core/pcm_native.c     | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index d17c061950df..1d84ec9db93b 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -299,6 +299,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME     0x02000000  /* report absolute hardware link audio time, not reset on startup */
 #define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
 #define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
+#define SNDRV_PCM_INFO_EXPLICIT_SYNC	0x10000000	/* needs explicit sync of pointers and data */
 
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index dc9fa312fadd..d233cb3b41d8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3621,6 +3621,12 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 
 static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
 {
+	/* If drivers require the explicit sync (typically for non-coherent
+	 * pages), we have to disable the mmap of status and control data
+	 * to enforce the control via SYNC_PTR ioctl.
+	 */
+	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_EXPLICIT_SYNC)
+		return false;
 	/* See pcm_control_mmap_allowed() below.
 	 * Since older alsa-lib requires both status and control mmaps to be
 	 * coupled, we have to disable the status mmap for old alsa-lib, too.
@@ -3635,6 +3641,9 @@ static bool pcm_control_mmap_allowed(struct snd_pcm_file *pcm_file)
 {
 	if (pcm_file->no_compat_mmap)
 		return false;
+	/* see above */
+	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_EXPLICIT_SYNC)
+		return false;
 	/* Disallow the control mmap when SYNC_APPLPTR flag is set;
 	 * it enforces the user-space to fall back to snd_pcm_sync_ptr(),
 	 * thus it effectively assures the manual update of appl_ptr.
-- 
2.26.2

