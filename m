Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B77BC47404
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:13:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD55C2064A
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o4BYshoY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Kq8sK4B5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CmvpkFcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD55C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C62C10E;
	Mon,  7 Oct 2019 13:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C62C10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570446824;
	bh=4aSRgvS8V/luZ/zTENpUbonh1dmnwv7jjpk/WOR7H3o=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o4BYshoYZUd+5Fx9cDl8vaORDshdyVP5+Yw9pInvPUVd5P/e66Eei8pDRxf2QFmdT
	 QRQGbRLzl6WX/hxb4daDE/wKs+H73CF8kA5yMfl2ggQ0w9G1njiAeL8Br+O0q1mQqe
	 twdocjOsRrWqsx2jnFSdb1i022/Vh/e4xOgwsDuo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3994EF8067C;
	Mon,  7 Oct 2019 13:06:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CC76F80659; Mon,  7 Oct 2019 13:05:56 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2B01F80634
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 13:05:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2B01F80634
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Kq8sK4B5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="CmvpkFcH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id D8BD62134B;
 Mon,  7 Oct 2019 07:05:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 07 Oct 2019 07:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=WWIvukujK0B6y
 6gKhB4SQl5wnnhYHuiNgnMSqolKyzs=; b=Kq8sK4B5PEsM6Mh6mXu8pw/nC3x7z
 6x8mWRscFWMPOfGF9t2ml2/7BVxjKsxQjlxvoX2D56gDD/IjQcH1l/t475GIRN6q
 jXCvUS6q3lXh8nm8C51TxDCkQlpgvUkeqfoJjigsQHEJ82poWO4cpbtMeikTzeX6
 OST2fPHlvOb4ANxQT5MFSwLWYGryRyTyh+sXkhu0CqYFh45FRXlrEaDq8lmFMHnL
 1aNYzSbRWbx5erSuNQKC3GMFOgBuTn7k6oalT3rQC8wHXreubV1Rtuu4q49aELsN
 O+rPdK0ttxk1zZug3VRFza/PMkFSqCbW97t8ofO8D5xNMl3zqpASRMDyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=WWIvukujK0B6y6gKhB4SQl5wnnhYHuiNgnMSqolKyzs=; b=CmvpkFcH
 hxJ6Lcl2DH8Am1V4CtRKy57RQGGnRy2dZpcJm0VH69zeeta7XOvJqN/Ige6pGS90
 viU+7+xxrhXnoyP8HTWjusfCjl5ByaeLLM7+4MEw8PL+FSSW8UzJ7+0AKhohFxlo
 Ic6sYyvg4J+4hUjDGtX/r8MQ+OgR02nIqQiPvYrvSiyzVKV4/LUjZSHx+gH6lXzh
 eG8D3epwSyiTlnudeDwUuM0PryFomyiFU6hLq7SCtNxbCM2PM6EcgpImP2qXnFy1
 28npbscmhZQkPobdozteiOfpMAG/VH9G93oETX0k3sNYpteUU3o2sinj6BTUwX1+
 Fh8xSHjRpPKp1w==
X-ME-Sender: <xms:DxybXQg7JnuyZrWw67RqVvt1kQxy_W4Tk2cFIOOqya-HF4ZEorG72g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheejgddviecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:DxybXeZlm6uPUV-l8REBSGp0gyxSaO2et905jml_8VXAKGwM_Hj7pw>
 <xmx:DxybXYTt6y2B-gl0OH-xVsJvyxqZJTZP-ruWBnhwY_V_Qfu1yoe4Qw>
 <xmx:DxybXRRMm5WDYi_SmePi2ciqwKk9Q83fYG1YNA4TAKaBgCXqZIKNGg>
 <xmx:DxybXWbucpluIhw8jHhSXo6GDQps8eViLABBVs0xv3pUpEnARVaQGA>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6FB458005A;
 Mon,  7 Oct 2019 07:05:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Mon,  7 Oct 2019 20:05:25 +0900
Message-Id: <20191007110532.30270-11-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007110532.30270-1-o-takashi@sakamocchi.jp>
References: <20191007110532.30270-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 10/17] bebob: use the same size of period for
	PCM substream in AMDTP streams
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In current implementation, when opening a PCM substream, it's needed to
check whether the opposite PCM substream runs. This is to assign
effectual constraints (e.g. sampling rate) to opened PCM substream.

The number of PCM substreams and MIDI substreams on AMDTP streams in
domain is recorded in own structure. Usage of this count is an
alternative of the above check. This is better because the count is
incremented in pcm.hw_params earlier than pcm.trigger.

This idea has one issue because it's incremented for MIDI substreams as
well. In current implementation, for a case that any MIDI substream run
and a PCM substream is going to start, PCM application to start the PCM
substream can decide hardware parameters by restart packet streaming.
Just checking the substream count can brings regression.

Now AMDTP domain structure has a member for the size of PCM period in
PCM substream which starts AMDTP streams in domain. When the value has
zero and the substream count is greater than 1, it means that any MIDI
substream starts AMDTP streams in domain. Usage of the value can resolve
the above issue.

This commit replaces the check with the substream count and the value for
the size of PCM period.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_pcm.c | 39 ++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 3b2227abf8a9..516c9874f4a1 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -129,18 +129,17 @@ pcm_init_hw_params(struct snd_bebob *bebob,
 	return err;
 }
 
-static int
-pcm_open(struct snd_pcm_substream *substream)
+static int pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
 	const struct snd_bebob_rate_spec *spec = bebob->spec->rate;
-	unsigned int sampling_rate;
+	struct amdtp_domain *d = &bebob->domain;
 	enum snd_bebob_clock_type src;
 	int err;
 
 	err = snd_bebob_stream_lock_try(bebob);
 	if (err < 0)
-		goto end;
+		return err;
 
 	err = pcm_init_hw_params(bebob, substream);
 	if (err < 0)
@@ -150,15 +149,19 @@ pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto err_locked;
 
-	/*
-	 * When source of clock is internal or any PCM stream are running,
-	 * the available sampling rate is limited at current sampling rate.
-	 */
+	mutex_lock(&bebob->mutex);
+
+	// When source of clock is not internal or any stream is reserved for
+	// transmission of PCM frames, the available sampling rate is limited
+	// at current one.
 	if (src == SND_BEBOB_CLOCK_TYPE_EXTERNAL ||
-	    amdtp_stream_pcm_running(&bebob->tx_stream) ||
-	    amdtp_stream_pcm_running(&bebob->rx_stream)) {
+	    (bebob->substreams_counter > 0 && d->events_per_period > 0)) {
+		unsigned int frames_per_period = d->events_per_period;
+		unsigned int sampling_rate;
+
 		err = spec->get(bebob, &sampling_rate);
 		if (err < 0) {
+			mutex_unlock(&bebob->mutex);
 			dev_err(&bebob->unit->device,
 				"fail to get sampling rate: %d\n", err);
 			goto err_locked;
@@ -166,11 +169,23 @@ pcm_open(struct snd_pcm_substream *substream)
 
 		substream->runtime->hw.rate_min = sampling_rate;
 		substream->runtime->hw.rate_max = sampling_rate;
+
+		if (frames_per_period > 0) {
+			err = snd_pcm_hw_constraint_minmax(substream->runtime,
+					SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					frames_per_period, frames_per_period);
+			if (err < 0) {
+				mutex_unlock(&bebob->mutex);
+				goto err_locked;
+			}
+		}
 	}
 
+	mutex_unlock(&bebob->mutex);
+
 	snd_pcm_set_sync(substream);
-end:
-	return err;
+
+	return 0;
 err_locked:
 	snd_bebob_stream_lock_release(bebob);
 	return err;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
