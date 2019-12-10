Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B5C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:19:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B489B206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NQsgNIgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B489B206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0721B167A;
	Tue, 10 Dec 2019 07:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0721B167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958792;
	bh=WTmQj4mpTihUYKVEzUmJwB86kUKiZkfAjqw9LBKwKz4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NQsgNIguv/7R32swjXyUfQUDSPyYfmKhA0p55Ge/lo44XOpQhibzcdKtuixe6ATah
	 iwHHr4RFRd0oRx84Im6xoJedg3/HO2Y1iQ+aIY2LI3l3xVb2utBiNsazEczfPkMzes
	 Bv1ZOWWJGfhePh9/uXQqF+tRQPdsVFDp6A1DCi6w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A3FFF8025E;
	Tue, 10 Dec 2019 07:13:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFAAFF80249; Tue, 10 Dec 2019 07:12:30 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B0E6F80249
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B0E6F80249
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E00FCB1DD
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:32 +0100
Message-Id: <20191210061145.24641-11-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 10/23] ALSA: intel8x0: Drop superfluous ioctl
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
 sound/pci/intel8x0.c  | 12 ------------
 sound/pci/intel8x0m.c |  2 --
 2 files changed, 14 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index b171816e58a8..2a3551deee74 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1311,7 +1311,6 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_intel8x0_playback_ops = {
 	.open =		snd_intel8x0_playback_open,
 	.close =	snd_intel8x0_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1322,7 +1321,6 @@ static const struct snd_pcm_ops snd_intel8x0_playback_ops = {
 static const struct snd_pcm_ops snd_intel8x0_capture_ops = {
 	.open =		snd_intel8x0_capture_open,
 	.close =	snd_intel8x0_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1333,7 +1331,6 @@ static const struct snd_pcm_ops snd_intel8x0_capture_ops = {
 static const struct snd_pcm_ops snd_intel8x0_capture_mic_ops = {
 	.open =		snd_intel8x0_mic_open,
 	.close =	snd_intel8x0_mic_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1344,7 +1341,6 @@ static const struct snd_pcm_ops snd_intel8x0_capture_mic_ops = {
 static const struct snd_pcm_ops snd_intel8x0_capture_mic2_ops = {
 	.open =		snd_intel8x0_mic2_open,
 	.close =	snd_intel8x0_mic2_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1355,7 +1351,6 @@ static const struct snd_pcm_ops snd_intel8x0_capture_mic2_ops = {
 static const struct snd_pcm_ops snd_intel8x0_capture2_ops = {
 	.open =		snd_intel8x0_capture2_open,
 	.close =	snd_intel8x0_capture2_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1366,7 +1361,6 @@ static const struct snd_pcm_ops snd_intel8x0_capture2_ops = {
 static const struct snd_pcm_ops snd_intel8x0_spdif_ops = {
 	.open =		snd_intel8x0_spdif_open,
 	.close =	snd_intel8x0_spdif_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1377,7 +1371,6 @@ static const struct snd_pcm_ops snd_intel8x0_spdif_ops = {
 static const struct snd_pcm_ops snd_intel8x0_ali_playback_ops = {
 	.open =		snd_intel8x0_playback_open,
 	.close =	snd_intel8x0_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1388,7 +1381,6 @@ static const struct snd_pcm_ops snd_intel8x0_ali_playback_ops = {
 static const struct snd_pcm_ops snd_intel8x0_ali_capture_ops = {
 	.open =		snd_intel8x0_capture_open,
 	.close =	snd_intel8x0_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1399,7 +1391,6 @@ static const struct snd_pcm_ops snd_intel8x0_ali_capture_ops = {
 static const struct snd_pcm_ops snd_intel8x0_ali_capture_mic_ops = {
 	.open =		snd_intel8x0_mic_open,
 	.close =	snd_intel8x0_mic_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1410,7 +1401,6 @@ static const struct snd_pcm_ops snd_intel8x0_ali_capture_mic_ops = {
 static const struct snd_pcm_ops snd_intel8x0_ali_ac97spdifout_ops = {
 	.open =		snd_intel8x0_ali_ac97spdifout_open,
 	.close =	snd_intel8x0_ali_ac97spdifout_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1422,7 +1412,6 @@ static const struct snd_pcm_ops snd_intel8x0_ali_ac97spdifout_ops = {
 static struct snd_pcm_ops snd_intel8x0_ali_spdifin_ops = {
 	.open =		snd_intel8x0_ali_spdifin_open,
 	.close =	snd_intel8x0_ali_spdifin_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
@@ -1433,7 +1422,6 @@ static struct snd_pcm_ops snd_intel8x0_ali_spdifin_ops = {
 static struct snd_pcm_ops snd_intel8x0_ali_spdifout_ops = {
 	.open =		snd_intel8x0_ali_spdifout_open,
 	.close =	snd_intel8x0_ali_spdifout_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_intel8x0_hw_params,
 	.hw_free =	snd_intel8x0_hw_free,
 	.prepare =	snd_intel8x0_pcm_prepare,
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 897c989bedd1..13dd3d873e95 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -662,7 +662,6 @@ static int snd_intel8x0m_capture_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_intel8x0m_playback_ops = {
 	.open =		snd_intel8x0m_playback_open,
 	.close =	snd_intel8x0m_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	snd_intel8x0m_pcm_prepare,
 	.trigger =	snd_intel8x0m_pcm_trigger,
 	.pointer =	snd_intel8x0m_pcm_pointer,
@@ -671,7 +670,6 @@ static const struct snd_pcm_ops snd_intel8x0m_playback_ops = {
 static const struct snd_pcm_ops snd_intel8x0m_capture_ops = {
 	.open =		snd_intel8x0m_capture_open,
 	.close =	snd_intel8x0m_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	snd_intel8x0m_pcm_prepare,
 	.trigger =	snd_intel8x0m_pcm_trigger,
 	.pointer =	snd_intel8x0m_pcm_pointer,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
