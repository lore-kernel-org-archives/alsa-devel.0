Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B89C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:17:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7E5206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rw+l8sRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7E5206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C9A81614;
	Tue, 10 Dec 2019 07:16:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C9A81614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575958636;
	bh=g2+0zYVkcuziYoTa2Ri2Asa28I3ezkM74Aj7hLFXx/w=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rw+l8sRgUk8vvA001drTTvL5w4SF72qcMK8cUpjAiSebb3LcuVanq/Mc644mwAX9L
	 EKEhaietLCxbrbHWc6EQNuyKEeb6iZnfWL6KZuYFXsdDWoBI37E1rec3grvLbzz3qa
	 KdlHGTcxzIsGOFRzshri7FGHT2APGbKsvcWoqrT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09AF6F80292;
	Tue, 10 Dec 2019 07:12:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31D5AF8027D; Tue, 10 Dec 2019 07:12:26 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED70DF80252
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:11:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED70DF80252
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BA138B1D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:11:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:11:29 +0100
Message-Id: <20191210061145.24641-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210061145.24641-1-tiwai@suse.de>
References: <20191210061145.24641-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 07/23] ALSA: isa: Drop superfluous ioctl PCM ops
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
 sound/isa/ad1816a/ad1816a_lib.c | 2 --
 sound/isa/es18xx.c              | 2 --
 sound/isa/gus/gus_pcm.c         | 2 --
 sound/isa/msnd/msnd.c           | 2 --
 sound/isa/sb/emu8000_pcm.c      | 1 -
 sound/isa/sb/sb16_main.c        | 2 --
 sound/isa/sb/sb8_main.c         | 2 --
 sound/isa/wss/wss_lib.c         | 2 --
 8 files changed, 15 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index adc35051c5e9..b9d340c752b4 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -633,7 +633,6 @@ int snd_ad1816a_create(struct snd_card *card,
 static const struct snd_pcm_ops snd_ad1816a_playback_ops = {
 	.open =		snd_ad1816a_playback_open,
 	.close =	snd_ad1816a_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	snd_ad1816a_playback_prepare,
 	.trigger =	snd_ad1816a_playback_trigger,
 	.pointer =	snd_ad1816a_playback_pointer,
@@ -642,7 +641,6 @@ static const struct snd_pcm_ops snd_ad1816a_playback_ops = {
 static const struct snd_pcm_ops snd_ad1816a_capture_ops = {
 	.open =		snd_ad1816a_capture_open,
 	.close =	snd_ad1816a_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	snd_ad1816a_capture_prepare,
 	.trigger =	snd_ad1816a_capture_trigger,
 	.pointer =	snd_ad1816a_capture_pointer,
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 1346447ffe01..87a0a33807e7 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1643,7 +1643,6 @@ static int snd_es18xx_probe(struct snd_es18xx *chip,
 static const struct snd_pcm_ops snd_es18xx_playback_ops = {
 	.open =		snd_es18xx_playback_open,
 	.close =	snd_es18xx_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_es18xx_playback_hw_params,
 	.prepare =	snd_es18xx_playback_prepare,
 	.trigger =	snd_es18xx_playback_trigger,
@@ -1653,7 +1652,6 @@ static const struct snd_pcm_ops snd_es18xx_playback_ops = {
 static const struct snd_pcm_ops snd_es18xx_capture_ops = {
 	.open =		snd_es18xx_capture_open,
 	.close =	snd_es18xx_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_es18xx_capture_hw_params,
 	.prepare =	snd_es18xx_capture_prepare,
 	.trigger =	snd_es18xx_capture_trigger,
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index bd3a54bc4a94..aca4ab90e5bc 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -821,7 +821,6 @@ static const struct snd_kcontrol_new snd_gf1_pcm_volume_control1 =
 static const struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
 	.open =		snd_gf1_pcm_playback_open,
 	.close =	snd_gf1_pcm_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_gf1_pcm_playback_hw_params,
 	.hw_free =	snd_gf1_pcm_playback_hw_free,
 	.prepare =	snd_gf1_pcm_playback_prepare,
@@ -835,7 +834,6 @@ static const struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
 static const struct snd_pcm_ops snd_gf1_pcm_capture_ops = {
 	.open =		snd_gf1_pcm_capture_open,
 	.close =	snd_gf1_pcm_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_gf1_pcm_capture_hw_params,
 	.prepare =	snd_gf1_pcm_capture_prepare,
 	.trigger =	snd_gf1_pcm_capture_trigger,
diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
index 82d071492201..4fbc22a5bc5a 100644
--- a/sound/isa/msnd/msnd.c
+++ b/sound/isa/msnd/msnd.c
@@ -562,7 +562,6 @@ snd_msnd_playback_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_msnd_playback_ops = {
 	.open =		snd_msnd_playback_open,
 	.close =	snd_msnd_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_msnd_playback_hw_params,
 	.prepare =	snd_msnd_playback_prepare,
 	.trigger =	snd_msnd_playback_trigger,
@@ -659,7 +658,6 @@ static int snd_msnd_capture_hw_params(struct snd_pcm_substream *substream,
 static const struct snd_pcm_ops snd_msnd_capture_ops = {
 	.open =		snd_msnd_capture_open,
 	.close =	snd_msnd_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_msnd_capture_hw_params,
 	.prepare =	snd_msnd_capture_prepare,
 	.trigger =	snd_msnd_capture_trigger,
diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 83b7ff5e9880..e377ac93f37f 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -660,7 +660,6 @@ static snd_pcm_uframes_t emu8k_pcm_pointer(struct snd_pcm_substream *subs)
 static const struct snd_pcm_ops emu8k_pcm_ops = {
 	.open =		emu8k_pcm_open,
 	.close =	emu8k_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	emu8k_pcm_hw_params,
 	.hw_free =	emu8k_pcm_hw_free,
 	.prepare =	emu8k_pcm_prepare,
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 07ebf2c49443..38dc1fde25f3 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -817,7 +817,6 @@ int snd_sb16dsp_configure(struct snd_sb * chip)
 static const struct snd_pcm_ops snd_sb16_playback_ops = {
 	.open =		snd_sb16_playback_open,
 	.close =	snd_sb16_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	snd_sb16_playback_prepare,
 	.trigger =	snd_sb16_playback_trigger,
 	.pointer =	snd_sb16_playback_pointer,
@@ -826,7 +825,6 @@ static const struct snd_pcm_ops snd_sb16_playback_ops = {
 static const struct snd_pcm_ops snd_sb16_capture_ops = {
 	.open =		snd_sb16_capture_open,
 	.close =	snd_sb16_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.prepare =	snd_sb16_capture_prepare,
 	.trigger =	snd_sb16_capture_trigger,
 	.pointer =	snd_sb16_capture_pointer,
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 5804fa523600..e33dfe165276 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -546,7 +546,6 @@ static int snd_sb8_close(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_sb8_playback_ops = {
 	.open =			snd_sb8_open,
 	.close =		snd_sb8_close,
-	.ioctl =		snd_pcm_lib_ioctl,
 	.prepare =		snd_sb8_playback_prepare,
 	.trigger =		snd_sb8_playback_trigger,
 	.pointer =		snd_sb8_playback_pointer,
@@ -555,7 +554,6 @@ static const struct snd_pcm_ops snd_sb8_playback_ops = {
 static const struct snd_pcm_ops snd_sb8_capture_ops = {
 	.open =			snd_sb8_open,
 	.close =		snd_sb8_close,
-	.ioctl =		snd_pcm_lib_ioctl,
 	.prepare =		snd_sb8_capture_prepare,
 	.trigger =		snd_sb8_capture_trigger,
 	.pointer =		snd_sb8_capture_pointer,
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 0ef89c97ccd2..9114e8911712 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1871,7 +1871,6 @@ EXPORT_SYMBOL(snd_wss_create);
 static const struct snd_pcm_ops snd_wss_playback_ops = {
 	.open =		snd_wss_playback_open,
 	.close =	snd_wss_playback_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_wss_playback_hw_params,
 	.prepare =	snd_wss_playback_prepare,
 	.trigger =	snd_wss_trigger,
@@ -1881,7 +1880,6 @@ static const struct snd_pcm_ops snd_wss_playback_ops = {
 static const struct snd_pcm_ops snd_wss_capture_ops = {
 	.open =		snd_wss_capture_open,
 	.close =	snd_wss_capture_close,
-	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_wss_capture_hw_params,
 	.prepare =	snd_wss_capture_prepare,
 	.trigger =	snd_wss_trigger,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
