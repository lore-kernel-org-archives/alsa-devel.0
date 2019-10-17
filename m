Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E79ECE58E
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:00:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3D920872
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iuGCLimb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="piPP31gb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qRzSmsrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3D920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFACB16B3;
	Thu, 17 Oct 2019 17:59:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFACB16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571328044;
	bh=nmph+GpsU6hKA2nErvY4BjclM8V5MUCC/oB42Y40GrA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuGCLimbXC6xJJb4BMcgzu0VHDMpYq8YOHPqPuw+2yavZPQ2Xe9T4VASmY0Ism8ei
	 oDS+MsIf8GhgS02JIiYYyDJxRJpz2/q/rtgE3Uyq1WwqTW0L9Qu5CBcuGaJo5bgpWL
	 Noz85dvhKEMfZMLQ+I5GPf34hqyx0gNFjVitUo70=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A02FF80676;
	Thu, 17 Oct 2019 17:55:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77CF8F80600; Thu, 17 Oct 2019 17:54:48 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4F16F805F5
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 17:54:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4F16F805F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="piPP31gb"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="qRzSmsrN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id E750C508;
 Thu, 17 Oct 2019 11:54:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 17 Oct 2019 11:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=ygQx5o3stvy/W
 r8iKI7gPKibDzgeIdMJTpeeO4tXrX4=; b=piPP31gbUd5HlSsF3eOvexJ/XtfjW
 tjJYxq5zs6uCdkmTr+sJ9UEiyqxOCTfSUto3jHYZGWRE64Au7WLDkz8WUGrGTCzD
 fCbMUrq7U2LXWGBf1OaQ5Qm4JLrKj2Q+x31fH++GgGVVuCnFybITdnIvKiykhw22
 4NWBmQnKXERzIHZSMtCsD6sQiVqNdD0i6g/ZQdnPXxXooZi05B8T3fCufdcwJ1s6
 zZkWMEn6HDQd7lj86YsvoOak49P4i6kU5YVm0naHQh0kAAI1BBRlkdlNUeGsND28
 KGfmTPBs6HlysePDqx41apj1PlKEwDETKBO8m3LzQI03oxzt0HwPvCImA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ygQx5o3stvy/Wr8iKI7gPKibDzgeIdMJTpeeO4tXrX4=; b=qRzSmsrN
 Zl/Rdo0FDWtfyuP22m9emybCPLEmLTgo7nlD30OGKfmCZzPwq9NzCCwtt/LMq4Dy
 rf88JGlHJlHYN/MVOf2cnMcFi4MnDLmOC/vlUPyglRwXda9CwQY8ezkmB1FRHMmB
 a+N2Onu/jmCaKvIKWEdlkv0BgWqadJQwzC+8P5foVTA5QrIoiIbt/KnUZ873Ihsv
 l8wCoouJF9Bb2gauN7TMcd6zfcgZ5n5tUuv/15WDUfDBK42VRIXQmONjG8NELdKP
 VqtgvscxlhdpUwWkMq6Ih46nQpAlk+56GYPAL2RLFRxhzrVBYP+oMzBiLj54VSG8
 rygKEyPMskXBpg==
X-ME-Sender: <xms:wI6oXZErV3qyAijMrZr0vXgz5kEqhIQsbIp2bpA25TGrunGaQmZTPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdelgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:wI6oXVWTHLO3SbH1L4ktKSADw0fk4t2u6HBHPQVdnU1w2hlaPCWjoA>
 <xmx:wI6oXQInz-UIVKhaz-kLWKKTvkTjcUVrHOW1L5icamLzyyT-hTpkaA>
 <xmx:wI6oXd91N4EPVcaunKalyP3ceeMo5EgRfjXoeV5Umnphy3Sths3UVg>
 <xmx:wI6oXXW9-ua1n0dguQRiSvzvlAjOXdnI7464a6S2ZD94PBtzvnPJJQ>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 22A9180059;
 Thu, 17 Oct 2019 11:54:38 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Fri, 18 Oct 2019 00:54:19 +0900
Message-Id: <20191017155424.885-8-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017155424.885-1-o-takashi@sakamocchi.jp>
References: <20191017155424.885-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 07/12] ALSA: firewire-tascam: share PCM buffer
	size for both direction
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

This commit allows ALSA firewire-tascam driver to share PCM buffer
size for both capture and playback PCM substream. When AMDTP domain
starts for one of the PCM substream, buffer size of the PCM substream
is stores to AMDTP domain structure. Some AMDTP streams have already
run with the buffer size when another PCM substream starts, therefore
the PCM substream has a constraint to its buffer size.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-pcm.c    | 12 +++++++++++-
 sound/firewire/tascam/tascam-stream.c |  5 +++--
 sound/firewire/tascam/tascam.h        |  3 ++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 6cd3a420fbdf..b18664fdf955 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -66,6 +66,7 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	// at current one.
 	if (clock != SND_TSCM_CLOCK_INTERNAL || tscm->substreams_counter > 0) {
 		unsigned int frames_per_period = d->events_per_period;
+		unsigned int frames_per_buffer = d->events_per_buffer;
 		unsigned int rate;
 
 		err = snd_tscm_stream_get_rate(tscm, &rate);
@@ -83,6 +84,14 @@ static int pcm_open(struct snd_pcm_substream *substream)
 			mutex_unlock(&tscm->mutex);
 			goto err_locked;
 		}
+
+		err = snd_pcm_hw_constraint_minmax(substream->runtime,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					frames_per_buffer, frames_per_buffer);
+		if (err < 0) {
+			mutex_unlock(&tscm->mutex);
+			goto err_locked;
+		}
 	}
 
 	mutex_unlock(&tscm->mutex);
@@ -118,10 +127,11 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		unsigned int rate = params_rate(hw_params);
 		unsigned int frames_per_period = params_period_size(hw_params);
+		unsigned int frames_per_buffer = params_buffer_size(hw_params);
 
 		mutex_lock(&tscm->mutex);
 		err = snd_tscm_stream_reserve_duplex(tscm, rate,
-						     frames_per_period);
+					frames_per_period, frames_per_buffer);
 		if (err >= 0)
 			++tscm->substreams_counter;
 		mutex_unlock(&tscm->mutex);
diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 1e4d44ed8bed..a9b3b7eb6d21 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -384,7 +384,8 @@ void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm)
 }
 
 int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate,
-				   unsigned int frames_per_period)
+				   unsigned int frames_per_period,
+				   unsigned int frames_per_buffer)
 {
 	unsigned int curr_rate;
 	int err;
@@ -416,7 +417,7 @@ int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate,
 		}
 
 		err = amdtp_domain_set_events_per_period(&tscm->domain,
-							frames_per_period, 0);
+					frames_per_period, frames_per_buffer);
 		if (err < 0) {
 			fw_iso_resources_free(&tscm->tx_resources);
 			fw_iso_resources_free(&tscm->rx_resources);
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 32e72a25bf46..78b7a08986a1 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -169,7 +169,8 @@ int snd_tscm_stream_init_duplex(struct snd_tscm *tscm);
 void snd_tscm_stream_update_duplex(struct snd_tscm *tscm);
 void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm);
 int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate,
-				   unsigned int frames_per_period);
+				   unsigned int frames_per_period,
+				   unsigned int frames_per_buffer);
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate);
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
