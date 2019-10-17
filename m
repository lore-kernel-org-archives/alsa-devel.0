Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C68DFA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:59:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D87921835
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VUu3c5rT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Yow0CsRz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDPIa3vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D87921835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF2D416A4;
	Thu, 17 Oct 2019 17:58:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF2D416A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571327954;
	bh=PofDiqtg6kDAS1ecb3O/n3Aa3tRE9nhpNZYJqSRbxxg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUu3c5rTKyokNsyTcqAW9yUJczI7bm+08V6+U2lm6bsYNOZE0VEAKt3fh2pKPFkkD
	 NDwVkWl+u2rn9C3Is79OCfU8tonGiHGCfHhzXLHNVXXtUTrV4jQ+l1Oajg5ynuaVRV
	 0P6AhsGqPHgnrpIKb9MUDMlXj+CQHnynoRDjAGFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 103EAF8063D;
	Thu, 17 Oct 2019 17:54:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9292F805FA; Thu, 17 Oct 2019 17:54:44 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B90B9F80528
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 17:54:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B90B9F80528
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Yow0CsRz"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="vDPIa3vD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id E69FB502;
 Thu, 17 Oct 2019 11:54:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 17 Oct 2019 11:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=Luo7wp0mzmu1D
 XMXtLkGA8Y4WNW3VXXqE5HNaG0V8ks=; b=Yow0CsRztSJK5E3wJn+rKtLZ/Y0VT
 Hx4YXE+mMbduNWoaeKZ7MHS/+7GJvndhvsQH9QJbmsRjc8kWEEcuwYMok1MjAv7k
 SPkKif+PDzV04UJnq30StWtNF6kvjZxRT2bCLLlL3bxaxbKrKogNAEFAYVqr5vxV
 rTyiQlcC+uTtPHYEkA4v1Ga5HnDJN6iQjyd0Q7Oh/lNXpvJSj1u2OudociBWbMGo
 ohuO++g46KMGIUi4ANHYXn571iUmF5uqvIYAkRFz0idXrAi129B1KE+uNtnLkOyT
 aGxjpSNlCCpKyb2kkUPFdRg10k1TCbATt2H4xbyRYzm1DbhO0fFKUDw0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Luo7wp0mzmu1DXMXtLkGA8Y4WNW3VXXqE5HNaG0V8ks=; b=vDPIa3vD
 ODxetDmaw9XpK/0XivGR/TyrIxr0WELmAlStnyqsbM1ZQJr8nf81fqlAbR6sk20D
 L/Q2okssRGVOuA5Rj2MfNMvl0v5FLnYUwOjGoGahd7u/J4AI6tcuQd8Y8CU07sJG
 L6AY0QcZIXs/AQ12XInFiMPUNgJhBYAX7BXMafMH5c0hxJZ+5TV9KZVqbENDo7ka
 ofsnMyJ9hFhX/rBKQbJ9WY/HViNoPBVHM9N//jCQR7GQMysIrM9BSwT4sA5DWElb
 ZyojCwzxmu5SFvA02Z057ACLQ7zgxIrb/3aqIu7Uclyoz6yNDyBTiYcvj42OlvWG
 LZVHz/Ov5+53CQ==
X-ME-Sender: <xms:vY6oXR5MhfkgVdPvGH_t9ttxt_qYP1vgK9BWX-ALxILe337qjBhrFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdelgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:vY6oXecivS5c8qp7NsVcAbskg5cofaz8fUkziC4iEe8CXJfZu3TOaQ>
 <xmx:vY6oXbdGxIfTJu-rpATrgsSoHRIuQPuxpkn60PR7sXmbVbGLcUV_yg>
 <xmx:vY6oXWJ8EFHEs1VyUepoxsmtlLkMfegSXLFmLk_IPjncvTQ8BU-gXA>
 <xmx:vY6oXZjCtbmzADvy5LtEio6xvfpeFxERbUHpkTtfeB14OEPbwfVOlg>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1EEAC80064;
 Thu, 17 Oct 2019 11:54:35 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Fri, 18 Oct 2019 00:54:17 +0900
Message-Id: <20191017155424.885-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017155424.885-1-o-takashi@sakamocchi.jp>
References: <20191017155424.885-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 05/12] ALSA: dice: share PCM buffer size for
	both direction
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

This commit allows ALSA dice driver to share PCM buffer size for both
capture and playback PCM substream. When AMDTP domain starts for one
of the PCM substream, buffer size of the PCM substream is stores to
AMDTP domain structure. Some AMDTP streams have already run with the
buffer size when another PCM substream starts, therefore the PCM
substream has a constraint to its buffer size.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c   |  2 +-
 sound/firewire/dice/dice-pcm.c    | 20 +++++++++++++++++---
 sound/firewire/dice/dice-stream.c |  5 +++--
 sound/firewire/dice/dice.h        |  3 ++-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index 69c3c06bd7aa..4c2998034313 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -17,7 +17,7 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 
 	mutex_lock(&dice->mutex);
 
-	err = snd_dice_stream_reserve_duplex(dice, 0, 0);
+	err = snd_dice_stream_reserve_duplex(dice, 0, 0, 0);
 	if (err >= 0) {
 		++dice->substreams_counter;
 		err = snd_dice_stream_start_duplex(dice);
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 813c9ffbeced..7c0c34c5bd47 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -204,6 +204,7 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (!internal ||
 	    (dice->substreams_counter > 0 && d->events_per_period > 0)) {
 		unsigned int frames_per_period = d->events_per_period;
+		unsigned int frames_per_buffer = d->events_per_buffer;
 		unsigned int rate;
 
 		err = snd_dice_transaction_get_rate(dice, &rate);
@@ -217,8 +218,10 @@ static int pcm_open(struct snd_pcm_substream *substream)
 
 		if (frames_per_period > 0) {
 			// For double_pcm_frame quirk.
-			if (rate > 96000)
+			if (rate > 96000) {
 				frames_per_period *= 2;
+				frames_per_buffer *= 2;
+			}
 
 			err = snd_pcm_hw_constraint_minmax(substream->runtime,
 					SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
@@ -227,6 +230,14 @@ static int pcm_open(struct snd_pcm_substream *substream)
 				mutex_unlock(&dice->mutex);
 				goto err_locked;
 			}
+
+			err = snd_pcm_hw_constraint_minmax(substream->runtime,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					frames_per_buffer, frames_per_buffer);
+			if (err < 0) {
+				mutex_unlock(&dice->mutex);
+				goto err_locked;
+			}
 		}
 	}
 
@@ -263,13 +274,16 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
 		unsigned int rate = params_rate(hw_params);
 		unsigned int events_per_period = params_period_size(hw_params);
+		unsigned int events_per_buffer = params_buffer_size(hw_params);
 
 		mutex_lock(&dice->mutex);
 		// For double_pcm_frame quirk.
-		if (rate > 96000)
+		if (rate > 96000) {
 			events_per_period /= 2;
+			events_per_buffer /= 2;
+		}
 		err = snd_dice_stream_reserve_duplex(dice, rate,
-						     events_per_period);
+					events_per_period, events_per_buffer);
 		if (err >= 0)
 			++dice->substreams_counter;
 		mutex_unlock(&dice->mutex);
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index b4ef08bd7e8f..0cff346e8052 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -279,7 +279,8 @@ static void finish_session(struct snd_dice *dice, struct reg_params *tx_params,
 }
 
 int snd_dice_stream_reserve_duplex(struct snd_dice *dice, unsigned int rate,
-				   unsigned int events_per_period)
+				   unsigned int events_per_period,
+				   unsigned int events_per_buffer)
 {
 	unsigned int curr_rate;
 	int err;
@@ -327,7 +328,7 @@ int snd_dice_stream_reserve_duplex(struct snd_dice *dice, unsigned int rate,
 			goto error;
 
 		err = amdtp_domain_set_events_per_period(&dice->domain,
-							 events_per_period, 0);
+					events_per_period, events_per_buffer);
 		if (err < 0)
 			goto error;
 	}
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 1f9e3502974e..16366773e22e 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -211,7 +211,8 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice);
 int snd_dice_stream_init_duplex(struct snd_dice *dice);
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice);
 int snd_dice_stream_reserve_duplex(struct snd_dice *dice, unsigned int rate,
-				   unsigned int events_per_period);
+				   unsigned int events_per_period,
+				   unsigned int events_per_buffer);
 void snd_dice_stream_update_duplex(struct snd_dice *dice);
 int snd_dice_stream_detect_current_formats(struct snd_dice *dice);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
