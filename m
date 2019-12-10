Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A43C2D0BF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:19:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4749520726
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZqcNlu9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4749520726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 452B71672;
	Tue, 10 Dec 2019 07:18:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 452B71672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958751;
	bh=PvV9pDCeSDVAsWJ/YG8b53yhFZAdZ1CdXXukMPHJgd8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqcNlu9DupWA5/LTiOPwvZRFte2nRNSqVOeDEupWhSFoaPOooaHUvS627XX1kvYAL
	 xeM8A7c2vutnikHnd0G7ccENvxhzrTTeExgThSvVfkgma4iWvwI2pDTTkmUe0lIGEs
	 cmvjK4DelW7UF752dITT6WjGdjek8o7wbhLVazvY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66079F802C2;
	Tue, 10 Dec 2019 07:12:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66752F8028B; Tue, 10 Dec 2019 07:12:30 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82BB7F80258
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82BB7F80258
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 07169B1E1
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:34 +0100
Message-Id: <20191210061145.24641-13-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 12/23] ALSA: atiixp: Drop superfluous ioctl PCM
	ops
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
 sound/pci/atiixp.c       | 3 ---
 sound/pci/atiixp_modem.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 6fb56952c9c7..977cdaf92f53 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1140,7 +1140,6 @@ static int snd_atiixp_spdif_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_atiixp_playback_ops = {
 	.open =		snd_atiixp_playback_open,
 	.close =	snd_atiixp_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_atiixp_pcm_hw_params,
 	.hw_free =	snd_atiixp_pcm_hw_free,
 	.prepare =	snd_atiixp_playback_prepare,
@@ -1152,7 +1151,6 @@ static const struct snd_pcm_ops snd_atiixp_playback_ops = {
 static const struct snd_pcm_ops snd_atiixp_capture_ops = {
 	.open =		snd_atiixp_capture_open,
 	.close =	snd_atiixp_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_atiixp_pcm_hw_params,
 	.hw_free =	snd_atiixp_pcm_hw_free,
 	.prepare =	snd_atiixp_capture_prepare,
@@ -1164,7 +1162,6 @@ static const struct snd_pcm_ops snd_atiixp_capture_ops = {
 static const struct snd_pcm_ops snd_atiixp_spdif_ops = {
 	.open =		snd_atiixp_spdif_open,
 	.close =	snd_atiixp_spdif_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_atiixp_pcm_hw_params,
 	.hw_free =	snd_atiixp_pcm_hw_free,
 	.prepare =	snd_atiixp_spdif_prepare,
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index dc40fdaa71cb..a27ce41f10d3 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -932,7 +932,6 @@ static int snd_atiixp_capture_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_atiixp_playback_ops = {
 	.open =		snd_atiixp_playback_open,
 	.close =	snd_atiixp_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_atiixp_pcm_hw_params,
 	.hw_free =	snd_atiixp_pcm_hw_free,
 	.prepare =	snd_atiixp_playback_prepare,
@@ -944,7 +943,6 @@ static const struct snd_pcm_ops snd_atiixp_playback_ops = {
 static const struct snd_pcm_ops snd_atiixp_capture_ops = {
 	.open =		snd_atiixp_capture_open,
 	.close =	snd_atiixp_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_atiixp_pcm_hw_params,
 	.hw_free =	snd_atiixp_pcm_hw_free,
 	.prepare =	snd_atiixp_capture_prepare,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
