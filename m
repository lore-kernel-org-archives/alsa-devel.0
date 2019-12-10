Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36FAC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:23:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF1120663
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hNDZiBle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF1120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7A981694;
	Tue, 10 Dec 2019 07:22:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7A981694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958997;
	bh=sTx7k3wkTBNnZQitTb9XbEXrXkNgoBOL8kGbWecjKm0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNDZiBleHea0mKIftEtwtr/ehdmxU+KaEc9GTMXQUeXythpToFIxqpkLf56uiOKaJ
	 EO/5pKW5mxKnqNrMqb7MaOW71sG6SWW0g4PRxKQdl0AUaNcPRxYr/oOO9wjqWwXXy4
	 F3IgXYQ7pjvTaYootHKwJz/u38ETM9mpFxtB+XQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FC7AF80306;
	Tue, 10 Dec 2019 07:13:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EEA5F802BC; Tue, 10 Dec 2019 07:12:47 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECA87F8025A
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECA87F8025A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 22023B1E4
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:36 +0100
Message-Id: <20191210061145.24641-15-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 14/23] ALSA: trident: Drop superfluous ioctl
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

snd_trident_ioctl() does nothing but calling the default handler.
Now PCM core accepts NULL as the default ioctl ops, so let's drop
altogether.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/trident/trident_main.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 93789069e78f..0e02578c2b3d 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -767,29 +767,6 @@ static unsigned int snd_trident_control_mode(struct snd_pcm_substream *substream
  *  PCM part
  */
 
-/*---------------------------------------------------------------------------
-   snd_trident_ioctl
-  
-   Description: Device I/O control handler for playback/capture parameters.
-  
-   Parameters:   substream  - PCM substream class
-                cmd     - what ioctl message to process
-                arg     - additional message infoarg     
-  
-   Returns:     Error status
-  
-  ---------------------------------------------------------------------------*/
-
-static int snd_trident_ioctl(struct snd_pcm_substream *substream,
-			     unsigned int cmd,
-			     void *arg)
-{
-	/* FIXME: it seems that with small periods the behaviour of
-	          trident hardware is unpredictable and interrupt generator
-	          is broken */
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-
 /*---------------------------------------------------------------------------
    snd_trident_allocate_pcm_mem
   
@@ -2049,7 +2026,6 @@ static int snd_trident_foldback_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_trident_playback_ops = {
 	.open =		snd_trident_playback_open,
 	.close =	snd_trident_playback_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_playback_prepare,
@@ -2060,7 +2036,6 @@ static const struct snd_pcm_ops snd_trident_playback_ops = {
 static const struct snd_pcm_ops snd_trident_nx_playback_ops = {
 	.open =		snd_trident_playback_open,
 	.close =	snd_trident_playback_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_playback_prepare,
@@ -2071,7 +2046,6 @@ static const struct snd_pcm_ops snd_trident_nx_playback_ops = {
 static const struct snd_pcm_ops snd_trident_capture_ops = {
 	.open =		snd_trident_capture_open,
 	.close =	snd_trident_capture_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_capture_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_capture_prepare,
@@ -2082,7 +2056,6 @@ static const struct snd_pcm_ops snd_trident_capture_ops = {
 static const struct snd_pcm_ops snd_trident_si7018_capture_ops = {
 	.open =		snd_trident_capture_open,
 	.close =	snd_trident_capture_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_si7018_capture_hw_params,
 	.hw_free =	snd_trident_si7018_capture_hw_free,
 	.prepare =	snd_trident_si7018_capture_prepare,
@@ -2093,7 +2066,6 @@ static const struct snd_pcm_ops snd_trident_si7018_capture_ops = {
 static const struct snd_pcm_ops snd_trident_foldback_ops = {
 	.open =		snd_trident_foldback_open,
 	.close =	snd_trident_foldback_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_foldback_prepare,
@@ -2104,7 +2076,6 @@ static const struct snd_pcm_ops snd_trident_foldback_ops = {
 static const struct snd_pcm_ops snd_trident_nx_foldback_ops = {
 	.open =		snd_trident_foldback_open,
 	.close =	snd_trident_foldback_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_foldback_prepare,
@@ -2115,7 +2086,6 @@ static const struct snd_pcm_ops snd_trident_nx_foldback_ops = {
 static const struct snd_pcm_ops snd_trident_spdif_ops = {
 	.open =		snd_trident_spdif_open,
 	.close =	snd_trident_spdif_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_spdif_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_spdif_prepare,
@@ -2126,7 +2096,6 @@ static const struct snd_pcm_ops snd_trident_spdif_ops = {
 static const struct snd_pcm_ops snd_trident_spdif_7018_ops = {
 	.open =		snd_trident_spdif_open,
 	.close =	snd_trident_spdif_close,
-	.ioctl =	snd_trident_ioctl,
 	.hw_params =	snd_trident_spdif_hw_params,
 	.hw_free =	snd_trident_hw_free,
 	.prepare =	snd_trident_spdif_prepare,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
