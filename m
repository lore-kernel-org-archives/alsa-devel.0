Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC31C3DA41
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:26:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56BC0162E;
	Tue,  9 Jul 2024 18:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56BC0162E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720542387;
	bh=IsHmVPzLjPkAVsbqXgHAlk8fnDVQz3z3/FukJoWyMR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C9VT53uXl/dWW6wB3VZCOmpKezb0dB+GZF/MOunnraHevylu4juQUiDWnVPd7gXAg
	 3TQbPB0hdcbVC5QFFaqk/7v8TkINUNhJ4MWanNtT5J0aSrMS8nd1H/AII9EQIECj4f
	 /v5DC69ZsYin9pnjSKuQrolUqG4nc1NBEoR/pHTw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53665F80694; Tue,  9 Jul 2024 18:24:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72206F8068E;
	Tue,  9 Jul 2024 18:24:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD868F804FC; Tue,  9 Jul 2024 18:24:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 147EEF8019B
	for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2024 18:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 147EEF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZEygT3MS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3A8D9614DC;
	Tue,  9 Jul 2024 16:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10DEC4AF0B;
	Tue,  9 Jul 2024 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542258;
	bh=IsHmVPzLjPkAVsbqXgHAlk8fnDVQz3z3/FukJoWyMR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEygT3MS8/nNy8BR1hXf3nmKZmXxKC8J3SMiYsQ6q/QeiteQ7JUvPaxqBATlbUNNT
	 KaCgr7caIayia/lE/vBDXllraqMCf3vvn8G6dh7gRMic3nP19YWrxlr/y39uNPU2Wf
	 scjdTzTNxUzKkoAT0UcUTDsKrk/Vp51NCu94igmGl4G1hmjKJB/u7oTCQrGeGNlAlT
	 bmuB95Z42nOmnF5+yrjwfvjMQo3cpwsyqLYQBwaphYIbJ9DLttPAkWhyirHPHwbbJk
	 KIwRvmMu+mVHAuBoZBdFQzHZnCG4zX9BDpILPERf6Gv+EJ3cfWuba553/KJO3eNDcp
	 eEAeEzaNRtTjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jai Luthra <j-luthra@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/27] ASoC: ti: davinci-mcasp: Set min period
 size using FIFO config
Date: Tue,  9 Jul 2024 12:23:22 -0400
Message-ID: <20240709162401.31946-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SAYZCBU3CI642PHQEMTVKEXLIY5FS7V3
X-Message-ID-Hash: SAYZCBU3CI642PHQEMTVKEXLIY5FS7V3
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SAYZCBU3CI642PHQEMTVKEXLIY5FS7V3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jai Luthra <j-luthra@ti.com>

[ Upstream commit c5dcf8ab10606e76c1d8a0ec77f27d84a392e874 ]

The minimum period size was enforced to 64 as older devices integrating
McASP with EDMA used an internal FIFO of 64 samples.

With UDMA based platforms this internal McASP FIFO is optional, as the
DMA engine internally does some buffering which is already accounted for
when registering the platform. So we should read the actual FIFO
configuration (txnumevt/rxnumevt) instead of hardcoding frames.min to
64.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20240611-asoc_next-v3-2-fcfd84b12164@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 4edf5b27e136b..c6ef8f92b25f1 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1472,10 +1472,11 @@ static int davinci_mcasp_hw_rule_min_periodsize(
 {
 	struct snd_interval *period_size = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	u8 numevt = *((u8 *)rule->private);
 	struct snd_interval frames;
 
 	snd_interval_any(&frames);
-	frames.min = 64;
+	frames.min = numevt;
 	frames.integer = 1;
 
 	return snd_interval_refine(period_size, &frames);
@@ -1490,6 +1491,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	u32 max_channels = 0;
 	int i, dir, ret;
 	int tdm_slots = mcasp->tdm_slots;
+	u8 *numevt;
 
 	/* Do not allow more then one stream per direction */
 	if (mcasp->substreams[substream->stream])
@@ -1589,9 +1591,12 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			 &mcasp->txnumevt :
+			 &mcasp->rxnumevt;
 	snd_pcm_hw_rule_add(substream->runtime, 0,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-			    davinci_mcasp_hw_rule_min_periodsize, NULL,
+			    davinci_mcasp_hw_rule_min_periodsize, numevt,
 			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 
 	return 0;
-- 
2.43.0

