Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A561EC47404
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:09:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC9A21655
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uimlfF6L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="p/qED/2M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibYK1Wfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC9A21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7034D166C;
	Mon,  7 Oct 2019 13:08:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7034D166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570446570;
	bh=MgPGv0MR5UA+/G9v3j4svbD3yJNvbnRUSEaYnbv4zWM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uimlfF6LF1c7lzshQQYLw2IWa9KI/0ehx33BFr2d1KX/tgD/whw2Smb/ClmKMeKKZ
	 tkkxHgLQ5fu3VpZX+Dq/Pp1S0DRfBfai3S4ZC7uzbh+y/WDAT9ZkQEImdIQyn8QslE
	 c2Z1DNkKLi2hST6QzAUZQgqF42Vc+oE0sM1UyoRU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE018F80612;
	Mon,  7 Oct 2019 13:05:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB29EF8059F; Mon,  7 Oct 2019 13:05:47 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CEA7F802BE
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 13:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CEA7F802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="p/qED/2M"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ibYK1Wfo"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A790921B10;
 Mon,  7 Oct 2019 07:05:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 07 Oct 2019 07:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=IIeO3UYHE8au8
 XI8/dlOKJsX45sE2ywge3ODNfnKvC8=; b=p/qED/2M2TVOz9gYUNMk8he90OWwD
 22oC+QWw7ELJyY9tzWYhhp1i4o3VAnhyJnhEUmxqn+Qz5W2TQPkTgJEN2xEj06pD
 f3ObrIXDITrjc1VCOq4bM5i0n7hMNWJR8DU9EQ4Wc6dR+WVaKw5iBv7J6dq2VAy+
 0ZNFQvvgFRHeahDgGl1oIEad4D01+G3Fu98vGr6h8Pu1Lz0BmFyQ+nV4RIWv+5u3
 JhNVOMLXouE/csxWouDHmED6m12HNK+/8YkzvYNJ4Y1spvbeS3cPtz+CJ/TZ9kKx
 TWaZ+M26zM6kCovD1/z3e8E2GwQPDUjTZXYDRCpF25cQs3zUIxZV0cDYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=IIeO3UYHE8au8XI8/dlOKJsX45sE2ywge3ODNfnKvC8=; b=ibYK1Wfo
 r0yrAIAnJCy8NQ4HHuukRBogHPDtXntPxYBG+Vn0gsXU1etS+EiRk4q671UkewpI
 T1zStL6kvYQRVkggFoJ7Zvfn3k4mO8IPksylmOIkiFS8ymDxI61yWtn3T4ax0ZRD
 hWOqUmU+H+/7uDGWrdZ2fUpjYg1mUpAAW276ZwaiuETr5aHb0uOJwBMfI6fn168D
 tU5ED0kz1mBntEdebjezlZTgIYjvbnD2SowHXCKQqvx90u/VGzsJaLVcr4JVyEUk
 JSD/CVdsXhxZA3UTXs0aCT1HbkN3nqVx8NDVrg7erWVM2pPDvjWPrEkGdPiAttsH
 iWPMLrkuHGtVXw==
X-ME-Sender: <xms:BhybXa0o43FikqaH1wbRNxlkzrP9dTJtZq6zPTKdH0jewY7K0T38XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheejgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:BhybXRW15LrkWIJK2ZP1u9hTK2FmkPuDx3NRWthZg2WeIGGXKYx32w>
 <xmx:BhybXd7kGPVWtnz9Xz8809r2WqDMITC6uVOjkPmmHhoTM14wwk8Dww>
 <xmx:BhybXQLw30jYMg7elHYsQBoGYUjkavtxb0-cw-rQB6H3Alo4-iL-5A>
 <xmx:BhybXWKjYNSx-XFvlko1swvfE14GcRfquBmYpKfrNXAH9yEaLBmy0A>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2EB6E8005B;
 Mon,  7 Oct 2019 07:05:40 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Mon,  7 Oct 2019 20:05:19 +0900
Message-Id: <20191007110532.30270-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007110532.30270-1-o-takashi@sakamocchi.jp>
References: <20191007110532.30270-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 04/17] oxfw: register the size of PCM period to
	AMDTP domain
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

This commit is a preparation to share the size of PCM period between
PCM substreams on AMDTP streams in the same domain. At this time,
the size of PCM period in PCM substream which starts AMDTP streams in the
same domain is recorded.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c   |  4 ++--
 sound/firewire/oxfw/oxfw-pcm.c    |  6 ++++--
 sound/firewire/oxfw/oxfw-stream.c | 12 +++++++++++-
 sound/firewire/oxfw/oxfw.h        |  3 ++-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 9bdec08cb8ea..72db7a17d0ad 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -18,7 +18,7 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream, 0, 0);
+	err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream, 0, 0, 0);
 	if (err >= 0) {
 		++oxfw->substreams_count;
 		err = snd_oxfw_stream_start_duplex(oxfw);
@@ -45,7 +45,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->rx_stream, 0, 0);
+	err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->rx_stream, 0, 0, 0);
 	if (err >= 0) {
 		++oxfw->substreams_count;
 		err = snd_oxfw_stream_start_duplex(oxfw);
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 7c6d1c277d4d..2d1b5038f7f6 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -221,10 +221,11 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		unsigned int rate = params_rate(hw_params);
 		unsigned int channels = params_channels(hw_params);
+		unsigned int frames_per_period = params_period_size(hw_params);
 
 		mutex_lock(&oxfw->mutex);
 		err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->tx_stream,
-						     rate, channels);
+					rate, channels, frames_per_period);
 		if (err >= 0)
 			++oxfw->substreams_count;
 		mutex_unlock(&oxfw->mutex);
@@ -246,10 +247,11 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		unsigned int rate = params_rate(hw_params);
 		unsigned int channels = params_channels(hw_params);
+		unsigned int frames_per_period = params_period_size(hw_params);
 
 		mutex_lock(&oxfw->mutex);
 		err = snd_oxfw_stream_reserve_duplex(oxfw, &oxfw->rx_stream,
-						     rate, channels);
+					rate, channels, frames_per_period);
 		if (err >= 0)
 			++oxfw->substreams_count;
 		mutex_unlock(&oxfw->mutex);
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 3c9a796b6526..7d2e88c5b73d 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -244,7 +244,8 @@ static int keep_resources(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 
 int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 				   struct amdtp_stream *stream,
-				   unsigned int rate, unsigned int pcm_channels)
+				   unsigned int rate, unsigned int pcm_channels,
+				   unsigned int frames_per_period)
 {
 	struct snd_oxfw_stream_formation formation;
 	enum avc_general_plug_dir dir;
@@ -305,6 +306,15 @@ int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 				return err;
 			}
 		}
+
+		err = amdtp_domain_set_events_per_period(&oxfw->domain,
+							frames_per_period);
+		if (err < 0) {
+			cmp_connection_release(&oxfw->in_conn);
+			if (oxfw->has_output)
+				cmp_connection_release(&oxfw->out_conn);
+			return err;
+		}
 	}
 
 	return 0;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index c9627b8c5d6e..422746ef2439 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -103,7 +103,8 @@ int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
 int snd_oxfw_stream_init_duplex(struct snd_oxfw *oxfw);
 int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 				   struct amdtp_stream *stream,
-				   unsigned int rate, unsigned int pcm_channels);
+				   unsigned int rate, unsigned int pcm_channels,
+				   unsigned int frames_per_period);
 int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
