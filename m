Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BAAC33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:51:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453DF21582
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qg5l2yl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453DF21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 984DE178F;
	Sun,  5 Jan 2020 15:51:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 984DE178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578235915;
	bh=824hMaRg9rPHv2yzVJiQMM2OvZ/pxX0wsgm/h1kWYBE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qg5l2yl8gVOl0Fiv6RoRrWCleijqDtIWMqYkwvlw/pJb3Ei0DvFVSe1F/naYlXFPa
	 Bm2Owj7KQmda6jyDNklU6trB3nYvVzrS2o+nqTi9aYsf/SW+HerntDiVCufOKHX1DI
	 H6SDNhXdOMEupfWs7FBdV6dHI5Ahd9ApNQBN/Wss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06928F80322;
	Sun,  5 Jan 2020 15:48:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2D40F80308; Sun,  5 Jan 2020 15:48:41 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEEF8F8010D
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEEF8F8010D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0874B15E
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:31 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:19 +0100
Message-Id: <20200105144823.29547-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 04/68] ALSA: dummy: More constifications
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

Apply const prefix to every possible place: mostly for declaring the
dummy hardware models.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 46fa60e7f722..da0bd8960b3c 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -117,7 +117,7 @@ struct dummy_model {
 
 struct snd_dummy {
 	struct snd_card *card;
-	struct dummy_model *model;
+	const struct dummy_model *model;
 	struct snd_pcm *pcm;
 	struct snd_pcm_hardware pcm_hw;
 	spinlock_t mixer_lock;
@@ -144,13 +144,13 @@ static int emu10k1_playback_constraints(struct snd_pcm_runtime *runtime)
 	return 0;
 }
 
-static struct dummy_model model_emu10k1 = {
+static const struct dummy_model model_emu10k1 = {
 	.name = "emu10k1",
 	.playback_constraints = emu10k1_playback_constraints,
 	.buffer_bytes_max = 128 * 1024,
 };
 
-static struct dummy_model model_rme9652 = {
+static const struct dummy_model model_rme9652 = {
 	.name = "rme9652",
 	.buffer_bytes_max = 26 * 64 * 1024,
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
@@ -160,7 +160,7 @@ static struct dummy_model model_rme9652 = {
 	.periods_max = 2,
 };
 
-static struct dummy_model model_ice1712 = {
+static const struct dummy_model model_ice1712 = {
 	.name = "ice1712",
 	.buffer_bytes_max = 256 * 1024,
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
@@ -170,7 +170,7 @@ static struct dummy_model model_ice1712 = {
 	.periods_max = 1024,
 };
 
-static struct dummy_model model_uda1341 = {
+static const struct dummy_model model_uda1341 = {
 	.name = "uda1341",
 	.buffer_bytes_max = 16380,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
@@ -180,7 +180,7 @@ static struct dummy_model model_uda1341 = {
 	.periods_max = 255,
 };
 
-static struct dummy_model model_ac97 = {
+static const struct dummy_model model_ac97 = {
 	.name = "ac97",
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.channels_min = 2,
@@ -190,7 +190,7 @@ static struct dummy_model model_ac97 = {
 	.rate_max = 48000,
 };
 
-static struct dummy_model model_ca0106 = {
+static const struct dummy_model model_ca0106 = {
 	.name = "ca0106",
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.buffer_bytes_max = ((65536-64)*8),
@@ -204,7 +204,7 @@ static struct dummy_model model_ca0106 = {
 	.rate_max = 192000,
 };
 
-static struct dummy_model *dummy_models[] = {
+static const struct dummy_model *dummy_models[] = {
 	&model_emu10k1,
 	&model_rme9652,
 	&model_ice1712,
@@ -535,7 +535,7 @@ static int dummy_pcm_hw_params(struct snd_pcm_substream *substream,
 static int dummy_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_dummy *dummy = snd_pcm_substream_chip(substream);
-	struct dummy_model *model = dummy->model;
+	const struct dummy_model *model = dummy->model;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	const struct dummy_timer_ops *ops;
 	int err;
@@ -912,7 +912,7 @@ static void print_formats(struct snd_dummy *dummy,
 static void print_rates(struct snd_dummy *dummy,
 			struct snd_info_buffer *buffer)
 {
-	static int rates[] = {
+	static const int rates[] = {
 		5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
 		64000, 88200, 96000, 176400, 192000,
 	};
@@ -944,7 +944,7 @@ struct dummy_hw_field {
 	.offset = offsetof(struct snd_pcm_hardware, item), \
 	.size = sizeof(dummy_pcm_hardware.item) }
 
-static struct dummy_hw_field fields[] = {
+static const struct dummy_hw_field fields[] = {
 	FIELD_ENTRY(formats, "%#llx"),
 	FIELD_ENTRY(rates, "%#x"),
 	FIELD_ENTRY(rate_min, "%d"),
@@ -1022,7 +1022,7 @@ static int snd_dummy_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
 	struct snd_dummy *dummy;
-	struct dummy_model *m = NULL, **mdl;
+	const struct dummy_model *m = NULL, **mdl;
 	int idx, err;
 	int dev = devptr->id;
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
